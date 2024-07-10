import 'package:flutter/material.dart';

class InscriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40), // Ajoute de l'espace en haut
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushNamed(context, '/acceuil');
                  },
                ),
                SizedBox(width: 8),
                Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Spacer(flex: 2),
            TextField(
              decoration: InputDecoration(
                hintText: "Nom d'utilisateur",
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Adresse email',
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Mot de passe',
                border: UnderlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (bool? value) {
                    // Action pour la case à cocher
                  },
                ),
                Expanded(
                  child: Text(
                    "Je souhaite recevoir par e-mail des offres personnalisées et les dernières mises à jour de Vinted.",
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (bool? value) {
                    // Action pour la case à cocher
                  },
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: "En t'inscrivant, tu confirmes que tu acceptes les ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Termes & Conditions de Vinted",
                          style: TextStyle(color: Colors.teal, decoration: TextDecoration.underline),
                        ),
                        TextSpan(
                          text: ", avoir lu la ",
                        ),
                        TextSpan(
                          text: "Politique de confidentialité",
                          style: TextStyle(color: Colors.teal, decoration: TextDecoration.underline),
                        ),
                        TextSpan(
                          text: " et avoir au moins 18 ans.",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Action pour le bouton d'inscription
              },
              child: Text("S'inscrire"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: Size(double.infinity, 48), // Largeur infinie et hauteur de 48
              ),
            ),
            Spacer(flex: 3),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  // Action pour un problème
                },
                child: Text('Un problème ?'),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InscriptionScreen(),
  ));
}
