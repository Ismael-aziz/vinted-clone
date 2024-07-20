import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre email.';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Veuillez entrer une adresse email valide.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre mot de passe.';
    }
    return null;
  }

  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Échec de la connexion')),
        );
      }
    } catch (e) {
      print('Erreur lors de la connexion: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Échec de la connexion')),
      );
    }
  }

  void _showUnavailableMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40), // Ajoute de l'espace en haut
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
                    "Se connecter",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 2),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Adresse email',
                  border: OutlineInputBorder(),
                ),
                validator: _validateEmail,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: 'Mot de passe',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final String email = _emailController.text.trim();
                    final String password = _passwordController.text;
                    loginUser(email, password);
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  backgroundColor: Color(0xFF006E78),
                  minimumSize: const Size(double.infinity, 48), // Largeur infinie et hauteur de 48
                ),
                child: const Text('Se connecter', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    _showUnavailableMessage(context, 'Fonctionnalité de réinitialisation de mot de passe en cours de développement.');
                  },
                  child: const Text('Mot de passe oublié ?', style: TextStyle(color: Color(0xFF006E78))),
                ),
              ),
              const Spacer(flex: 30),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    _showUnavailableMessage(context, 'Fonctionnalité de signalement de problème en cours de développement.');
                  },
                  child: const Text('Un problème ?', style: TextStyle(color: Color(0xFF006E78))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
