import React, { useEffect, useState } from "react";
import { FlatList, View, Text, StyleSheet } from 'react-native';
import { StackNavigationProp } from "@react-navigation/stack";
import EpisodeListItem from "../../components/EpisodeListItem";
import SearchBar from "../../components/SearchBar";
import { EpisodeService } from "../../service/episode.service";
import { EpisodeItem } from "../../model/episode/episode-list-item";
import { StackEpisodeParams } from "../../nav/types/stack-episode-params";

type EpisodeListProps = {
  navigation: StackNavigationProp<StackEpisodeParams>;
};

const EpisodeList = ({ navigation }: EpisodeListProps) => {
  const [buscaNome, setBuscaNome] = useState<string>();
  const [mensagem, setMensagem] = useState<string>();
  const [personagens, setPersonagens] = useState<EpisodeItem[]>([]);

  const buscarPersonagem = () => {
    EpisodeService.getByName(buscaNome)
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
    navigation.navigate('DetalheEpisodio', { id });
  }

  useEffect(() => {
    if (buscaNome === undefined || buscaNome.length === 0) {
      EpisodeService.getAll()
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
          placeholder="Nome do episódio"
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
          renderItem={({ item }) => <EpisodeListItem item={item} onPress={(id) => navegarParaDetalhe(id)} />}
          keyExtractor={item => item.id.toString()}
          overScrollMode='never'
          style={styles.list}
        />
      </View>
    </View>
  );
}

export default EpisodeList;


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