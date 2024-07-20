import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({Key? key}) : super(key: key);

  @override
  _RechargeScreenState createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  final TextEditingController _amountController = TextEditingController();

  void _confirmRecharge() async {
    String amount = _amountController.text.trim();
    int rechargeAmount = int.tryParse(amount) ?? 0;

    if (rechargeAmount <= 0) {
      // Gestion d'une erreur si le montant est invalide
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(user!.uid);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(userRef);
        if (!snapshot.exists) {
          throw Exception('Utilisateur non trouvé.');
        }

        int currentBalance = snapshot.get('solde') ?? 0;
        int updatedBalance = currentBalance + rechargeAmount;

        transaction.update(userRef, {'solde': updatedBalance});
      });

      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print('Erreur lors de la recharge du solde: $e');
      // Gérer l'affichage d'une erreur à l'utilisateur si nécessaire
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recharge de solde'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Montant à recharger',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _confirmRecharge,
              child: Text('Confirmer'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
