import React, { useEffect, useState } from "react";
import { View, Text, StyleSheet } from "react-native";
import { RouteProp } from "@react-navigation/native";
import { StackEpisodeParams } from "../../nav/types/stack-episode-params";
import { EpisodeService } from "../../service/episode.service";
import { Episode } from "../../model/episode/episode";

type DetailsScreenProps = {
  route: RouteProp<StackEpisodeParams, 'DetalheEpisodio'>;
};


const EpisodeDetail = ({ route }: DetailsScreenProps) => {
  const { id } = route.params;
  const [episodio, setepisodio] = useState<Episode>();
  const [statusStyle, setStatusStyle] = useState({});
  const [icon, setIcon] = useState<JSX.Element | null>();
  const [erro, setErro] = useState<string>();

  const exibirepisodio = () => {
    EpisodeService.getById(id)
      .then(pers => {
        setepisodio(pers);
      })
      .catch(error => {
        console.error(error);
        setErro(error?.message);
      });
  }

  useEffect(() => {
    exibirepisodio();
  }, [id]);

  return (
    <View style={styles.rootContainer}>
      <View style={styles.containerEpisode}>
        <Text style={styles.name}>{`${episodio?.episode} - ${episodio?.name}`}</Text>
        {/* <Text style={styles.name}>{episodio?.name}</Text> */}
        <Text style={styles.infos}>{`Data de exibição: ${episodio?.air_date}`}</Text>
      </View>
      <View style={{ marginHorizontal: 16 }}>
      </View>
    </View>
  );
}

export default EpisodeDetail;


const styles = StyleSheet.create({
  rootContainer: {
    flex: 1,
  },
  containerEpisode: {
    alignItems: 'center'
  },
  containerIcon: {
    flexDirection: 'row',
    alignItems: 'center',
    margin: 16
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

})