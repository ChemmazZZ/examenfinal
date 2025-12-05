import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/session_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    // SOLUCIÓN: Usamos addPostFrameCallback en lugar de microtask.
    // Esto asegura que el contexto esté listo y el widget montado.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SessionProvider>(context, listen: false).loadSessions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Historial de Productividad")),
      body: sessionProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : sessionProvider.sessions.isEmpty
              ? const Center(child: Text("Aun no tienes sesiones registradas."))
              : ListView.builder(
                  itemCount: sessionProvider.sessions.length,
                  itemBuilder: (context, index) {
                    final session = sessionProvider.sessions[index];
                    final date = DateTime.parse(session.date);
                    final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(date);

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          child: Icon(Icons.check, color: Colors.white),
                        ),
                        title: Text(session.description),
                        subtitle: Text(formattedDate),
                        trailing: Text("${session.durationMinutes} min"),
                      ),
                    );
                  },
                ),
    );
  }
}