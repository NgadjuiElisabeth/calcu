import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HistoriqueCalcu extends StatefulWidget {
  const HistoriqueCalcu({Key? key}) : super(key: key);

  @override
  _HistoriqueCalcuState createState() => _HistoriqueCalcuState();
}

class _HistoriqueCalcuState extends State<HistoriqueCalcu> {
  Future<List<Map<String, dynamic>>> getDataToSupabase() async {
    final supabase = Supabase.instance.client;

    // Nom de la table contenant les données à récupérer
    String tableName = 'history';

    final response = await supabase
        .from(tableName)
        .select('*')
        .order('created_at', ascending: false)
        .limit(5)
        .execute();
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
            FutureBuilder<List<Map<String, dynamic>>>(
              future: getDataToSupabase(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erreur : ${snapshot.error}');
                } else {
                  List<Map<String, dynamic>> data = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(data[index]['calcul']),
                        subtitle: Text(data[index]['result']),
                      );
                    },
                  );
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Accueil');
              },
              child: Text("Retour à l'accueil"),
            ),
          ],
        ),
      ),
    );
  }
}
