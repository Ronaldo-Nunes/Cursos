import React, { useState } from 'react';
import { View, TextInput, StyleSheet, TouchableOpacity, TextInputProps } from 'react-native';
import { Ionicons } from '@expo/vector-icons';

interface SearchBarProps extends TextInputProps {
  value?: string;
  onStartSearch: () => void;
}
const SearchBar = ({value, onChange, onStartSearch, ...rest}: SearchBarProps) => {

  return (
    <View style={styles.container}>
      <TextInput
        style={styles.input}
        value={value}
        {...rest}
      />
      <TouchableOpacity style={styles.buttonContainer} onPress={onStartSearch}>
        <Ionicons name="search-sharp" size={24} color="#fff" />
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    alignItems: 'center',
    borderRadius: 8,
    marginHorizontal: 16,
    marginVertical: 8,
  },
  input: {
    flex: 1,
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderWidth: 0.5,
    borderRadius: 4,
    fontSize: 16,
    color: '#333',
  },
  buttonContainer: {
    marginStart: 8,
    backgroundColor: '#62a4ab',
    borderRadius: 8,
    padding: 8,
  },
});

export default SearchBar;
