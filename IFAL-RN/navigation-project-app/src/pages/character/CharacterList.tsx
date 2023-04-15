import React, { useEffect, useState } from "react";
import { FlatList, View, Text, StyleSheet } from 'react-native';
import { StackNavigationProp } from "@react-navigation/stack";
import { StackCharacterParams } from "../../nav/types/stack-character-params";
import { CharacterItem } from "../../model/character/character-list-item";
import { CharacterService } from "../../service/character.service";
import CharacterListItem from "../../components/CharacterListItem";
import SearchBar from "../../components/SearchBar";

type CharacterListProps = {
  navigation: StackNavigationProp<StackCharacterParams>;
};

const CharacterList = ({ navigation }: CharacterListProps) => {
  const [buscaNome, setBuscaNome] = useState<string>();
  const [mensagem, setMensagem] = useState<string>();
  const [personagens, setPersonagens] = useState<CharacterItem[]>([]);

  const buscarPersonagem = () => {
    CharacterService.getByName(buscaNome)
      .then((itens) => {
        if (itens.length === 0) {
          setMensagem('Nenhum registro encontrado')
        }
        setMensagem(undefined);
        setPersonagens(itens);
      })
      .catch(error => {
        console.log(error);
        setMensagem(error?.message);
      });
  };

  const navegarParaDetalhe = (id: number) => {
    navigation.navigate('DetalhePersonagem', { id });
  }

  useEffect(() => {
    if (buscaNome === undefined || buscaNome.length === 0) {
      CharacterService.getAll()
        .then((itens) => {
          if (itens.length === 0) {
            setMensagem('Nenhum registro encontrado')
          }
          setMensagem(undefined);
          setPersonagens(itens);
        })
        .catch(error => {
          console.log(error);
          setMensagem(error?.message);
        });
    }
  }, [buscaNome]);

  return (
    <View style={{ flex: 1, alignItems: 'stretch' }}>
      <View >
        <SearchBar
          placeholder="Nome do personagem"
          value={buscaNome}
          onChangeText={(text) => setBuscaNome(text)}
          onStartSearch={buscarPersonagem}
        />
      </View>
      <View style={styles.listContainer}>
        {(mensagem && personagens.length === 0) && <View style={styles.msgContainer}>
          <Text>{mensagem}</Text>
        </View>}
        <FlatList
          data={personagens}
          renderItem={({ item }) => <CharacterListItem item={item} onPress={(id) => navegarParaDetalhe(id)} />}
          keyExtractor={item => item.id.toString()}
          overScrollMode='never'
          style={styles.list}
        />
      </View>
    </View>
  );
}

export default CharacterList;


const styles = StyleSheet.create({
  listContainer: {
    flex: 1
  },
  msgContainer: {
    flex: 1,
    alignItems: 'center'
  },
  list: {
    flex: 1,
    marginStart: 16
  }
})