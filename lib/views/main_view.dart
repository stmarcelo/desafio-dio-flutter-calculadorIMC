import 'package:calculadora_imc/model/registro.dart';
import 'package:calculadora_imc/service/registro_service.dart';
import 'package:calculadora_imc/views/history_view.dart';
import 'package:calculadora_imc/views/home_view.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final GlobalKey<HistoryViewState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
          bottom: const TabBar(tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.history))
          ]),
        ),
        body: TabBarView(children: [
          const HomeView(),
          HistoryView(
            key: _key,
          )
        ]),
        floatingActionButton: FloatingActionButton(
          elevation: 15,
          onPressed: () {
            _callNew(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    ));
  }

  void _callNew(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var _pesoController = TextEditingController();
    var _alturaController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return AlertDialog(
            title: const Text("Novo calculo de IMC"),
            content: Hero(
              tag: "imc",
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(children: [
                    Form(
                        key: _formKey,
                        child: Column(children: [
                          TextFormField(
                            autofocus: true,
                            controller: _pesoController,
                            decoration: const InputDecoration(
                                label: Text("Peso (kg)"),
                                icon: Icon(Icons.monitor_weight)),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true, signed: false),
                            validator: (String? value) {
                              return _validaCampos(value);
                            },
                          ),
                          TextFormField(
                            autofocus: true,
                            controller: _alturaController,
                            decoration: const InputDecoration(
                                label: Text("Altura (m)"),
                                icon: Icon(Icons.height)),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true, signed: false),
                            validator: (String? value) {
                              return _validaCampos(value);
                            },
                          ),
                        ]))
                  ])),
            ),
            actions: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel),
                label: const Text("Cancelar"),
              ),
              ElevatedButton.icon(
                  onPressed: () async {
                    _pesoController.text =
                        _pesoController.text.replaceAll(",", ".");
                    _alturaController.text =
                        _alturaController.text.replaceAll(",", ".");
                    if (_formKey.currentState!.validate()) {
                      var peso = double.tryParse(_pesoController.text) ?? 0;
                      var altura = double.tryParse(_alturaController.text) ?? 0;
                      var reg = Registro(peso, altura);
                      await RegistroService.instance.add(reg);
                      _showResult(reg);
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: const Text("Salvar")),
            ],
          );
        });
  }

  String? _validaCampos(String? value) {
    double? converted = double.tryParse(value ?? "");
    if (converted == null || converted == 0) {
      return "Número inválido.";
    }
    return null;
  }

  void _showResult(Registro reg) {
    _key.currentState?.setState(() {});
    Navigator.pop(context);
    setState(() {});
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        context: context,
        builder: (bc) {
          return _result(reg);
        });
  }

  Widget _result(Registro registro) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 2,
        runSpacing: 2,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("IMC Registrado!"),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 10,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.info),
                  const SizedBox(width: 10),
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      Text(
                        registro.tabela?.descricao,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Índice: ${registro.indice.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 10,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.monitor_weight),
                  const SizedBox(width: 10),
                  Text("Peso: ${registro.peso.toStringAsFixed(2)}"),
                  const SizedBox(width: 20),
                  const Icon(Icons.height),
                  const SizedBox(width: 10),
                  Text("Altura: ${registro.altura.toStringAsFixed(2)}"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
