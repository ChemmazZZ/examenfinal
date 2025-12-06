import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';
import '../widgets/custom_button.dart';
import 'finish_session_dialog.dart';
import 'history_screen.dart';
import 'statistics_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    final statusText = timerProvider.isBreakTime 
        ? "TIEMPO DE DESCANSO" 
        : "Bitácora de Enfoque";

    return Scaffold(
      appBar: AppBar(
        title: Text(statusText),
        centerTitle: true,
        // si estamos en descanso, ocultamos los botones de historial/estadísticas
        actions: timerProvider.isBreakTime ? [] : [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StatisticsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // circulo del Timer
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: CircularProgressIndicator(
                    value: timerProvider.isBreakTime
                        ? timerProvider.timeLeft / (5 * 60) // Base 5 min
                        : timerProvider.timeLeft / (25 * 60), // Base 25 min
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
            const SizedBox(height: 20),
            
            // mensaje extra si estamos en descanso
            if (timerProvider.isBreakTime)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "⚠️ Aplicación Bloqueada por Descanso ⚠️\nEspera a que termine el tiempo.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),

            const SizedBox(height: 30),
            
            // LOGICA DE BOTONES (EL BLOQUEO)
            if (timerProvider.isBreakTime)
              // EN DESCANSO NO HAY BOTONES DE INICIAR
              const Icon(Icons.lock_clock, size: 50, color: Colors.grey)
            else
              // EN TRABAJO LOS BOTONES NORMALES
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!timerProvider.isRunning)
                    CustomButton(
                      text: "Iniciar",
                      icon: Icons.play_arrow,
                      onPressed: () {
                        timerProvider.startWork(() {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const FinishSessionDialog(),
                          );
                        });
                      },
                    )
                  else
                    CustomButton(
                      text: "Pausar",
                      icon: Icons.pause,
                      color: Colors.orange,
                      onPressed: timerProvider.stopTimer,
                    ),
                  
                  const SizedBox(width: 20),
                  
                  // botón reiniciar
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