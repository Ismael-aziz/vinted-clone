import 'package:flutter/material.dart';
import 'categories/categories_screen_femmes.dart'; // Import the CategoriesScreen
import 'categories/categories_screen_hommes.dart'; // Import the CategoriesScreenHommes

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextField(
          decoration: InputDecoration(
            hintText: 'Rechercher un article ou un membre',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.black),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.woman, color: Color(0xFF006E78)),
            title: Text('Femmes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoriesScreenFemmes()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.man, color: Color(0xFF006E78)),
            title: const Text('Hommes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoriesScreenHommes()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.child_care, color: Color(0xFF006E78)),
            title: const Text('Enfants'),
            onTap: () {
              // Action lors du tap sur Enfants
            },
          ),
          ListTile(
            leading: Icon(Icons.home, color: Color(0xFF006E78)),
            title: const Text('Maison'),
            onTap: () {
              // Action lors du tap sur Maison
            },
          ),
          ListTile(
            leading: Icon(Icons.star, color: Color(0xFF006E78)),
            title: Text('Divertissement'),
            onTap: () {
              // Action lors du tap sur Divertissement
            },
          ),
          ListTile(
            leading: Icon(Icons.pets, color: Color(0xFF006E78)),
            title: Text('Animaux'),
            onTap: () {
              // Action lors du tap sur Animaux
            },
          ),
        ],
      ),
    );
  }
}
