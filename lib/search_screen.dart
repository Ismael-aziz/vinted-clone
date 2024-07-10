import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            leading: Icon(Icons.woman, color: Colors.teal),
            title: Text('Femmes'),
            onTap: () {
              // Action lors du tap sur Femmes
            },
          ),
          ListTile(
            leading: Icon(Icons.man, color: Colors.teal),
            title: Text('Hommes'),
            onTap: () {
              // Action lors du tap sur Hommes
            },
          ),
          ListTile(
            leading: Icon(Icons.child_care, color: Colors.teal),
            title: Text('Enfants'),
            onTap: () {
              // Action lors du tap sur Enfants
            },
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.teal),
            title: Text('Maison'),
            onTap: () {
              // Action lors du tap sur Maison
            },
          ),
          ListTile(
            leading: Icon(Icons.star, color: Colors.teal),
            title: Text('Divertissement'),
            onTap: () {
              // Action lors du tap sur Divertissement
            },
          ),
          ListTile(
            leading: Icon(Icons.pets, color: Colors.teal),
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
