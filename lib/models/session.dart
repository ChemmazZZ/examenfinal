class Session {
  final int? id;                 // ID autoincremental de la BD
  final String description;      // "en qué trabajaste?"
  final int durationMinutes;     // duración (ej. 25 min)
  final String date;             // fecha y hora en formato texto

  Session({
    this.id,
    required this.description,
    required this.durationMinutes,
    required this.date,
  });

  // Convierte el objeto a un Mapa (JSON) para guardarlo en sqlite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'durationMinutes': durationMinutes,
      'date': date,
    };
  }

  // Crea un objeto Session a partir de un Mapa (recuperado de sqite)
  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'],
      description: map['description'],
      durationMinutes: map['durationMinutes'],
      date: map['date'],
    );
  }
}