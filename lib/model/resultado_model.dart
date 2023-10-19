import 'package:calculadora_imc/model/tabela_model.dart';

class ResultadoModel {
  int _id = 0;
  DateTime _dateTime = DateTime.now();
  double _peso = 0;
  double _altura = 0;
  double _indice = 0;
  TabelaModel? _tabela;

  ResultadoModel();

  int get id => _id;
  set id(int value) => _id = value;

  DateTime get dateTime => _dateTime;
  set dateTime(DateTime value) => _dateTime = value;

  double get peso => _peso;
  set peso(double value) => _peso = value;

  double get altura => _altura;
  set altura(double value) => _altura = value;

  double get indice => _indice;
  set indice(double value) => _indice = value;

  TabelaModel? get tabela => _tabela;
  set tabela(TabelaModel? value) => _tabela = value;
}
