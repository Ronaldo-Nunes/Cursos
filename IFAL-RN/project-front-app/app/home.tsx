import { Picker } from "@react-native-picker/picker";
import Slider from '@react-native-community/slider';
import { useState } from "react";
import { Text, View, StyleSheet, Image, TextInput, ScrollView, Switch, Pressable, SafeAreaView } from "react-native";
import { useRouter } from "expo-router";
import { StatusBar } from "expo-status-bar";

interface ClienteProps {
  nome: string;
  idade: number;
  sexo: string;
  limiteCredito: number;
  isEstudante: boolean;
}

export default function Home() {
  const LIMITE_MINIMO = 300;
  const LIMITE_MAXIMO = 5000;
  const router = useRouter();
  const [cliente, setCliente] = useState<ClienteProps>({
    nome: '',
    idade: 0,
    sexo: 'Masculino',
    limiteCredito: 300,
    isEstudante: false
  });

  const [nomeError, setNomeError] = useState('');
  const [idadeError, setIdadeError] = useState('');

  const sexos = ['Masculino', 'Feminino', 'Prefiro não dizer'];

  const sexoItems = sexos.map((value, index) => {
    return <Picker.Item key={index} value={value} label={value} />
  });

  const handleEvent = (prop: keyof ClienteProps, value: string | number | boolean) => {
    setCliente({ ...cliente, [prop]: value });
  };

  const validaForm = (): boolean => {
    let nomeValido = false;
    let idadeValida = false;

    if (cliente.nome.trim().length <= 0) {
      setNomeError('O nome deve ter mais de três caracteres!');
    } else {
      setNomeError('');
      nomeValido = true;
    }

    if (cliente.idade < 18 || cliente.idade > 100) {
      setIdadeError('A idade deve ser maior que 18 e menor que 100 anos!');
    } else {
      setIdadeError('');
      idadeValida = true;
    }

    return nomeValido && idadeValida;
  }

  const limparForm = () => {
    setCliente({
      nome: '',
      idade: 0,
      sexo: 'Masculino',
      limiteCredito: 300,
      isEstudante: false
    })
  }

  const handleSalvar = () => {
    if (validaForm()) {
      alert('Dados Válidos');
      limparForm();
      router.push({ pathname: '/detail', params: { ...cliente } });
    }
  }

  return (
    <SafeAreaView style={{ flex: 1 }}>
      <StatusBar style="auto" translucent={false} />

      <ScrollView>
        <View style={styles.container}>
          <Image
            source={require('../assets/images/logo_banco_projeto.png')}
            style={styles.logo}
          />
          <Text style={styles.texto}>Ronaldo Bank</Text>
        </View>

        <View style={styles.containerCampos}>
          <Text style={nomeError.length === 0 ? styles.label : styles.labelError}>Nome:</Text>
          <TextInput
            style={nomeError.length === 0 ? styles.input : styles.inputError}
            placeholder='Nome'
            onChangeText={text => handleEvent('nome', text)}
            onKeyPress={() => setNomeError('')}
            value={cliente.nome}
          />
          {nomeError.length > 0 && <Text style={styles.textoErro}>{nomeError}</Text>}

          <Text style={idadeError.length === 0 ? styles.label : styles.labelError}>Idade:</Text>
          <TextInput
            style={idadeError.length === 0 ? styles.input : styles.inputError}
            placeholder='Idade'
            onChangeText={(text) => handleEvent('idade', Number(text))}
            onKeyPress={() => setIdadeError('')}
            value={cliente.idade.toString()}
            keyboardType="numeric"
          />
          {idadeError.length > 0 && <Text style={styles.textoErro}>{idadeError}</Text>}
          <Text style={styles.label}>Sexo:</Text>
          <View style={styles.picker}>
            <Picker
              selectedValue={cliente.sexo}
              onValueChange={(text) => handleEvent('sexo', text)}
            >
              {sexoItems}
            </Picker>
          </View>
          <View style={styles.containerSwitch}>
            <Text style={{ fontSize: 16 }}>Você é estudante?</Text>
            <Switch
              trackColor={{ false: '#767577', true: '#81b0ff' }}
              thumbColor={cliente.isEstudante ? '#2F4A60' : '#f4f3f4'}
              value={cliente.isEstudante}
              onValueChange={() => handleEvent('isEstudante', !cliente.isEstudante)}
            />
          </View>
          <Text style={styles.label}>Limite de crédito:</Text>
          <View style={styles.containerSlider}>
            <Slider
              style={{ width: '100%', height: 36 }}
              value={cliente.limiteCredito}
              minimumValue={LIMITE_MINIMO}
              maximumValue={LIMITE_MAXIMO}
              step={100}
              thumbTintColor='#2F4A60'
              onValueChange={(value) => handleEvent('limiteCredito', value)}
              minimumTrackTintColor="#5lFFFF"
              maximumTrackTintColor="#000000"
            />
            <Text style={{ fontSize: 16 }}>{`R$ ${cliente.limiteCredito},00`}</Text>
          </View>
          <View style={{ marginTop: 36, marginBottom: 24 }}>
            <Pressable
              style={styles.botaoPrincipal}
              onPress={handleSalvar}
            >
              <Text style={styles.textoBotao}>
                ABRIR CONTA
              </Text>
            </Pressable>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const primaryColor = '#155B95';
const primaryDark = '#2F4A60';
const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    alignItems: 'center',
    marginTop: 24,
    marginHorizontal: 16
  },
  containerCampos: {
    flex: 1,
    flexDirection: 'column',
    alignSelf: 'stretch',
    marginTop: 24,
    marginHorizontal: 20,
    marginBottom: 16
  },
  containerSlider: {
    flex: 1,
    flexDirection: 'column',
    alignItems: 'center'
  },
  containerSwitch: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    height: 56,
    justifyContent: 'space-between',
    borderWidth: 1,
    paddingStart: 8,
    borderColor: primaryColor,
    borderRadius: 8,
    marginTop: 16,
    marginBottom: 16,
  },
  logo: {
    width: 96,
    height: 96
  },
  texto: {
    fontSize: 20,
    fontWeight: 'bold',
    color: primaryDark
  },
  label: {
    fontSize: 16,
    marginBottom: 4,
    marginTop: 16,
    marginStart: 8
  },
  labelError: {
    fontSize: 16,
    marginBottom: 4,
    marginTop: 16,
    marginStart: 8,
    color: 'red'
  },
  input: {
    height: 56,
    width: '100%',
    borderWidth: 1,
    borderRadius: 8,
    borderColor: primaryDark,
    padding: 8,
    fontSize: 18
  },
  inputError: {
    height: 56,
    width: '100%',
    borderWidth: 1,
    borderRadius: 8,
    borderColor: 'red',
    padding: 8,
    fontSize: 18
  },
  picker: {
    flex: 1,
    justifyContent: 'center',
    alignSelf: 'stretch',
    borderWidth: 1,
    borderColor: primaryDark,
    borderRadius: 8,
    marginBottom: 16,
    width: '100%'
  },
  botaoPrincipal: {
    justifyContent: 'center',
    alignItems: 'center',
    paddingVertical: 16,
    paddingHorizontal: 24,
    borderRadius: 24,
    backgroundColor: primaryColor
  },
  textoBotao: {
    fontSize: 18,
    fontWeight: '700',
    color: 'white'
  },
  textoErro: {
    marginStart: 4,
    fontSize: 14,
    color: 'red'
  }
})