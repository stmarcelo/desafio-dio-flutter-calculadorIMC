import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class SQLiteService {
  static Database? _db;
  static final Map<int, String> _scripts = {
    1: '''
    CREATE TABLE tabela (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        indiceInicial REAL,
        indiceFinal REAL,
        descricao TEXT
    );
    CREATE TABLE resultado (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tabela_id INTEGER,
        dataHora INTEGER,
        peso REAL,
        altura REAL,
        indice REAL
        );
    INSERT INTO tabela (indiceInicial,indiceFinal,descricao) VALUES
        (0, 16, "Magreza grave"),
        (16, 17, "Magreza moderada"),
        (17, 18.5, "Magreza leve"),
        (18.5, 25, "Saudável"),
        (25, 30, "Sobrepeso"),
        (30, 35, "Obesidade grau I"),
        (35, 40, "Obesidade grau II (severa)"),
        (40, 999, "Obesidade grau III (mórbida)")
    '''
  };

  SQLiteService._();

  static Future<SQLiteService> getInstance() async {
    _db ??= await _init();
    return SQLiteService._();
  }

  Database getDatabase() {
    return _db!;
  }

  static Future<Database> _init() async {
    var dbPath = path.join(await getDatabasesPath(), 'calcims.db');
    //await deleteDatabase(dbPath);
    return await openDatabase(dbPath, version: _scripts.length,
        onCreate: (db, version) async {
      var scripts = _scripts[version]!.split(';');
      for (var s in scripts) {
        if (s.trim().isNotEmpty) {
          await db.execute(s);
        }
      }
    }, onUpgrade: (db, oldVersion, newVersion) async {});
  }
}
