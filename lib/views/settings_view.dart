import 'package:calculadora_imc/model/settings_model.dart';
import 'package:calculadora_imc/repository/settings_repository.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late SettingsRepository _repository;
  SettingsModel _model = SettingsModel();
  bool _loading = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future _loadData() async {
    _repository = await SettingsRepository.getInstance();
    _model = _repository.get();
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const SafeArea(
          child: Scaffold(body: Center(child: CircularProgressIndicator())));
    }
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
          ),
          body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: TextEditingController(text: _model.userName),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person), label: Text("Nome")),
                      autofocus: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "campo obrigatório";
                        }
                        return null;
                      },
                      onChanged: (value) => _model.userName = value,
                    ),
                    TextFormField(
                      controller: TextEditingController(
                          text: _model.stature.toString()),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.height),
                          label: Text("Altura (m)")),
                      autofocus: true,
                      validator: (value) {
                        if (double.tryParse(value!) == null) {
                          return "campo com valor válido obrigatório";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _model.stature = double.tryParse(value) ?? 0;
                      },
                    ),
                    Expanded(flex: 3, child: Container()),
                    ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            _repository.set(_model);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Configuração salva."),
                              backgroundColor: Colors.green,
                            ));
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text("Salvar"))
                  ],
                ),
              ))),
    );
  }
}
