import 'package:calcu/Calculatrice/CalculariceHistorique.dart';
import 'package:flutter/material.dart';
import 'package:calcu/Calculatrice/CalculatricePage.dart';


void main() {
  //creer la fonction main qui va appeler la fonction CalculatriceApp()
  runApp(CalculatriceAPP());
}
//CalculatriceApp() pour fonctionner necessite un widget
//(stlesswidget de la fonction calculatriceApp) d'abord
class CalculatriceAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculatrice",
      theme: ThemeData(primaryColor: Colors.blue),
      home: CalculatriceEcran(),
      routes: {
        '/Accueil': (context) => CalculatriceEcran(),
        '/Historique' :(context) => HistoriqueCalcu(),
      },
    );
  }


}
