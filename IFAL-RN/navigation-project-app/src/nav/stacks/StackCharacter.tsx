import { createStackNavigator } from "@react-navigation/stack";
import CharacterDetail from "../../pages/character/CharacterDetail";
import CharacterList from "../../pages/character/CharacterList";
import { StackCharacterParams } from "../types/stack-character-params";

const screenOptionStyle = {
  headerStyle: {
    backgroundColor: "#08C952",
  },
  headerTintColor: "white",
  headerBackTitle: "Voltar",
};

const Stack = createStackNavigator<StackCharacterParams>();

const StackCharacter = () => {
  return (
    <Stack.Navigator screenOptions={screenOptionStyle}>
      <Stack.Screen name="Personagens" component={CharacterList} />
      <Stack.Screen
        name="DetalhePersonagem"
        component={CharacterDetail}
        options={{
          title: 'Personagem'
        }}
      />
    </Stack.Navigator>
  );
}

export default StackCharacter;