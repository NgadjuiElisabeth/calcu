import 'package:calcu/Calculatrice/CalculariceHistorique.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math';
import 'package:calcu/Calculatrice/CalculatricePage.dart';


void main() {
  //creer la fonction main qui va appeler la fonction CalculatriceApp()
  Supabase.initialize(
    url: 'https://ptundmtrsdaxtqetgbsk.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB0dW5kbXRyc2RheHRxZXRnYnNrIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODQyNTMxODgsImV4cCI6MTk5OTgyOTE4OH0.0o4wa3-r7gZoFb6DYywUQ3IoEEtBvGbmdjR8ftq-FEA',
  );
  runApp(CalculatriceAPP());
}

//C'est la fonction pour récupérer les données dans la supabase
Future<List<Map<String, dynamic>>> getDataToSupabase() async {
    final supabase = Supabase.instance.client;

    // Nom de la table contenant les données à récupérer
    String tableName = 'history';

    final response = await supabase.from(tableName).select('*').order('created_at', ascending: false).limit(5).execute();
    List<Map<String, dynamic>> extractedData = [];
    for (final entry in response.data) {
      Map<String, dynamic> extractedValues = {
        'calcul': entry['calcul'],
        'result': entry['result'],
      };
      extractedData.add(extractedValues);
    }
    return extractedData;
}

//c'est la fonction pour envoyer les données dans la supabase
void sendDataToSupabase(String calcul,String result) async {
  final supabase = Supabase.instance.client;
  Random random = Random();
  int id = random.nextInt(100000);
  // Données à envoyer
  Map<String, dynamic> data = {
    'id': id,
    'calcul': calcul,
    'result': result,
  };

  // Table dans laquelle les données seront insérées
  String tableName = 'history';
  final response = await supabase.from(tableName).insert([data]).execute();
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
