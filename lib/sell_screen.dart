import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SellScreen extends StatefulWidget {
  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  File? _image;
  final picker = ImagePicker();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _brandController = TextEditingController();
  final _sizeController = TextEditingController();
  final List<String> _categories = ['Hommes', 'Femmes', 'Enfants', 'Vêtements', 'Chaussures', 'Accessoires', 'Maison', 'Divertissement', 'Animaux'];
  final List<String> _conditions = ['Neuf', 'Très bon état', 'Bon état', 'État correct'];
  List<String> _selectedCategories = [];
  List<String> _selectedConditions = [];
  final _priceController = TextEditingController();
  String? _currentUserName;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        _currentUserName = userData['name'];
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  void _toggleCondition(String condition) {
    setState(() {
      if (_selectedConditions.contains(condition)) {
        _selectedConditions.remove(condition);
      } else {
        _selectedConditions.add(condition);
      }
    });
  }

  void _addArticle() async {
    if (_currentUserName == null) return;

    final newArticle = {
      'title': _titleController.text,
      'size': _sizeController.text,
      'oldPrice': 0, // Initialisation à 0 car pas de champ pour oldPrice dans le formulaire
      'newPrice': int.tryParse(_priceController.text) ?? 0, // Conversion en int
      'likes': 0,
      'seller': _currentUserName,
      'rating': 0,
      'solde': 0,
      'reviews': 0,
      'photos': _image != null ? [_image!.path] : ['introuvable'],
      'description': _descriptionController.text,
      'category': _selectedCategories.join(', '),
      'brand': _brandController.text,
      'condition': _selectedConditions.join(', '),
    };

    // Ajouter l'article à la base de données
    await FirebaseFirestore.instance.collection('articles').add(newArticle);

    // Navigate to the /home route after adding the article
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Vends ton article',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Center(
            child: Text(
              'Jusqu\'à 20 photos. Voir astuces',
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 16.0),
          Center(
            child: ElevatedButton(
              onPressed: _pickImage,
              child: Text('+ Ajouter photos', style: TextStyle(color: Colors.black)),
            ),
          ),
          if (_image != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Image.file(
                _image!,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          Divider(),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Titre',
              hintText: 'ex : Chemise Sézane verte',
            ),
          ),
          Divider(),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Décris ton article',
              hintText: 'ex : porté quelques fois, taille correctement',
            ),
            maxLines: 3,
          ),
          Divider(),
          ListTile(
            title: Text('Catégorie'),
            subtitle: Text(_selectedCategories.isEmpty ? 'Sélectionnez une catégorie' : _selectedCategories.join(', ')),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return MultiSelectDialog(
                    items: _categories,
                    initialSelectedItems: _selectedCategories,
                    onConfirm: (selectedItems) {
                      setState(() {
                        _selectedCategories = selectedItems;
                      });
                    },
                    mustSelectOne: true, // Obliger à choisir au moins une catégorie principale
                    allowedMultiple: true, // Autoriser la sélection multiple
                  );
                },
              );
            },
          ),
          Divider(),
          TextField(
            controller: _brandController,
            decoration: InputDecoration(
              labelText: 'Marque',
              hintText: 'ex : Nike',
            ),
          ),
          Divider(),
          ListTile(
            title: Text('État'),
            subtitle: Text(_selectedConditions.isEmpty ? 'Sélectionnez un état' : _selectedConditions.join(', ')),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return MultiSelectDialog(
                    items: _conditions,
                    initialSelectedItems: _selectedConditions,
                    onConfirm: (selectedItems) {
                      setState(() {
                        _selectedConditions = selectedItems;
                      });
                    },
                  );
                },
              );
            },
          ),
          Divider(),
          TextField(
            controller: _sizeController,
            decoration: InputDecoration(
              labelText: 'Taille',
            ),
          ),
          Divider(),
          TextField(
            controller: _priceController,
            decoration: InputDecoration(
              labelText: 'Prix',
            ),
            keyboardType: TextInputType.number,
          ),
          Divider(),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Vérifier que tous les champs sont remplis
              if (_image == null ||
                  _titleController.text.isEmpty ||
                  _descriptionController.text.isEmpty ||
                  _selectedCategories.isEmpty ||
                  _brandController.text.isEmpty ||
                  _selectedConditions.isEmpty ||
                  _sizeController.text.isEmpty ||
                  _priceController.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Champs requis'),
                    content: Text('Veuillez remplir tous les champs avant d\'ajouter l\'article.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              } else {
                _addArticle();
              }
            },
            child: Text('Ajouter', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF006E78),
              textStyle: TextStyle(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Un vendeur professionnel se faisant passer pour un consommateur ou un non-professionnel sur Vinted encourt des sanctions',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String> initialSelectedItems;
  final void Function(List<String>) onConfirm;
  final bool mustSelectOne; // Nouvelle propriété pour forcer la sélection d'au moins un élément
  final bool allowedMultiple; // Nouvelle propriété pour autoriser la sélection multiple

  MultiSelectDialog({
    required this.items,
    required this.initialSelectedItems,
    required this.onConfirm,
    this.mustSelectOne = false,
    this.allowedMultiple = true,
  });

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  late List<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.initialSelectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sélectionner les éléments'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            return CheckboxListTile(
              value: _selectedItems.contains(item),
              title: Text(item),
              onChanged: widget.allowedMultiple
                  ? (isChecked) {
                setState(() {
                  if (isChecked!) {
                    _selectedItems.add(item);
                  } else {
                    _selectedItems.remove(item);
                  }
                });
              }
                  : null, // Désactiver la sélection si allowedMultiple est faux
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () {
            if (widget.mustSelectOne && _selectedItems.isEmpty) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Sélection requise'),
                  content: Text('Veuillez sélectionner au moins une catégorie.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            } else {
              widget.onConfirm(_selectedItems);
              Navigator.pop(context);
            }
          },
          child: Text('Confirmer'),
        ),
      ],
    );
  }
}
