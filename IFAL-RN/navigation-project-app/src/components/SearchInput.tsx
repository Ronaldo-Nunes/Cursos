
import React from "react";
import { TextInput, View, StyleSheet, Image } from 'react-native';

interface InputProps {
  placeHolder: string;
  value?: string;
  onChangeQuery: (text?: string) => void;
}
const SearchInput = ({ placeHolder, value, onChangeQuery }: InputProps) => {
  return (
    <View style={styles.sectionStyle}>
      <Image
        source={require('../imgs/search.png')}
        style={styles.imageStyle}
      />
      <TextInput
        style={{ flex: 1 }}
        placeholder={placeHolder}
        underlineColorAndroid="transparent"
        onChangeText={(text) => onChangeQuery(text)}
        value={value}
      />
    </View>
  );
}

export default SearchInput;

const styles = StyleSheet.create({
  sectionStyle: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#fff',
    borderWidth: 0.5,
    borderColor: '#000',
    height: 40,
    borderRadius: 5,
    margin: 16,
  },
  imageStyle: {
    padding: 10,
    margin: 5,
    height: 25,
    width: 25,
    resizeMode: 'stretch',
    alignItems: 'center',
  },
});