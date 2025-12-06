🍅 Bitácora de Enfoque

Aplicación móvil de productividad y gestión de tiempo basada en la técnica Pomodoro, con persistencia de datos y análisis estadístico.

👨‍💻 Datos del Estudiante

Nombre: José Maria Mamani Zuñiga

Curso: Programación para Dispositivos Móviles (Sexto Semestre)

Fecha: 06 de Diciembre del 2025

Examen Final: 2025-2

📱 Descripción del Proyecto

"Bitácora de Enfoque" nace para resolver el problema de la procrastinación académica. Permite a los estudiantes gestionar bloques de estudio de 25 minutos (Pomodoros), registrar qué lograron en cada sesión y visualizar su progreso histórico y semanal.

La aplicación sigue una filosofía "Offline-First", garantizando que los datos persistan en el dispositivo (SQLite) sin necesidad de conexión a internet.

✨ Funcionalidades Principales

1. ⏱️ Temporizador Pomodoro Interactivo

Contador regresivo con control visual (Circular Progress).

Funciones de Iniciar, Pausar y Reiniciar.

Alerta automática al finalizar el tiempo.

2. 💾 Registro de Sesiones (Persistencia SQLite)

Formulario emergente al terminar el contador.

Campo editable de duración: Permite ajustar el tiempo real trabajado (ej. 15 min, 45 min) si la sesión fue diferente al estándar.

Validación de formularios para asegurar la integridad de los datos.

3. 📜 Historial de Productividad

Lista cronológica de todas las sesiones completadas.

Lectura directa desde la base de datos local.

Visualización detallada con fecha, hora y descripción de la tarea.

4. 📊 Dashboard de Análisis (Funcionalidad Extra)

Gráficos Estadísticos: Implementación de fl_chart.

Algoritmo de Agrupación: Procesa los datos crudos de SQLite para calcular la productividad semanal (Lunes a Domingo).

Visualización dinámica de los minutos de enfoque acumulados por día.

🛠️ Arquitectura Técnica

El proyecto fue desarrollado utilizando Flutter (Dart) bajo el patrón de diseño MVVM (Model-View-ViewModel) para asegurar un código limpio, escalable y mantenible.

Estructura de Carpetas (Clean Architecture)

📂 lib

📂 data: Capa de datos. Contiene DBHelper (Singleton) para gestionar la conexión con SQLite.

📂 models: Modelos de datos (Session) que mapean la estructura de la tabla a objetos Dart.

📂 providers: Capa de lógica de negocio (ViewModels).

TimerProvider: Gestiona el estado del reloj.

SessionProvider: Intermediario entre la UI y la Base de Datos.

📂 screens: Capa de presentación (UI).

📂 widgets: Componentes reutilizables (ej. CustomButton).

Librerías Utilizadas

provider: Gestión de estado eficiente.

sqflite: Motor de base de datos local.

path: Gestión de rutas de archivos del sistema.

intl: Formateo de fechas y horas.

fl_chart: Generación de gráficos estadísticos interactivos.

🚀 Instrucciones de Instalación

Clonar el repositorio:

git clone ()


Instalar dependencias:

flutter pub get


Ejecutar en Android:
(Se requiere un emulador o dispositivo físico conectado)

flutter run

📸 Capturas de Pantalla / Video

()

Proyecto desarrollado en Visual Studio Code bajo Windows 11.
