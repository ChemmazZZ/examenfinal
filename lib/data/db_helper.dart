import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/session.dart';

class DBHelper {
  // patron singleton: una unica instancia para toda la app
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  // getter para obtener la base de datos (si no existe la inicia)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bitacora.db');
    return _database!;
  }

  // inicializa la base de datos en el sistema de archivos
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // xrea la tabla si es la primera vez que se abre la app
  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE sessions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      description TEXT NOT NULL,
      durationMinutes INTEGER NOT NULL,
      date TEXT NOT NULL
    )
    ''');
  }

  // CRUD crear una nueva sesión
  Future<int> insertSession(Session session) async {
    final db = await instance.database;
    return await db.insert('sessions', session.toMap());
  }

  // CRUD leer todas las sesiones
  Future<List<Session>> getAllSessions() async {
    final db = await instance.database;
    // ordenamos por ID descendente para que las nuevas salgan arriba
    final result = await db.query('sessions', orderBy: 'id DESC');
    return result.map((json) => Session.fromMap(json)).toList();
  }
}