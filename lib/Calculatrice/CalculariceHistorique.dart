import 'package:flutter/material.dart';

class HistoriqueCalcu extends StatelessWidget {
  const HistoriqueCalcu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculatrice_Historique"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Page d'historique",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Accueil'); // Navigation vers la page d'accueil
              },
              child: Text("Retour à l'accueil"),
            ),
          ],
        ),
      ),
    );
  }
}
