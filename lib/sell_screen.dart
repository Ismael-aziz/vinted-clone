import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SellScreen extends StatefulWidget {
  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 16.0),
          Center(
            child: ElevatedButton(
              onPressed: _pickImage,
              child: Text('+ Ajouter photos',style: TextStyle(color: Colors.white),),
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
            decoration: InputDecoration(
              labelText: 'Titre',
              hintText: 'ex : Chemise Sézane verte',
            ),
          ),
          Divider(),
          TextField(
            decoration: InputDecoration(
              labelText: 'Décris ton article',
              hintText: 'ex : porté quelques fois, taille correctement',
            ),
            maxLines: 3,
          ),
          Divider(),
          ListTile(
            title: Text('Catégorie'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Action pour sélectionner la catégorie
            },
          ),
          Divider(),
          ListTile(
            title: Text('Marque'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Action pour sélectionner la marque
            },
          ),
          Divider(),
          ListTile(
            title: Text('État'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Action pour sélectionner l'état
            },
          ),
          Divider(),
          ListTile(
            title: Text('Prix'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Action pour sélectionner le prix
            },
          ),
          Divider(),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Action pour ajouter l'article
            },
            child: Text('Ajouter',style: TextStyle(color: Colors.white)),
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.teal,
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
