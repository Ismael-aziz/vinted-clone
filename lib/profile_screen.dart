import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vinted/recharge_screen.dart';
import 'commande_screen.dart'; // Importation de la page de commande

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/acceuil');
    } catch (e) {
      print('Erreur lors de la déconnexion: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(user!.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('Utilisateur non trouvé'));
        }

        var userData = snapshot.data!;
        String name = userData.get('name') ?? 'Utilisateur';
        int solde = userData.get('solde') ?? 0;

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 1,
            title: const Text(
              'Profil',
              style: TextStyle(color: Colors.black),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () => _signOut(context),
              ),
            ],
          ),
          body: ListView(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/profile_picture.png'),
                  radius: 30,
                ),
                title: Text(name),
                subtitle: const Text('Voir mon profil'),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.help),
                title: Text('Ton guide Vinted'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.favorite_border),
                title: Text('Articles favoris'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Personnalisation'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet),
                title: const Text('Mon porte-monnaie'),
                trailing: Text('$solde FCFA', style: const TextStyle(color: Colors.grey)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RechargeScreen()),
                  );
                }, // Naviguer vers l'écran de recharge
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.shopping_basket),
                title: const Text('Mes ventes et achats'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CommandeScreen()),
                  );
                },
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.percent),
                title: Text('Réductions sur les lots'),
                trailing: Text('Désactivé', style: TextStyle(color: Colors.grey)),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Dons'),
                trailing: Text('Désactivé', style: TextStyle(color: Colors.grey)),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.beach_access),
                title: Text('Mode vacances'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Paramètres'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.lock),
                title: Text('Paramètres des cookies'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.info),
                title: Text('À propos de Vinted'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.article),
                title: Text('Informations légales'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Notre plateforme'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.help_outline),
                title: Text('Centre d\'aide'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.insert_emoticon),
                title: Text('Mes avis'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Politique de Confidentialité',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Conditions générales',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
