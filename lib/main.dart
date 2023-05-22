import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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
    );
  }
  
  
}

class CalculatriceEcran extends StatefulWidget {
  const CalculatriceEcran({Key? key}) : super(key: key);

  @override
  State<CalculatriceEcran> createState() => _CalculatriceEcranState();
}

class _CalculatriceEcranState extends State<CalculatriceEcran> {


  String equation="0";
  String resultat="0";
  String operateur="0";

  ButtonPresse(String TextBouton) {

    print(TextBouton);

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
      try{
        Parser p=Parser();
        Expression exp=p.parse(expression);
        ContextModel cm=ContextModel();
        resultat="${exp.evaluate(EvaluationType.REAL, cm)}";

      }catch(e){

        resultat="Erreur de syntaxe";
        print(e);

      }


      }else{
        if(equation=="0"){
          equation=TextBouton;
        }else{
          equation=equation+TextBouton;
        }
      }
      //equation=equation+TextBouton;

    });
  }



  Widget calculatriceButton(String textBouton,Color couleurText,Color couleurBouton){
    return Container(
      height: MediaQuery.of(context).size.height*0.1,
      color: couleurBouton,
      child: MaterialButton(
          onPressed:()=>ButtonPresse(textBouton),
          padding: EdgeInsets.all(16),
          child:Text(textBouton,style: TextStyle(fontSize: 35,color: couleurText),)) ,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Calculatrice"),
      centerTitle: true,)  ,
      body:Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(20, 10,10,0),
            child: Text(equation,style:TextStyle(fontSize: 30)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(20, 30,10,0),
            child: Text(resultat,style:TextStyle(fontSize: 30)),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment:MainAxisAlignment.center ,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Table(
                    children: [
                      TableRow(
                        children: [
                          calculatriceButton("C", Colors.black, Colors.white),
                          calculatriceButton("CE", Colors.black, Colors.white),
                          calculatriceButton("%", Colors.black, Colors.white),
                          calculatriceButton("÷", Colors.blue, Colors.white),
                        ]
                      ),
                      TableRow(
                          children: [
                            calculatriceButton("7", Colors.black, Colors.white),
                            calculatriceButton("8", Colors.black, Colors.white),
                            calculatriceButton("9", Colors.black, Colors.white),
                            calculatriceButton("*", Colors.blue, Colors.white),
                          ]
                      ),
                      TableRow(
                          children: [
                            calculatriceButton("4", Colors.black, Colors.white),
                            calculatriceButton("5", Colors.black, Colors.white),
                            calculatriceButton("6", Colors.black, Colors.white),
                            calculatriceButton("-", Colors.blue, Colors.white),
                          ]
                      ),
                      TableRow(
                          children: [
                            calculatriceButton("1", Colors.black, Colors.white),
                            calculatriceButton("2", Colors.black, Colors.white),
                            calculatriceButton("3", Colors.black, Colors.white),
                            calculatriceButton("+", Colors.blue, Colors.white),
                          ]
                      ),
                      TableRow(
                          children: [
                            calculatriceButton("⟲", Colors.black, Colors.white),
                            calculatriceButton("0", Colors.black, Colors.white),
                            calculatriceButton(",", Colors.black, Colors.white),
                            calculatriceButton("=", Colors.blue, Colors.white),
                          ]
                      )

                    ],
                  ),
              ),
            ],
          )
        ],
      ) ,
    );
  }
}

