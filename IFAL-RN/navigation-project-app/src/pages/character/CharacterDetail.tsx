import React, { useEffect, useState } from "react";
import { View, Text, Image, StyleSheet } from "react-native";
import { RouteProp } from "@react-navigation/native";
import { Ionicons } from '@expo/vector-icons';
import { AntDesign } from '@expo/vector-icons';
import { StackCharacterParams } from "../../nav/types/stack-character-params";
import { CharacterService } from "../../service/character.service";
import { Character } from "../../model/character/character";

const getStyleByStatus = (status: string) => {
  switch (status) {
    case 'Alive':
      return styles.aliveStatus;
    case 'Dead':
      return styles.deadStatus;
    case 'unknown':
      return styles.unknownStatus;
    default:
      return styles.infos;
  }
};

const getIconByStatus = (status: string) => {
  switch (status) {
    case 'Alive':
      return <Ionicons name="heart" size={16} color="green" />;
    case 'Dead':
      return <Ionicons name="md-skull-sharp" size={16} color="red" />;
    case 'unknown':
      return <AntDesign name="questioncircle" size={16} color="#393646" />;
    default:
      return null;
  }
};

type DetailsScreenProps = {
  route: RouteProp<StackCharacterParams, 'DetalhePersonagem'>;
};


const CharacterDetail = ({ route }: DetailsScreenProps) => {
  const { id } = route.params;
  const [personagem, setPersonagem] = useState<Character>();
  const [statusStyle, setStatusStyle] = useState({});
  const [icon, setIcon] = useState<JSX.Element | null>();
  const [erro, setErro] = useState<string>();

  const exibirPersonagem = () => {
    CharacterService.getById(id)
      .then(pers => {
        setPersonagem(pers);
        setStatusStyle(getStyleByStatus(pers.status));
        setIcon(getIconByStatus(pers.status));
      })
      .catch(error => {
        console.error(error);
        setErro(error?.message);
      });
  }

  useEffect(() => {
    exibirPersonagem();
  }, [id]);

  return (
    <View style={styles.rootContainer}>
      <View style={styles.containerImage}>
        <Image
          source={{ uri: personagem?.image }}
          style={styles.image}
          resizeMode="contain"
        />
        <Text style={styles.name}>{personagem?.name}</Text>
      </View>

      <View style={styles.containerIcon}>
        <Text>Status: </Text>
        <Text style={statusStyle}>{personagem?.status}</Text>
        {icon}
      </View>
      <View style={{ marginHorizontal: 16 }}>
        <Text style={styles.infos}>{`Espécie: ${personagem?.species}`}</Text>
        <Text style={styles.infos}>{`Gênero: ${personagem?.gender}`}</Text>
        <Text style={styles.infos}>{`Origem: ${personagem?.origin.name}`}</Text>
        <Text style={styles.infos}>{`Localização: ${personagem?.location.name}`}</Text>
      </View>
    </View>
  );
}

export default CharacterDetail;


const styles = StyleSheet.create({
  rootContainer: {
    flex: 1,
  },
  containerImage: {
    alignItems: 'center'
  },
  containerIcon: {
    flexDirection: 'row',
    alignItems: 'center',
    margin: 16
  },
  image: {
    width: '100%',
    height: 300,
    borderRadius: 1,
  },
  name: {
    fontSize: 24,
    fontWeight: 'bold',
    marginTop: 8,
    color: '#011C0C'
  },
  infos: {
    fontSize: 16,
    color: '#454545',
    marginBottom: 4
  },
  aliveStatus: {
    marginEnd: 4,
    fontSize: 16,
    color: 'green'
  },
  deadStatus: {
    marginEnd: 4,
    fontSize: 16,
    color: 'red'
  },
  unknownStatus: {
    marginEnd: 4,
    fontSize: 16,
    color: '#393646',
  },

})