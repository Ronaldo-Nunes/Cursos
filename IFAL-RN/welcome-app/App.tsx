import { StatusBar } from 'expo-status-bar';
import React, { useState } from 'react';
import { Button, SafeAreaView, StyleSheet, Text, useWindowDimensions, View } from 'react-native';

export default function App() {
  const [mensagem, setMensagem] = useState('');
  const [execucao, setExeucao] = useState(0);


  const handleExibirMensagem = () => {
    setExeucao(newValue => newValue + 1)

    if (execucao > 0) {
      setMensagem(retornarFrase());
    } else {
      setMensagem('Seja bem-vindo!')
    }
  }


  return (
    <SafeAreaView style={{ flex: 1 }}>
      <StatusBar style="auto" backgroundColor={'#1d3557'} translucent={false} />
      <View style={styles.toolbar}>
        <Text style={styles.titulo}>Welcome app - IFAL</Text>
      </View>
      <View style={styles.container}>
        <Text style={styles.subtitulo}>{mensagem}</Text>
      </View>
      <View style={{ height: 60, marginHorizontal: 16 }}>
        <Button
          color='#457b9d'
          title={execucao == 0 ? 'Clica aí' : 'Exibir mensagem'}
          onPress={() => handleExibirMensagem()}
        />
      </View>
    </SafeAreaView>
  );
}

const retornarFrase = (): string => {
  const numero = Math.floor(Math.random() * frases.length);

  return frases[numero];
}

const frases = [
  'A César o que é de César, a Deus o que é de Deus.',
  'Água mole, pedra dura, tanto bate até que fura.',
  'A pressa é a inimiga da perfeição.',
  'À noite todos os gatos são pardos.',
  'Antes só do que mal acompanhado.',
  'As aparências enganam.',
  'A voz do povo é a voz de Deus.',
  'Cada macaco no seu galho.',
  'Quem sai aos seus não degenera.',
  'Nem tudo que reluz é ouro.',
  'Papagaio que acompanha joão-de-barro vira ajudante de pedreiro.',
  'Cada um sabe onde o sapato aperta.',
  'Quem é vivo sempre aparece.',
  'Quem espera sempre alcança.',
  'Caiu na rede, é peixe.',
  'Casa de ferreiro, espeto de pau.',
  'Cachorro que ladra não morde.',
  'A cavalo dado não se olha o dente.',
  'De grão em grão, a galinha enche o papo.',
  'De médico e de louco todo mundo tem um pouco.',
  'Deus ajuda quem cedo madruga.',
  'Deus escreve certo por linhas tortas.',
  'Diz-me com quem andas e eu te direi quem és.',
  'É dando que se recebe.',
  'Em terra de cego quem tem olho é rei.',
  'Escreveu, não leu; o pau comeu.',
  'Filho de peixe, peixinho é.',
  'Gato escaldado tem medo de água fria.',
  'Ladrão que rouba ladrão tem cem anos de perdão.',
  'Mais vale um pássaro na mão do que dois voando.',
  'Mentira tem perna curta.',
  'O barato sai caro.',
  'Onde há fumaça há fogo.',
  'O seguro morreu de velho.',
  'Para bom entendedor, meia palavra basta.',
  'Para baixo todo santo ajuda.',
  'Pimenta nos olhos dos outros é refresco.',
  'Pôr a mão no fogo.',
  'Dar uma de joão-sem-braço.',
  'Quando um burro fala, o outro abaixa a orelha.',
  'Quem ama o feio, bonito lhe parece.',
  'Quem canta seus males espanta.',
  'Quem casa quer casa.',
  'Quem com ferro fere, com ferro será ferido.',
  'Quem mistura-se com porcos, farelo come.',
  'Quem não tem cão, caça com gato.',
  'Quem pode, pode; quem não pode, se sacode.',
  'Quem ri por último ri melhor.',
  'Quem semeia vento, colhe tempestade.',
  'Quem tem boca vai a Roma.',
  'Saco vazio não para em pé.',
  'Uma andorinha sozinha não faz verão.',
  'Um dia é da caça, outro do caçador.',
  'Todos os caminhos levam a Roma.',
  'Santo de casa não faz milagre.',
  'Quem não chora não mama.',
  'Não adianta chorar pelo leite derramado.',
  'O pior cego é o que não quer ver.',
  'Quem fala o que quer ouve o que não quer.',
  'Não há mal que sempre dure, nem bem que nunca se acabe.',
  'De pequenino é que se torce o pepino.',
  'Faça o que eu digo, mas não faça o que eu faço.',
  'Passarinho que acompanha morcego acorda de cabeça para baixo.',
  'Águas passadas não movem moinho.'
]



const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#fff',
    marginHorizontal: 16
  },
  toolbar: {
    backgroundColor: '#457b9d',
    height: 56,
    alignItems: 'center',
    justifyContent: 'center'
  },
  titulo: {
    fontSize: 20,
    color: "#fff",
    fontStyle: 'normal',
    fontWeight: 'bold'
  },
  subtitulo: {
    color: "#3e3f47",
    fontSize: 27,
    textAlign: 'center'

  },
  mensagem: {
    color: "#3e3f47",
    fontSize: 27,
    marginTop: 16,
    marginBottom: 16
  }
});
