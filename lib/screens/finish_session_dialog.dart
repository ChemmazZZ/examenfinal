import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/session_provider.dart';
import '../providers/timer_provider.dart';

class FinishSessionDialog extends StatefulWidget {
  const FinishSessionDialog({super.key});

  @override
  State<FinishSessionDialog> createState() => _FinishSessionDialogState();
}

class _FinishSessionDialogState extends State<FinishSessionDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("¡Felicidades! 🎉"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Has completado un Pomodoro. Registra tu tarea para iniciar el descanso."),
            const SizedBox(height: 10),
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "¿En qué trabajaste?",
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value!.isEmpty ? "Por favor escribe una descripción" : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // AUNQUE DESCARTEN, EL DESCANSO ES OBLIGATORIO
            Navigator.pop(context);
            Provider.of<TimerProvider>(context, listen: false).startBreak();
          },
          child: const Text("Descartar"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Guardamos 25 min
              Provider.of<SessionProvider>(context, listen: false)
                  .addSession(_controller.text, 25);
              
              Navigator.pop(context);
              
              // INICIA EL BLOQUEO DE 5 MINUTOS
              Provider.of<TimerProvider>(context, listen: false).startBreak();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Sesión guardada. ¡Descanso iniciado!")),
              );
            }
          },
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}