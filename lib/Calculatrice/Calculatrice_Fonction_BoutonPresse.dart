import 'package:flutter/material.dart';

class calcuButtonPresse extends StatelessWidget {
  final String textBouton;
  final Color couleurText;
  final Color couleurBouton;
  final Function(String) onPressed;

  const calcuButtonPresse({
    required this.textBouton,
    required this.couleurText,
    required this.couleurBouton,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      color: couleurBouton,
      child: MaterialButton(
        onPressed: () => onPressed(textBouton),
        padding: EdgeInsets.all(16),
        child: Text(
          textBouton,
          style: TextStyle(fontSize: 35, color: couleurText),
        ),
      ),
    );
  }
}
