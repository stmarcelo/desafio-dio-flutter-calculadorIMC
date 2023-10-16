import 'package:flutter/material.dart';

class Tabela {
  final UniqueKey _id = UniqueKey();
  final double _indiceInicial, _indiceFinal;
  final String _descricao;

  Tabela(this._indiceInicial, this._indiceFinal, this._descricao);

  get id => _id;
  get indiceInicial => _indiceInicial;
  get indiceFinal => _indiceFinal;
  get descricao => _descricao;
}
