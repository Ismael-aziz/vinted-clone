import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
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
                  "Se connecter",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Spacer(flex: 2),
            TextField(
              decoration: InputDecoration(
                hintText: 'Identifiant ou adresse email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Mot de passe',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off),

              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Action pour le bouton de connexion
              },
              child: Text('Se connecter', style: TextStyle(color: Colors.white) ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                backgroundColor: Colors.teal,
                minimumSize: Size(double.infinity, 48), // Largeur infinie et hauteur de 48
              ),

            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  // Action pour mot de passe oublié
                },
                child: Text('Mot de passe oublié ?' ,style: TextStyle(color: Colors.teal) ),
                style: TextButton.styleFrom(
                ),
              ),
            ),
            Spacer(flex: 3),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  // Action pour un problème
                },
                child: Text('Un problème ?',style: TextStyle(color: Colors.teal)),
                style: TextButton.styleFrom(

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
    home: LoginScreen(),
  ));
}
