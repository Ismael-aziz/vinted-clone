import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InscriptionScreen extends StatefulWidget {
  const InscriptionScreen({super.key});

  @override
  _InscriptionScreenState createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _checkbox1 = false;
  bool _checkbox2 = false;
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _register(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Enregistrement des données utilisateur dans Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'password': _passwordController.text.trim(),
        // Ajoutez d'autres champs si nécessaire
      });

      // Affichage d'un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inscription réussie')),
      );

      // Navigation vers l'écran de connexion après inscription réussie
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      // Gestion des erreurs lors de l'inscription
      print('Erreur lors de l\'inscription: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de l\'inscription')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40), // Espace en haut
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushNamed(context, '/acceuil');
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(flex: 2),
            TextField(
              key: const Key('nameField'), // Clé pour gérer l'état du champ
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: "Nom d'utilisateur",
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              key: const Key('emailField'), // Clé pour gérer l'état du champ
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Adresse email',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              key: const Key('passwordField'), // Clé pour gérer l'état du champ
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: 'Mot de passe',
                border: const UnderlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
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
                const Expanded(
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
                    text: const TextSpan(
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
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _register(context),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                backgroundColor: Colors.teal,
                minimumSize: const Size(250, 48),
              ),
              child: const Text("S'inscrire", style: TextStyle(color: Colors.white)),
            ),
            const Spacer(flex: 30),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  // Action pour un problème
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: const Text('Un problème ?', style: TextStyle(color: Colors.teal)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
