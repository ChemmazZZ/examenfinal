import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';
import '../widgets/custom_button.dart';// widget Reutilizable de Botones
import 'finish_session_dialog.dart';
import 'history_screen.dart';
import 'statistics_screen.dart';// importamos la pantalla de gráficas

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bitácora de Enfoque'),
        centerTitle: true,
        actions: [
          // botón de estadisticas 
          IconButton(
            tooltip: "Ver Estadísticas",
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StatisticsScreen()),
              );
            },
          ),
          //  Boton de historial
          IconButton(
            tooltip: "Ver Historial",
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
            
            // botones de Control aqui se usa el widget reutilizable
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!timerProvider.isRunning)
                  CustomButton(
                    text: "Iniciar",
                    icon: Icons.play_arrow,
                    onPressed: () {
                      timerProvider.startTimer(() {
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