# 📘 Bitácora de Enfoque  
Aplicación móvil Flutter para la gestión de tiempo y productividad académica.

## 📄 Descripción General

**Bitácora de Enfoque** es una aplicación móvil desarrollada en **Flutter** bajo la arquitectura **Offline-First**, diseñada para ayudar a estudiantes a medir, registrar y analizar su tiempo real de estudio. Combina un temporizador tipo **Pomodoro**, un sistema de persistencia local con **SQLite** y un dashboard estadístico que permite visualizar patrones de productividad.

La app funciona completamente **sin conexión a internet**, ofreciendo control total sobre las sesiones registradas.

---

## 🎯 Problema que Resuelve

En el entorno universitario es común confundir *estar ocupado* con *ser productivo*.  
Los estudiantes suelen no tener métricas claras del tiempo real dedicado al estudio, lo que afecta su rendimiento académico.

**Bitácora de Enfoque** ofrece una solución práctica para medir, registrar y analizar ese tiempo de manera verificable.

---

## 🚀 Funcionalidades Principales

### ⏱️ 1. Módulo de Temporizador (Pomodoro)
- Diseño minimalista con progreso circular.  
- Manejo de estados: **Running**, **Paused**, **Stopped**.  
- Retroalimentación visual inmediata.

### 💾 2. Módulo de Persistencia (SQLite)
- Registro automático de cada sesión al finalizar.  
- Formulario editable para ajustar la duración real.  
- Base de datos local mediante **sqflite**.

### 📜 3. Historial (Bitácora)
- Lista cronológica (**LIFO**) de sesiones.  
- Muestra: descripción, fecha formateada y duración.  
- Construida con **ListView**.

### 📊 4. Dashboard Estadístico
- Gráficos con **fl_chart**.  
- Agrupación semanal de datos.  
- Muestra minutos de enfoque por día (Lun–Dom).

---

## 🏛️ Arquitectura de Software

El proyecto usa el patrón **MVVM** y principios de **Clean Architecture** para un código modular y escalable.

### 📂 Estructura de Carpetas

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
git clone https://github.com/TU_USUARIO/bitacora_enfoque.git

