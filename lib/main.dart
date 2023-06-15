import 'package:flutter/material.dart';
import 'package:calcu/Calculatrice/CalculariceHistorique.dart';
import 'package:calcu/Calculatrice/CalculatricePage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() {
  //creer la fonction main qui va appeler la fonction CalculatriceApp()
  Supabase.initialize(
    url: 'https://ptundmtrsdaxtqetgbsk.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB0dW5kbXRyc2RheHRxZXRnYnNrIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODQyNTMxODgsImV4cCI6MTk5OTgyOTE4OH0.0o4wa3-r7gZoFb6DYywUQ3IoEEtBvGbmdjR8ftq-FEA',
  );
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

