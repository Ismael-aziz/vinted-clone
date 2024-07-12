import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>(); // Clé pour le formulaire

  String? _validateEmail(String? value) {
    // Vérification de la validité de l'email
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre email.';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Veuillez entrer une adresse email valide.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    // Vérification de la validité du mot de passe
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre mot de passe.';
    }
    return null;
  }

  Future<void> loginUser(String email, String password) async {
    final String apiUrl = "http://127.0.0.1:8000/api/login/";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      if (responseJson['success']) {
        // Naviguer vers la page d'accueil après une connexion réussie
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de la connexion')),
        );
      }
    } else {
      throw Exception('Failed to login');
    }
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacer(flex: 2),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Identifiant ou adresse email',
                  border: OutlineInputBorder(),
                ),
                validator: _validateEmail,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: 'Mot de passe',
                  border: OutlineInputBorder(),
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
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final String email = emailController.text;
                    final String password = passwordController.text;
                    loginUser(email, password);
                  }
                },
                child: Text('Se connecter', style: TextStyle(color: Colors.white)),
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
                  child: Text('Mot de passe oublié ?', style: TextStyle(color: Colors.teal)),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
