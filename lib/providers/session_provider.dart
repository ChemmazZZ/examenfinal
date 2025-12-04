
import 'package:flutter/material.dart';
import '../data/db_helper.dart';
import '../models/session.dart';

class SessionProvider with ChangeNotifier {
  List<Session> _sessions = [];
  bool _isLoading = true;

  List<Session> get sessions => _sessions;
  bool get isLoading => _isLoading;

  // cargar sesiones desde la Base de Datos sqlite
  Future<void> loadSessions() async {
    _isLoading = true;
    notifyListeners(); // mostrar cargando
    
    _sessions = await DBHelper.instance.getAllSessions();
    
    _isLoading = false;
    notifyListeners(); // mostrar la lista
  }

  // guardar una nueva sesión en la BD y recargar la lista
  Future<void> addSession(String description, int duration) async {
    final newSession = Session(
      description: description,
      durationMinutes: duration,
      date: DateTime.now().toString(), // guardamos fecha actual
    );

    await DBHelper.instance.insertSession(newSession);
    
    // importante recargar la lista para que aparezca la nueva sesión inmediatamente
    await loadSessions(); 
  }
}