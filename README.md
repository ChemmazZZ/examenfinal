🍅 Bitácora de Enfoque

ESTADO DEL PROYECTO: Finalizado (v1.0.0)
PLATAFORMA: Android
FRAMEWORK: Flutter (Dart)

1. Información del Estudiante

Campo

Detalle

Nombre

José Maria Mamani Zuñiga

Curso

Programación para Dispositivos Móviles

Semestre

Sexto Semestre

Docente

Josue Miguel Flores Parra

Fecha de Entrega

06 de Diciembre del 2025

Examen

Examen Final 2025-2

2. Descripción del Proyecto

PROBLEMA A RESOLVER

La procrastinación académica y la falta de gestión del tiempo afectan el rendimiento de los estudiantes universitarios. A menudo, se estudia sin medir el tiempo real de enfoque, lo que genera una falsa sensación de productividad.

PROPUESTA DE VALOR

"Bitácora de Enfoque" es una aplicación móvil diseñada bajo la filosofía "Offline-First". Implementa la técnica Pomodoro para gestionar intervalos de estudio y utiliza una base de datos local (SQLite) para persistir un registro histórico de las sesiones. Esto permite al estudiante auditar su propia productividad sin depender de conexión a internet.

3. Funcionalidades Principales

⏱️ A. Temporizador Pomodoro

Descripción: Módulo principal de gestión de tiempo.

Características:

Indicador visual de progreso circular.

Controles de estado (Iniciar, Pausar, Reiniciar).

Feedback visual inmediato.

💾 B. Registro y Persistencia (SQLite)

Descripción: Sistema de almacenamiento de datos local.

Características:

Formulario emergente automático al finalizar el temporizador.

Edición flexible: Permite al usuario modificar la duración real (minutos) si la sesión fue interrumpida o extendida.

Validación de campos para asegurar la integridad de la base de datos.

📜 C. Historial de Sesiones

Descripción: Bitácora cronológica de actividad.

Características:

Lectura asíncrona desde la base de datos.

Visualización de fecha, descripción de tarea y duración.

Ordenamiento descendente (lo más reciente primero).

📊 D. Dashboard Estadístico (Extra)

Descripción: Análisis de datos y visualización gráfica.

Características:

Implementación de la librería fl_chart.

Algoritmo de agrupación: Procesa los datos crudos para sumarizar la productividad por día de la semana (Lunes a Domingo).

4. Arquitectura de Software

El proyecto sigue estrictamente el patrón de diseño MVVM (Model-View-ViewModel) y los principios de Clean Architecture para garantizar la separación de responsabilidades.

🏛️ Diagrama de Estructura

lib/
├── data/               # CAPA DE DATOS
│   └── db_helper.dart  # Singleton para gestión de SQLite
│
├── models/             # CAPA DE MODELO
│   └── session.dart    # POJO (Plain Old Java Object) de Sesión
│
├── providers/          # CAPA DE VIEWMODEL (Lógica de Negocio)
│   ├── timer_provider.dart    # Lógica del temporizador y estado
│   └── session_provider.dart  # Intermediario UI <-> Base de Datos
│
├── screens/            # CAPA DE VISTA (UI)
│   ├── home_screen.dart       # Pantalla principal
│   ├── history_screen.dart    # Listado de datos
│   ├── statistics_screen.dart # Gráficos
│   └── finish_session_dialog.dart # Formulario de captura
│
└── widgets/            # COMPONENTES REUTILIZABLES
    └── custom_button.dart


5. Tecnologías y Librerías

Librería

Versión

Uso en el Proyecto

flutter

SDK

Framework de desarrollo UI.

provider

^6.0.0

Inyección de dependencias y gestión de estado (MVVM).

sqflite

^2.0.0

Motor de base de datos SQL local.

path

^1.8.0

Utilidad para rutas de sistema de archivos.

intl

^0.18.0

Formateo de fechas y horas.

fl_chart

^0.66.0

Renderizado de gráficos estadísticos.

6. Instrucciones de Instalación

REQUISITOS PREVIOS:

Flutter SDK instalado.

Emulador Android o Dispositivo físico.

PASOS:

Clonar el repositorio:

git clone ()


Instalar dependencias:

flutter pub get


Ejecutar la aplicación:

flutter run


© 2025 José Maria Mamani Zuñiga - Facultad de Ingenierías y Arquitectura
