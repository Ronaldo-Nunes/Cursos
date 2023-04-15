import React from "react";
import { TouchableOpacity, View, Text, StyleSheet } from "react-native";
import { Fontisto } from '@expo/vector-icons';
import { EpisodeItem } from "../model/episode/episode-list-item";

interface ListItemProps {
  item: EpisodeItem;
  onPress: (id: number) => void;
}

const EpisodeListItem = ({ item, onPress }: ListItemProps) => {
  return (
    <TouchableOpacity onPress={() => onPress(item.id)} style={styles.container}>
      <View style={styles.detailsContainer}>
        <Text style={styles.episodio}>{item.episode}</Text>
        <Text style={styles.name}>{item.name}</Text>
        <View style={styles.containerIcon}>
          <Fontisto name="date" size={14} color="gray" />
          <Text style={styles.date}>{item.air_date}</Text>
        </View>
      </View>
    </TouchableOpacity>
  );
}


export default EpisodeListItem;

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 16,
    paddingHorizontal: 8,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: '#ccc',
  },
  detailsContainer: {
    flex: 1,
  },
  containerIcon: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  episodio: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 4,
  },
  name: {
    fontSize: 14,
    color: '#454545',
  },
  date: {
    fontSize: 14,
    color: 'gray',
    marginStart: 4
  }
});