import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calcu/Calculatrice/Calculatrice_Fonction_BoutonPresse.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math';

class CalculatriceEcran extends StatefulWidget {
  const CalculatriceEcran({Key? key}) : super(key: key);


  @override
  State<CalculatriceEcran> createState() => _CalculatriceEcranState();
}

class _CalculatriceEcranState extends State<CalculatriceEcran> {
  String equation = "0";
  String resultat = "0";
  String operateur = "0";
  String selectedPage = 'Accueil';
  List<String> pages = ['Accueil', 'Historique'];
  final supabase = Supabase.instance.client;

  void sendDataToSupabase(String calcul,String result) async {

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

  void boutonPresse(String TextBouton) {
    setState(() {
      if(TextBouton=="C"){
        equation="0";
        resultat="0";
      }
      else if(TextBouton=="CE"){
        equation=equation.substring(0,equation.length-1);
        if(equation.isEmpty){
          equation="0";
        }
      }
      else if(TextBouton=="="){
        String expression=equation;
        expression= expression.replaceAll("÷", "/");
        bool isPourcent = false;
        if(expression.contains('%')) {
          expression = expression.replaceAll('%', "/100*");
          isPourcent = true;
        }
        expression = expression.replaceAll(',',".");
        expression = expression.replaceAll('R',resultat);
        if(expression.endsWith('*') && isPourcent){
          expression = expression + "1";
        }
        print(expression);
        try{
          Parser p=Parser();
          Expression exp=p.parse(expression);

          ContextModel cm=ContextModel();
          resultat="${exp.evaluate(EvaluationType.REAL, cm)}";
          sendDataToSupabase(expression, resultat);

        }catch(e){

          resultat="Erreur de syntaxe";
          print(e);
        }
        equation = "0";
      }
      else{
        if(equation=="0" && TextBouton == "0"){
          equation="0";
        }
        else if(equation=="0" && (isNumeric(TextBouton) || TextBouton =="R")){
          equation=TextBouton;

        }
        else if (equation == "0" && resultat != "0" && !isNumeric(TextBouton) && equation.length <2){
          if(TextBouton !=",") {
            equation = equation + TextBouton;
            equation = equation.replaceAll('0', resultat);
          }
          else{
            equation = "0,";
          }
        }
        else{
          equation=equation+TextBouton;
        }
      }
      //equation=equation+TextBouton;

    });
  }
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
  // fonction pour naviguer entre page
  void navigateToPage(String page) {
    setState(() {
      selectedPage = page;
    });
    //pour naviguer
    if (page == 'Accueil') {
      Navigator.pushReplacementNamed(context, '/Accueil');
    } else if (page == 'Historique') {
      Navigator.pushReplacementNamed(context, '/Historique');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculatrice_Accueil"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: 30)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(20, 30, 10, 0),
            child: Text(resultat, style: TextStyle(fontSize: 30)),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        calcuButtonPresse(
                          textBouton: "C",
                          couleurText: Colors.black,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                        calcuButtonPresse(
                          textBouton: "CE",
                          couleurText: Colors.black,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                        calcuButtonPresse(
                          textBouton: "%",
                          couleurText: Colors.black,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                        calcuButtonPresse(
                          textBouton: "÷",
                          couleurText: Colors.blue,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        calcuButtonPresse(
                          textBouton: "7",
                          couleurText: Colors.black,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                        calcuButtonPresse(
                          textBouton: "8",
                          couleurText: Colors.black,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                        calcuButtonPresse(
                          textBouton: "9",
                          couleurText: Colors.black,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                        calcuButtonPresse(
                          textBouton: "*",
                          couleurText: Colors.blue,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        calcuButtonPresse(
                          textBouton: "4",
                          couleurText: Colors.black,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                        calcuButtonPresse(
                          textBouton: "5",
                          couleurText: Colors.black,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                        calcuButtonPresse(
                          textBouton: "6",
                          couleurText: Colors.black,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                        calcuButtonPresse(
                          textBouton: "-",
                          couleurText: Colors.blue,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        calcuButtonPresse(
                          textBouton: "1",
                          couleurText: Colors.black,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                        calcuButtonPresse(
                          textBouton: "2",
                          couleurText: Colors.black,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                        calcuButtonPresse(
                          textBouton: "3",
                          couleurText: Colors.black,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                        calcuButtonPresse(
                          textBouton: "+",
                          couleurText: Colors.blue,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          width: 10,
                          alignment: Alignment.center,
                          child: DropdownButton<String>(
                            value: selectedPage,
                            items: pages.map((String page) {
                              return DropdownMenuItem<String>(
                                value: page,
                                child: Text(page),
                              );
                            }).toList(),
                            onChanged: (value) {
                              navigateToPage(value as String);
                            },
                          ),
                        ),
                        calcuButtonPresse(
                          textBouton: "0",
                          couleurText: Colors.black,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                        calcuButtonPresse(
                          textBouton: ",",
                          couleurText: Colors.black,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                        calcuButtonPresse(
                          textBouton: "=",
                          couleurText: Colors.blue,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
