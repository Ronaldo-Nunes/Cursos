import React from "react";
import { View, Text, StyleSheet, TouchableOpacity, Image } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { AntDesign } from '@expo/vector-icons';
import { CharacterItem } from "../model/character/character-list-item";

interface ListItemProps {
  item: CharacterItem;
  onPress: (id: number) => void;
}

const getStyleByStatus = (status: string) => {
  switch (status) {
    case 'Alive':
      return styles.aliveStatus;
    case 'Dead':
      return styles.deadStatus;
    case 'unknown':
      return styles.unknownStatus;
    default:
      return styles.status;
  }
};

const getIconByStatus = (status: string) => {
  switch (status) {
    case 'Alive':
      return <Ionicons name="heart" size={14} color="green" />;
    case 'Dead':
      return <Ionicons name="md-skull-sharp" size={14} color="red" />;
    case 'unknown':
      return <AntDesign name="questioncircle" size={14} color="#393646" />;
    default:
      return null;
  }
};

const CharacterListItem = ({ item, onPress }: ListItemProps) => {
  const statusStyle = getStyleByStatus(item.status);
  const icon = getIconByStatus(item.status);
  return (
    <TouchableOpacity onPress={() => onPress(item.id)} style={styles.container}>
      <Image style={styles.image} source={{ uri: item.image }} />
      <View style={styles.detailsContainer}>
        <Text style={styles.name}>{item.name}</Text>
        <Text style={styles.status}>{item.species}</Text>
        {item.type && <Text style={styles.type}>{`Tipo: ${item.type}`}</Text>}
      </View>
      <View style={styles.iconContainer}>
        {icon}
        <Text style={statusStyle}>{item.status}</Text>
      </View>
    </TouchableOpacity>
  );
}

export default CharacterListItem;


const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 16,
    paddingHorizontal: 8,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: '#ccc',
  },
  image: {
    width: 64,
    height: 64,
    borderRadius: 8,
    marginRight: 16,
  },
  detailsContainer: {
    flex: 1,
  },
  iconContainer: {
    alignItems: 'center',
    marginEnd: 16,
  },
  name: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 4,
  },
  status: {
    fontSize: 14,
    color: 'gray',
    marginEnd: 16,
  },
  aliveStatus: {
    fontSize: 14,
    color: 'green'
  },
  deadStatus: {
    fontSize: 14,
    color: 'red'
  },
  unknownStatus: {
    fontSize: 14,
    color: '#393646',
  },
  type: {
    fontSize: 14,
    color: 'gray',
  },
});