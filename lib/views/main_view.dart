import 'package:calculadora_imc/model/resultado_model.dart';
import 'package:calculadora_imc/repository/resultado_repository.dart';
import 'package:calculadora_imc/repository/settings_repository.dart';
import 'package:calculadora_imc/views/history_view.dart';
import 'package:calculadora_imc/views/home_view.dart';
import 'package:calculadora_imc/views/shared/menu.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final GlobalKey<HistoryViewState> _keyHistory = GlobalKey();
  late ResultadoRepository repository;
  late SettingsRepository settingsRepository;

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future _loadServices() async {
    repository = await ResultadoRepository.getInstance();
    settingsRepository = await SettingsRepository.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: MenuWidget(context),
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
          bottom: const TabBar(tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.history))
          ]),
        ),
        body: TabBarView(
            children: [const HomeView(), HistoryView(key: _keyHistory)]),
        floatingActionButton: FloatingActionButton(
          elevation: 15,
          onPressed: () {
            newIMC();
          },
          child: const Icon(Icons.add),
        ),
      ),
    ));
  }

  Future newIMC() async {
    final formKey = GlobalKey<FormState>();
    ResultadoModel registroModel = ResultadoModel();

    var settings = settingsRepository.get();

    registroModel.altura = settings.stature;

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
                        key: formKey,
                        child: Column(children: [
                          TextFormField(
                            autofocus: true,
                            decoration: const InputDecoration(
                                label: Text("Peso (kg)"),
                                icon: Icon(Icons.monitor_weight)),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true, signed: false),
                            validator: (String? value) {
                              return _validaCampos(value);
                            },
                            onChanged: (value) => registroModel.peso =
                                double.tryParse(value) ?? 0,
                          ),
                          TextFormField(
                            controller: TextEditingController(
                                text: settings.stature.toString()),
                            autofocus: true,
                            decoration: const InputDecoration(
                                label: Text("Altura (m)"),
                                icon: Icon(Icons.height)),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true, signed: false),
                            validator: (String? value) {
                              return _validaCampos(value);
                            },
                            onChanged: (value) => registroModel.altura =
                                double.tryParse(value) ?? 0,
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
                    if (formKey.currentState!.validate()) {
                      repository.create(registroModel);
                      _showResult(registroModel);
                      _keyHistory.currentState?.refresh();
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

  void _showResult(ResultadoModel reg) {
    Navigator.pop(context);
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        context: context,
        builder: (bc) {
          return _result(reg);
        });
  }

  Widget _result(ResultadoModel registro) {
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
                        registro.tabela?.descricao ?? "",
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
              padding: const EdgeInsets.all(8),
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
