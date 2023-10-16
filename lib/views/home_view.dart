import 'package:calculadora_imc/core/app_images.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.logo),
              fit: BoxFit.cover,
              opacity: 0.30)),
      child: const Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Calculadora de  Índice de Massa Corporal (IMC)",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text(
                "Você sabe quanto você precisa emagrecer — ou ainda, se realmente precisa emagrecer?\nO emagrecimento não é só uma questão estética. Manter o peso ideal ou não conseguir mantê-lo traz diversas implicações à saúde.\nPor isso, é muito importante conhecer seu seu Índice de Massa Corporal (IMC). Trata-se de um cálculo recomendado pela Organização Mundial da Saúde para definir se uma pessoa está dentro de sua faixa de normal, se ela tem sobrepeso ou ainda se o seu peso é mais baixo que o ideal para sua altura."),
          ],
        ),
      ),
    );
  }
}
