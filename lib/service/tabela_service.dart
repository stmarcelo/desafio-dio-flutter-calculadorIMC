import 'package:calculadora_imc/model/tabela.dart';

class TabelaService {
  static final TabelaService instance = TabelaService._();
  var _tabelas = <Tabela>[];

  TabelaService._() {
    _tabelas = <Tabela>[
      Tabela(0, 16, "Magreza grave"),
      Tabela(16, 17, "Magreza moderada"),
      Tabela(17, 18.5, "Magreza leve"),
      Tabela(18.5, 25, "Saudável"),
      Tabela(25, 30, "Sobrepeso"),
      Tabela(30, 35, "Obesidade grau I"),
      Tabela(35, 40, "Obesidade grau II (severa)"),
      Tabela(40, 999, "Obesidade grau III (mórbida)"),
    ];
  }

  List<Tabela> getAll() {
    return _tabelas;
  }

  Tabela get(double indice) {
    return _tabelas
        .where((t) => t.indiceInicial <= indice && t.indiceFinal > indice)
        .first;
  }

  Tabela getById(int id) {
    return _tabelas.where((t) => t.id == id).first;
  }
}
