import { createStackNavigator } from "@react-navigation/stack";
import { StackEpisodeParams } from "../types/stack-episode-params";
import EpisodeDetail from "../../pages/episode/EpisodeDetail";
import EpisodeList from "../../pages/episode/EpisodeList";

const screenOptionStyle = {
  headerStyle: {
    backgroundColor: "#08C952",
  },
  headerTintColor: "white",
  headerBackTitle: "Voltar",
};

const Stack = createStackNavigator<StackEpisodeParams>();

const StackEpisode = () => {
  return (
    <Stack.Navigator screenOptions={screenOptionStyle}>
      <Stack.Screen
        name="Episodios"
        component={EpisodeList}
        options={{
          title: 'Episódios'
        }}
      />
      <Stack.Screen
        name="DetalheEpisodio"
        component={EpisodeDetail}
        options={{
          title: 'Episódio'
        }}
      />
    </Stack.Navigator>
  );
}

export default StackEpisode;