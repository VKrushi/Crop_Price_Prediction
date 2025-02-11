import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExpenseBenefitProvider extends ChangeNotifier {
  final _firebaseFirestore = FirebaseFirestore.instance;
  int totalExpense = 0;
  int totalBenefit = 0;

  Future<void> addNewExpense({
    required String expenseType,
    required int amount,
    required BuildContext context,
  }) async {
    // String userId =
    //     Provider.of<AuthStateProvider>(context, listen: false).user!.phone;
    String userId = "7719039739";

    final collectionRef = _firebaseFirestore
        .collection('Users')
        .doc(userId)
        .collection('Expenses');

    final snapshot = await collectionRef
        .where('expenseType', isEqualTo: expenseType)
        .snapshots()
        .elementAt(0);

    if (snapshot.docs.isEmpty) {
      await collectionRef.add({
        'expenseType': expenseType,
        'amount': amount,
      });
    } else {
      String id = snapshot.docs.first.id;
      int prevAmount = snapshot.docs.first.get('amount') as int;
      await collectionRef.doc(id).update({'amount': prevAmount + amount});
    }
  }

  Future<void> addNewBenefit(
      {required String benefitType,
      required int amount,
      required BuildContext context}) async {
    // String userId =
    //     Provider.of<AuthStateProvider>(context, listen: false).user!.phone;
    String userId = "7719039739";

    final collectionRef = _firebaseFirestore
        .collection('Users')
        .doc(userId)
        .collection('Benefits');

    final snapshot = await collectionRef
        .where('benefitType', isEqualTo: benefitType)
        .snapshots()
        .elementAt(0);

    if (snapshot.docs.isEmpty) {
      await collectionRef.add({
        'benefitType': benefitType,
        'amount': amount,
      });
    } else {
      String id = snapshot.docs.first.id;
      int prevAmount = snapshot.docs.first.get('amount') as int;
      await collectionRef.doc(id).update({'amount': prevAmount + amount});
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getExpenses({
    required BuildContext context,
  }) {
    // String userId =
    //     Provider.of<AuthStateProvider>(context, listen: false).user!.phone;
    String userId = "7719039739";
    final collectionRef = _firebaseFirestore
        .collection('Users')
        .doc(userId)
        .collection('Expenses');
    return collectionRef.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBenefits({
    required BuildContext context,
  }) {
    // String userId =
    //     Provider.of<AuthStateProvider>(context, listen: false).user!.phone;
    String userId = "7719039739";
    final collectionRef = _firebaseFirestore
        .collection('Users')
        .doc(userId)
        .collection('Benefits');
    return collectionRef.snapshots();
  }

  int calculateProfit() {
    return totalBenefit - totalExpense;
  }

  Future<void> deleteExpense({
    required BuildContext context,
    required String expenseType,
  }) async {
    // String userId =
    //     Provider.of<AuthStateProvider>(context, listen: false).user!.phone;
    String userId = "7719039739";
    final collectionRef = _firebaseFirestore
        .collection('Users')
        .doc(userId)
        .collection('Expenses');

    final snapshots =
        collectionRef.where('expenseType', isEqualTo: expenseType).snapshots();

    final data = await snapshots.first;
    String docId = data.docs.first.id;

    await collectionRef.doc(docId).delete();
  }

  Future<void> deleteBenefit({
    required BuildContext context,
    required String benefitType,
  }) async {
    // String userId =
    //     Provider.of<AuthStateProvider>(context, listen: false).user!.phone;
    String userId = "7719039739";
    final collectionRef = _firebaseFirestore
        .collection('Users')
        .doc(userId)
        .collection('Benefits');

    final snapshots =
        collectionRef.where('benefitType', isEqualTo: benefitType).snapshots();

    final data = await snapshots.first;
    String docId = data.docs.first.id;

    await collectionRef.doc(docId).delete();
  }
}
