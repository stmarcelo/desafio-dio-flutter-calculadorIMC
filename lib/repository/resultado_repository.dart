import 'package:calculadora_imc/model/resultado_model.dart';
import 'package:calculadora_imc/model/tabela_model.dart';
import 'package:calculadora_imc/service/core/sqlite_service.dart';
import 'package:calculadora_imc/repository/tabela_repository.dart';
import 'package:sqflite/sqflite.dart';

class ResultadoRepository {
  static late SQLiteService _service;
  static Database? _db;
  static TabelaRepository? _reposity;

  ResultadoRepository._();

  static Future<ResultadoRepository> getInstance() async {
    _service = await SQLiteService.getInstance();
    _db ??= _service.getDatabase();
    _reposity ??= await TabelaRepository.getInstance();
    return ResultadoRepository._();
  }

  Future<ResultadoModel> create(ResultadoModel model) async {
    _set(model);
    int id = await _db!.rawInsert(
        "INSERT INTO resultado(tabela_id, dataHora, peso,altura,indice)values(?,?,?,?,?)",
        [
          model.tabela!.id,
          model.dateTime.millisecondsSinceEpoch,
          model.peso,
          model.altura,
          model.indice
        ]);
    model.id = id;
    return model;
  }

  Future<List<ResultadoModel>> getAll() async {
    List<ResultadoModel> list = [];
    var result = await _db!
        .rawQuery('''SELECT r.*, t.indiceInicial, t.indiceFinal, t.descricao
        FROM resultado r
        INNER JOIN tabela t on t.id = r.tabela_id
        ORDER BY dataHora DESC''');
    for (var e in result) {
      var model = ResultadoModel();
      model.id = int.tryParse(e["id"].toString()) ?? 0;
      model.tabela = TabelaModel(
          int.tryParse(e["id"].toString()) ?? 0,
          double.tryParse(e["indiceInicial"].toString()) ?? 0,
          double.tryParse(e["indiceFinal"].toString()) ?? 0,
          e["descricao"].toString());
      model.dateTime = DateTime.fromMillisecondsSinceEpoch(
          int.tryParse(e["dataHora"].toString()) ?? 0);
      model.peso = double.tryParse(e["peso"].toString()) ?? 0;
      model.altura = double.tryParse(e["altura"].toString()) ?? 0;
      model.indice = double.tryParse(e["indice"].toString()) ?? 0;
      list.add(model);
    }
    return list;
  }

  _set(ResultadoModel model) async {
    model.indice = (model.peso / (model.altura * model.altura));
    model.tabela = _reposity?.get(model.indice);
  }
}
