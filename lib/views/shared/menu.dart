import 'dart:io';

import 'package:calculadora_imc/views/settings_view.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget MenuWidget(BuildContext context) {
  return Drawer(
    elevation: 10,
    child: ListView(children: [
      InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (bc) => const SettingsView()));
          },
          child: const ListTile(
            leading: Icon(Icons.settings),
            title: Text("Configurações"),
          )),
      const Divider(),
      InkWell(
        onTap: () {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Deseja realmente sair do app?"),
              content: const Wrap(),
              actions: [
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text("Cancelar")),
                ElevatedButton.icon(
                    onPressed: () {
                      exit(0);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text("Sair")),
              ],
            ),
          );
        },
        child: const ListTile(
          leading: Icon(Icons.logout),
          title: Text("Sair do app"),
        ),
      )
    ]),
  );
}
