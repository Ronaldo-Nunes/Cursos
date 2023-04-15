import React from "react";
import { AntDesign } from '@expo/vector-icons';
import { Ionicons } from '@expo/vector-icons';
import { MaterialIcons } from '@expo/vector-icons';
import CharacterList from "../pages/character/CharacterList";
import { BottomTabNavigationOptions, createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import StackCharacter from "./stacks/StackCharacter";
import StackEpisode from "./stacks/StackEpisodes";

const tabOptions: BottomTabNavigationOptions = {
  tabBarLabelStyle: { fontSize: 14 },
  tabBarActiveTintColor: '#08C952',
  tabBarInactiveTintColor: 'gray',
  headerShown: false
};
const Tab = createBottomTabNavigator();

const TabNavigator = () => {
  return (
    <Tab.Navigator>
      <Tab.Screen
        name="Personagens"
        component={StackCharacter}
        // initialParams={{ url: 'https://api.example.com/list1' }}
        options={{
          tabBarLabel: 'Personagens',
          tabBarIcon({ color, size }) {
            return <AntDesign name="team" size={size} color={color} />
          },
          ...tabOptions
        }}
      />
      <Tab.Screen
        name="Episódios"
        component={StackEpisode}
        // initialParams={{ url: 'https://api.example.com/list2' }}
        options={{
          tabBarLabel: 'Episódios',
          tabBarIcon({ color, size }) {
            return <MaterialIcons name="featured-play-list" size={size} color={color} />            
          },
          ...tabOptions
        }}
      />
      <Tab.Screen
        name="Localizações"
        component={CharacterList}
        // initialParams={{ url: 'https://api.example.com/list3' }}
        options={{
          tabBarLabel: 'Localizações',
          tabBarIcon({ color, size }) {
            return <Ionicons name="ios-planet-sharp" size={size} color={color} />
          },
          ...tabOptions
        }}
      />
    </Tab.Navigator>
  );
}

export default TabNavigator;
