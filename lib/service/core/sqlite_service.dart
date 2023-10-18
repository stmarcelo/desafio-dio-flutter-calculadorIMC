import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class SQLLiteService {
  Database? _db;
  final Map<int, String> _scripts = {
    1: '''
    CREATE TABLE resultado (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dataHora INTEGER,
        peso NUMBER,
        indice NUMBER
        ); 
    '''
  };

  Future<Database> getDatabase() async {
    _db ??= await _init();
    return _db!;
  }

  Future close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }

  Future<Database> _init() async {
    _db = await openDatabase(
        path.join(await getDatabasesPath(), 'calculadoraimc.db'),
        onCreate: (db, version) async {
      for (var i = 1; i <= _scripts.length; i++) {
        await _db!.execute(_scripts[i]!);
      }
    }, onUpgrade: (db, oldVersion, newVersion) async {
      for (var i = oldVersion + 1; i <= _scripts.length; i++) {
        await _db!.execute(_scripts[i]!);
      }
    });
    return _db!;
  }
}
