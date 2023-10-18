import 'package:calculadora_imc/model/tabela_model.dart';

class TabelaService {
  static final TabelaService instance = TabelaService._();
  var _tabelas = <TabelaModel>[];

  TabelaService._() {
    _tabelas = <TabelaModel>[
      TabelaModel(0, 16, "Magreza grave"),
      TabelaModel(16, 17, "Magreza moderada"),
      TabelaModel(17, 18.5, "Magreza leve"),
      TabelaModel(18.5, 25, "Saudável"),
      TabelaModel(25, 30, "Sobrepeso"),
      TabelaModel(30, 35, "Obesidade grau I"),
      TabelaModel(35, 40, "Obesidade grau II (severa)"),
      TabelaModel(40, 999, "Obesidade grau III (mórbida)"),
    ];
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
