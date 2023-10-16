import 'package:calculadora_imc/model/tabela.dart';
import 'package:calculadora_imc/service/tabela_service.dart';
import 'package:flutter/material.dart';

class Registro {
  final int _id = UniqueKey().hashCode;
  final DateTime _dateTime = DateTime.now();
  final double _peso;
  final double _altura;
  double _indice = 0;
  Tabela? _tabela;

  Registro(this._peso, this._altura) {
    _indice = (_peso / (_altura * _altura));
    _tabela = TabelaService.instance.get(indice);
  }

  get id => _id;
  get dateTime => _dateTime;
  get peso => _peso;
  get altura => _altura;
  get indice => _indice;
  Tabela? get tabela => _tabela;
}
