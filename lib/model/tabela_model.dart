class TabelaModel {
  final int _id;
  final double _indiceInicial, _indiceFinal;
  final String _descricao;

  TabelaModel(
      this._id, this._indiceInicial, this._indiceFinal, this._descricao);

  int get id => _id;
  double get indiceInicial => _indiceInicial;
  double get indiceFinal => _indiceFinal;
  String get descricao => _descricao;
}
