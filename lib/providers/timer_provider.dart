import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  // configuración inicial 25 minutos(en segs)
  static const int _initialTime = 25 * 60; 
  
  int _timeLeft = _initialTime;
  Timer? _timer;
  bool _isRunning = false;

  // getters para que la UI lea los datos
  int get timeLeft => _timeLeft;
  bool get isRunning => _isRunning;

  // convierte los segundos a texto legible "Minutos:Segs"
  String get timerString {
    final minutes = (_timeLeft / 60).floor().toString().padLeft(2, '0');
    final seconds = (_timeLeft % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  // iniciar el conteo
  void startTimer(VoidCallback onFinished) {
    if (_timer != null) return; // si ya corre 
    
    _isRunning = true;
    notifyListeners(); // avisar a la UI que cambió el estado

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
        notifyListeners(); // avisar cada segundo para actualizar el reloj
      } else {
        stopTimer();
        onFinished(); // ejecutar la acción "Terminó"
      }
    });
  }

  // pausa el conteo
  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    _isRunning = false;
    notifyListeners();
  }

  // reiniciar al estado original
  void resetTimer() {
    stopTimer();
    _timeLeft = _initialTime;
    notifyListeners();
  }
}