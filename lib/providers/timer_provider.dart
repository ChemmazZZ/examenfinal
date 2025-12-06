import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart'; 

class TimerProvider with ChangeNotifier {
  // CONFIGURACIÓN DE TIEMPO
  static const int _workTime = 25 * 60; 
  static const int _breakTime = 5 * 60;

  int _timeLeft = _workTime;
  Timer? _timer;
  bool _isRunning = false;
  
  // Estado de Bloqueo
  bool _isBreakTime = false; 

  int get timeLeft => _timeLeft;
  bool get isRunning => _isRunning;
  bool get isBreakTime => _isBreakTime;

  String get timerString {
    final minutes = (_timeLeft / 60).floor().toString().padLeft(2, '0');
    final seconds = (_timeLeft % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  // MÉTODO PRIVADO PARA VIBRAR 
  void _triggerVibration() async {
    // CORRECCIÓN de ??
    final hasVibrator = await Vibration.hasVibrator();
    
    if (hasVibrator == true) { // Verificación segura explícita
      // patron  de vibra 500ms, pausa 500ms, vibra 500ms
      Vibration.vibrate(pattern: [500, 1000, 500, 1000]);
    }
  }

  // iniciar Trabajo
  void startWork(VoidCallback onFinished) {
    if (_timer != null) return;
    _isRunning = true;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
        notifyListeners();
      } else {
        stopTimer();
        _triggerVibration(); // VIBRA AL TERMINAR DE CHAMBEAR
        onFinished(); 
      }
    });
  }

  // iniciar descanso
  void startBreak() {
    _isBreakTime = true;
    _isRunning = true; 
    _timeLeft = _breakTime; 
    
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
        notifyListeners();
      } else {
        // FIN DEL DESCANSO
        _timer?.cancel();
        _timer = null;
        _isRunning = false;
        _isBreakTime = false; 
        _timeLeft = _workTime;
        
        _triggerVibration(); // VIBRA AL TERMINAR DESCANSO
        
        notifyListeners();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    _isRunning = false;
    notifyListeners();
  }

  void resetTimer() {
    stopTimer();
    _isBreakTime = false;
    _timeLeft = _workTime;
    notifyListeners();
  }
}