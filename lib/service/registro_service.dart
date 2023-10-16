import 'package:calculadora_imc/model/registro.dart';

class RegistroService {
  static final RegistroService instance = RegistroService._();
  List<Registro>? _registros;

  RegistroService._() {
    _registros = [];
  }

  Future add(Registro registro) async {
    _registros!.add(registro);
  }

  Future<List<Registro>> getAll() async {
    return _registros!;
  }
}
