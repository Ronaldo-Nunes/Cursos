import { StatusBar } from 'expo-status-bar';
import { useState } from 'react';
import { Pressable, SafeAreaView, StyleSheet, Text, View } from 'react-native';

export default function App() {
  const [miliSegundos, setMiliSegundos] = useState(0);
  const [segundos, setSegundos] = useState(0);
  const [minutos, setMinutos] = useState(0);
  const [intervalo, setIntervalo] = useState<NodeJS.Timer>();

  const [isPause, setPause] = useState(false);
  const [iniciado, setIniciado] = useState(false);

  const startTimer = () => {
    setIniciado(true);
    setPause(false);
    setIntervalo(
      setInterval(() => {
        changeTime();
      }, 1000)
    );
  };

  const stopTimer = () => {
    setPause(true);
    setIniciado(false);
    if (intervalo !== undefined) {
      clearInterval(intervalo);
    }
  };

  const clear = () => {
    stopTimer();
    setPause(false);
    setMinutos(0);
    setSegundos(0);
    setMiliSegundos(0);
  };

  const changeTime = () => {
    // setMiliSegundos((prevMills) => {
    //   if (prevMills + 10 === 1000) {
    //     setSegundos((prevSec) => {
    //       if (prevSec + 1 === 60) {
    //         setMinutos(minutos + 1);
    //         return 0;
    //       }
    //       // console.log('segundos', prevSec + 1, new Date().getUTCSeconds());
    //       return prevSec + 1;
    //     });
    //     return 0;
    //   }
    //   return prevMills + 10;
    // });

    setSegundos((prevSec) => {
      if (prevSec + 1 === 60) {
        setMinutos(minutos + 1);
        return 0;
      }
      console.log('segundos', prevSec + 1, new Date().getUTCSeconds());
      return prevSec + 1;
    });
  };

  const formatTime = (time: number) => {
    return time < 10 ? `0${time}` : time;
  }

  const formatMills = (time: number) => {
    if (time < 10) {
      return `00${time}`;
    } else
      if (time < 100) {
        return `0${time}`
      }
    return time;
  }

  return (
    <SafeAreaView style={{ flex: 1 }}>
      <StatusBar style="light" backgroundColor={'#1d3557'} translucent={false} />
      <View style={styles.toolbar}>
        <Text style={styles.titulo}>Cronômetro</Text>
      </View>
      <View style={styles.timeContainer}>
        <Text style={styles.timeText}>
          {formatTime(minutos)} : {formatTime(segundos)}{/* . {formatMills(miliSegundos)} */}
        </Text>
      </View>
      <View style={styles.containerButtons}>
        {!iniciado && <Pressable
          style={styles.principalButton}
          onPress={startTimer}
        >
          <Text style={styles.principalButtonText}>
            {isPause ? 'Retomar' : 'Iniciar'}
          </Text>
        </Pressable>}

        {iniciado && <Pressable
          style={styles.outlinedButton}
          onPress={stopTimer}
        >
          <Text style={styles.buttonText}>Parar</Text>
        </Pressable>}

        {isPause && <Pressable
          style={styles.outlinedButton}
          onPress={clear}
        >
          <Text style={styles.buttonText}>Restaurar</Text>
        </Pressable>}
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  toolbar: {
    backgroundColor: '#1d3557',
    height: 56,
    alignItems: 'flex-start',
    justifyContent: 'center',
    paddingHorizontal: 24
  },
  titulo: {
    fontSize: 20,
    color: "#fff",
    fontStyle: 'normal',
    fontWeight: 'bold',
  },
  timeContainer: {
    flex: 3,
    gap: 4,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
  },
  timeText: {
    fontSize: 48,
    fontWeight: '400',
    color: '#1b263b'
  },
  containerButtons: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'space-around',
    alignItems: 'center',
    backgroundColor: '#fff',
    marginHorizontal: 16
  },
  principalButton: {
    justifyContent: 'center',
    alignItems: 'center',
    paddingVertical: 8,
    paddingHorizontal: 24,
    borderRadius: 24,
    backgroundColor: '#0096c7',
    borderColor: '#0096c7',
    borderWidth: 3
  },
  principalButtonText: {
    fontSize: 18,
    fontWeight: 'bold',
    color: 'white'
  },
  outlinedButton: {
    justifyContent: 'center',
    alignItems: 'center',
    paddingHorizontal: 24,
    paddingVertical: 8,
    borderRadius: 24,
    backgroundColor: '#fff',
    borderColor: '#0096c7',
    borderWidth: 3
  },
  buttonText: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#1d3557'
  }
});
