import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // traigo el provider para el tiempo
    final timerProvider = Provider.of<TimerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bitácora de Enfoque'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // aqui ira el historial de navegacion
              print("ir al historial"); 
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // el circulo que muestra el progreso
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: CircularProgressIndicator(
                    // calculo cuanto falta para que se vacie el circulo
                    value: timerProvider.timeLeft / (25 * 60),
                    strokeWidth: 10,
                    color: Colors.redAccent,
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                Text(
                  timerProvider.timerString,
                  style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 50),
            // fila de botones de control
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // cambio el boton segun si esta corriendo o no
                if (!timerProvider.isRunning)
                  ElevatedButton.icon(
                    onPressed: () {
                      timerProvider.startTimer(() {
                        // funcion que se ejecuta cuando acaba el tiempo
                        print("termino el pomodoro");
                      });
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text("Iniciar"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  )
                else
                  ElevatedButton.icon(
                    onPressed: timerProvider.stopTimer,
                    icon: const Icon(Icons.pause),
                    label: const Text("Pausar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: timerProvider.resetTimer,
                  child: const Text("Reiniciar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}