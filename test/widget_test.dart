import 'package:flutter_test/flutter_test.dart';
import 'package:bitacora_enfoque/main.dart'; // Asegúrate que este import coincida con el nombre de tu proyecto en pubspec.yaml

void main() {
  testWidgets('La app carga correctamente y muestra el titulo', (WidgetTester tester) async {
    // 1. Construimos la app (BitacoraApp) y esperamos a que cargue el primer frame
    await tester.pumpWidget(const BitacoraApp());

    // 2. Verificamos que aparezca el título de la AppBar
    // "find.text" busca widgets que contengan ese String exacto
    expect(find.text('Bitácora de Enfoque'), findsOneWidget);

    // 3. Verificamos que aparezca el botón de "Iniciar"
    // Esto confirma que la pantalla HomeScreen cargó bien
    expect(find.text('Iniciar'), findsOneWidget);

    // 4. Verificamos que NO aparezca nada del contador viejo (solo por seguridad)
    expect(find.text('0'), findsNothing);
  });
}