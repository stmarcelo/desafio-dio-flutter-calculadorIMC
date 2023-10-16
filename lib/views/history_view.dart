import 'package:calculadora_imc/model/registro.dart';
import 'package:calculadora_imc/service/registro_service.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => HistoryViewState();
}

class HistoryViewState extends State<HistoryView> {
  List<Registro>? _registros;

  @override
  void initState() {
    super.initState();

    _loadDados();
  }

  void _loadDados() async {
    _registros = await RegistroService.instance.getAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_registros == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_registros!.isEmpty) {
      return const Center(
          child: Padding(
        padding: EdgeInsets.all(15),
        child: Text("Histórico vazio."),
      ));
    }
    return ListView.builder(
        itemCount: _registros!.length,
        itemBuilder: (BuildContext bc, int i) {
          return _listCard(_registros![i]);
        });
  }

  Widget _listCard(Registro reg) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 2,
        runSpacing: 2,
        children: [
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info),
                      const SizedBox(width: 10),
                      Text(
                        reg.tabela?.descricao,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  Row(children: [
                    const SizedBox(width: 26),
                    const SizedBox(width: 10),
                    Text(
                      "Índice ${reg.indice.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ]),
                  const SizedBox(height: 15),
                  Row(children: [
                    Wrap(children: [
                      const Icon(Icons.monitor_weight),
                      const SizedBox(width: 10),
                      Text(reg.peso.toStringAsFixed(2)),
                    ]),
                    const SizedBox(width: 15),
                    Wrap(children: [
                      const Icon(Icons.height),
                      Text(reg.altura.toStringAsFixed(2)),
                    ]),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Wrap(children: [
                      Text(reg.dateTime.toLocal().toString()),
                    ]),
                  ]),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
