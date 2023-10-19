import 'package:calculadora_imc/model/tabela_model.dart';
import 'package:calculadora_imc/service/core/sqlite_service.dart';
import 'package:sqflite/sqflite.dart';

class TabelaRepository {
  static late SQLiteService _service;
  static Database? _db;
  static var _tabelas = <TabelaModel>[];

  TabelaRepository._();

  static Future<TabelaRepository> getInstance() async {
    _service = await SQLiteService.getInstance();
    _db ??= _service.getDatabase();
    _tabelas = await _all();
    return TabelaRepository._();
  }

  static Future<List<TabelaModel>> _all() async {
    List<TabelaModel> list = [];
    var result = await _db!.rawQuery('''SELECT * from tabela''');
    for (var e in result) {
      var model = TabelaModel(
          int.tryParse(e["id"].toString()) ?? 0,
          double.tryParse(e["indiceInicial"].toString()) ?? 0,
          double.tryParse(e["indiceFinal"].toString()) ?? 0,
          e["descricao"].toString());
      list.add(model);
    }
    return list;
  }

  List<TabelaModel> getAll() {
    return _tabelas;
  }

  TabelaModel get(double indice) {
    return _tabelas
        .where((t) => t.indiceInicial <= indice && t.indiceFinal > indice)
        .first;
  }

  TabelaModel getById(int id) {
    return _tabelas.where((t) => t.id == id).first;
  }
}
