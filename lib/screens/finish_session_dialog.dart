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
  // controlador para leer lo que escribe el usuario
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
            const Text("Has completado una sesion de enfoque."),
            const SizedBox(height: 10),
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "¿En que trabajaste?",
                border: OutlineInputBorder(),
              ),
              // validacion simple para que no guarden vacio
              validator: (value) =>
                  value!.isEmpty ? "por favor escribe una descripcion" : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // si cancela, solo reiniciamos el timer
            Provider.of<TimerProvider>(context, listen: false).resetTimer();
            Navigator.pop(context);
          },
          child: const Text("Descartar"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // guardamos en la base de datos sqlite usando el provider
              // le pasamos la descripcion y la duracion fija de 25 min
              Provider.of<SessionProvider>(context, listen: false)
                  .addSession(_controller.text, 25);
              
              // reiniciamos el reloj para la prox sesion
              Provider.of<TimerProvider>(context, listen: false).resetTimer();
              
              Navigator.pop(context);
              
              // avisamos que se guardo bien
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Sesion guardada exitosamente")),
              );
            }
          },
          child: const Text("Guardar Sesion"),
        ),
      ],
    );
  }
}