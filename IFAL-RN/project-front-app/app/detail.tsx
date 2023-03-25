import { useRouter, useSearchParams } from "expo-router";
import { View, StyleSheet, Text } from "react-native";

export default function Detail() {
  const params = useSearchParams();
  const { nome, sexo, idade, isEstudante, limiteCredito } = params;

  return (
    <View style={styles.container}>

      <Text style={styles.texto}>{`Nome: ${nome}`}</Text>
      <Text style={styles.texto}>{`Sexo: ${sexo}`}</Text>
      <Text style={styles.texto}>{`Idade: ${idade} anos`}</Text>
      <Text style={styles.texto}>{`Estudante: ${isEstudante ? 'Sim' : 'Não'}`}</Text>
      <Text style={styles.texto}>{`Limite de crédito: R$ ${limiteCredito},00`}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    marginVertical: 16,
    marginHorizontal: 16
  },
  texto: {
    fontSize: 20,
    marginBottom: 16,
    fontWeight: 'bold',
    color: '#2b2d42'
  }
});