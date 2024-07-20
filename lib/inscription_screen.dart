import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class InscriptionScreen extends StatefulWidget {
  const InscriptionScreen({Key? key}) : super(key: key);

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

  String? _errorMessage;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool _validateFields() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        !_validateEmail(_emailController.text) ||
        !_checkbox2) {
      return false;
    }
    return true;
  }

  Future<void> _register(BuildContext context) async {
    if (!_validateFields()) {
      setState(() {
        _errorMessage = 'Veuillez remplir tous les champs';
      });
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Ajouter l'utilisateur à Firestore avec un solde par défaut de 0
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'password': _passwordController.text.trim(),
        'solde': 0,  // Solde par défaut
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inscription réussie')),
      );

      Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'email-already-in-use') {
          _errorMessage = 'Cette adresse e-mail est déjà utilisée.';
        } else if (e.code == 'invalid-email') {
          _errorMessage = 'L\'adresse e-mail est invalide.';
        } else if (e.code == 'weak-password') {
          _errorMessage = 'Le mot de passe est trop faible.';
        } else {
          _errorMessage = 'Une erreur est survenue. Veuillez réessayer.';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Une erreur est survenue. Veuillez réessayer.';
      });
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
            const SizedBox(height: 38), // Espace en haut
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushNamed(context, '/acceuil');
                  },
                ),
                const SizedBox(width: 6),
                const Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(flex: 2),
            TextField(
              key: const Key('nameField'),
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Nom d'utilisateur",
                border: const UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              key: const Key('emailField'),
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Adresse email',
                border: const UnderlineInputBorder(),
                errorText: !_validateEmail(_emailController.text) && _emailController.text.isNotEmpty
                    ? 'L\'adresse e-mail est invalide.'
                    : null,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              key: const Key('passwordField'),
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
            const SizedBox(height: 10.0),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 9.0),
            ElevatedButton(
              onPressed: () => _register(context),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                backgroundColor: Colors.teal,
                minimumSize: const Size(240, 48),
              ),
              child: const Text("S'inscrire", style: TextStyle(color: Colors.white)),
            ),
            const Spacer(flex: 28),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  // Action pour un problème
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white30,
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
