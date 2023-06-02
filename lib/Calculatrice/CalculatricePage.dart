import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calcu/Calculatrice/Calculatrice_Fonction_BoutonPresse.dart';

class CalculatriceEcran extends StatefulWidget {
  const CalculatriceEcran({Key? key}) : super(key: key);

  @override
  State<CalculatriceEcran> createState() => _CalculatriceEcranState();
}

class _CalculatriceEcranState extends State<CalculatriceEcran> {
  String equation = "0";
  String resultat = "0";
  String operateur = "0";

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
          //print("on est la");
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculatrice"),
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
                        calcuButtonPresse(
                          textBouton: "⟲",
                          couleurText: Colors.black,
                          couleurBouton: Colors.white,
                          onPressed: boutonPresse,
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

