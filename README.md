# 📘 Bitácora de Enfoque  
Aplicación móvil Flutter para la gestión de tiempo, descanso y productividad académica.

## 📄 Descripción General

**Bitácora de Enfoque** es una aplicación móvil desarrollada en **Flutter** bajo la arquitectura **Offline-First** y el patrón **MVVM**, diseñada para ayudar a los estudiantes a mantener un ciclo equilibrado de estudio y descanso basado en la metodología **Pomodoro**.

A diferencia de temporizadores convencionales, esta app integra un **ciclo Pomodoro estricto con bloqueo de interfaz**, un sistema de **persistencia local SQLite**, **vibración háptica**, un historial auditable y un **dashboard estadístico semanal**.

La aplicación funciona **sin conexión a internet**, garantizando disponibilidad total en cualquier entorno académico.

---

## 🎯 Problema que Resuelve

En las universidades es común que los estudiantes:

- Procrastinen.  
- Ignoren los descansos necesarios.  
- Se expongan al *burnout* por estudiar de manera desordenada.  
- No cuenten con un registro real del tiempo invertido.

Estos problemas reducen el rendimiento cognitivo y la capacidad de concentración.

**Bitácora de Enfoque** propone una solución que regula automáticamente los ciclos de estudio y descanso, evitando el agotamiento y permitiendo llevar un registro verificable del desempeño.

---

## 🚀 Funcionalidades Principales

### 🍅 1. Ciclo Pomodoro Estricto  
- Alternancia automática entre:
  - **Modo Enfoque (25 min – Rojo)**  
  - **Modo Descanso (5 min – Verde)**
- **Bloqueo de navegación y botones** durante los descansos.
- **Inicio forzoso del descanso** una vez registrada la tarea.
- Evita el *burnout* obligando al usuario a pausar antes de continuar.

---

### 💾 2. Registro y Persistencia (SQLite)
- Guardado local mediante **SQLite** (sqflite).
- Formulario obligatorio al terminar una sesión para asegurar integridad.
- El descanso **no inicia** hasta que el usuario registre o descarte la sesión.
- Evita pérdidas de datos y mantiene una auditoría completa.

---

### 📳 3. Feedback Háptico (Vibración)
- Notificación mediante el motor de vibración del dispositivo.
- Implementado con la librería **vibration**.
- Notifica cambio de modo sin necesidad de mirar la pantalla.

---

### 📜 4. Historial de Sesiones
- Vista cronológica mediante **ListView**.
- Implementación **LIFO**: las sesiones más recientes aparecen primero.
- Muestra descripción, duración y fecha formateada.

---

### 📊 5. Dashboard Estadístico
- Gráfico semanal creado con **fl_chart**.
- Suma de minutos de enfoque por día de la semana (Lun–Dom).
- Permite detectar hábitos y patrones de rendimiento.

---

## 🏛️ Arquitectura de Software

El sistema está construido bajo el patrón **MVVM** e inspirado en principios de **Clean Architecture**, separando la lógica de negocio, la gestión de estado y la interfaz de usuario.


### 📂 Estructura de Carpetas

```plaintext 
lib/
├── data/
│   └── db_helper.dart
├── models/
│   └── session.dart
├── providers/
│   ├── timer_provider.dart
│   └── session_provider.dart
├── screens/
│   ├── home_screen.dart
│   ├── history_screen.dart
│   ├── statistics_screen.dart
│   └── finish_session_dialog.dart
└── widgets/
    └── custom_button.dart
```

---

## 🧰 Stack Tecnológico

| Componente      | Tecnología / Librería | Propósito |
|----------------|------------------------|-----------|
| Lenguaje       | Dart 3.0+              | Desarrollo principal |
| Framework      | Flutter                | UI nativa |
| Estado         | Provider ^6.0.0        | Gestión e inyección |
| BD local       | sqflite ^2.0.0         | Persistencia SQLite |
| Rutas          | path ^1.8.0            | Manejo de archivos |
| Fechas         | intl ^0.18.0           | Formateo |
| Gráficos       | fl_chart ^0.66.0       | Dashboard estadístico |

---

## 🔧 Instalación y Ejecución

1. **Clonar el repositorio**
```bash
git clone https://github.com/ChemmazZZ/examenfinal.git
```

2. **Instalar dependencias**
```bash 
flutter pub get
```

3. **Ejecutar la aplicación**
```bash
flutter run
```
### 👤 Autor

-José Maria Mamani Zuñiga
-Curso: Programación para Dispositivos Móviles
-Docente: Josue Miguel Flores Parra
-Fecha: 06/12/2025
-Proyecto Final – Semestre 2025-2
   
