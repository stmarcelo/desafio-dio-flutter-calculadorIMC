import 'package:calculadora_imc/model/registro_model.dart';

class RegistroService {
  static final RegistroService instance = RegistroService._();
  List<RegistroModel>? _registros;

  RegistroService._() {
    _registros = [];
  }

  Future add(RegistroModel registro) async {
    _registros!.add(registro);
  }

  Future<List<RegistroModel>> getAll() async {
    return _registros!;
  }
}
