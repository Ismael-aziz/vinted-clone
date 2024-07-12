import 'package:flutter/material.dart';

class InscriptionScreen extends StatefulWidget {
  @override
  _InscriptionScreenState createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {
  bool _checkbox1 = false;
  bool _checkbox2 = false;
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: 'Mot de passe',
                border: UnderlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: _checkbox1,
                  onChanged: (bool? value) {
                    setState(() {
                      _checkbox1 = value!;
                    });
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
                  value: _checkbox2,
                  onChanged: (bool? value) {
                    setState(() {
                      _checkbox2 = value!;
                    });
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
              child: Text("S'inscrire", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                backgroundColor: Colors.teal,
                minimumSize: Size(250, 48),
              ),
            ),
            Spacer(flex: 30),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  // Action pour un problème
                },
                child: Text('Un problème ?', style: TextStyle(color: Colors.teal)),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
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
