import 'package:flutter/material.dart';

class CategoriesScreenHommes extends StatelessWidget {
  const CategoriesScreenHommes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
            leading: Icon(Icons.grid_on, color: Colors.teal),
            title: Text('Tout'),
            onTap: () {
              // Action lors du tap sur Tout
            },
          ),
          ListTile(
            leading: Icon(Icons.male, color: Colors.teal),
            title: Text('Vêtements'),
            onTap: () {
              // Action lors du tap sur Vêtements
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_basket, color: Colors.teal),
            title: Text('Chaussures'),
            onTap: () {
              // Action lors du tap sur Chaussures
            },
          ),
          ListTile(
            leading: Icon(Icons.watch, color: Colors.teal),
            title: Text('Accessoires'),
            onTap: () {
              // Action lors du tap sur Accessoires
            },
          ),
          ListTile(
            leading: Icon(Icons.brush, color: Colors.teal),
            title: Text('Soins'),
            onTap: () {
              // Action lors du tap sur Soins
            },
          ),
        ],
      ),
    );
  }
}
