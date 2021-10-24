import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_ally_demo/app/core/p.dart';
import 'package:first_ally_demo/app/data/models/bank_account.dart';
import 'package:first_ally_demo/app/core/utils/firebase_response.dart';
import 'package:first_ally_demo/app/data/models/transaction_history.dart';
import 'package:first_ally_demo/app/data/models/user.dart';

import '_auth.dart';

class DatabaseService {

  static final FirebaseFirestore _store = FirebaseFirestore.instance;

  static Future<NetworkResponse<bool>> storeUser(User u) async {
    try {
      await _store.collection("users").doc(u.id).set(u.toJson());
      return NetworkResponse(true);
    } catch (e) {
      P.auth.loading.value = false;
      return NetworkResponse(null, error: e.toString());
    }
  }

  static Future<NetworkResponse<bool>> addBank(BankAccount u) async {
    try {
      DocumentReference ref = _store.collection("bankAccounts").doc(AuthService.user!.uid).collection("accounts").doc();
      u.id = ref.id;
      await ref.set(u.toJson());
      return NetworkResponse(true);
    } catch (e) {
      P.auth.loading.value = false;
      return NetworkResponse(null, error: e.toString());
    }
  }

  static Future<NetworkResponse<bool>> removeBank(BankAccount u) async {
    try {
      await _store.collection("bankAccounts").doc(AuthService.user!.uid).collection("accounts").doc(u.id).delete();
      return NetworkResponse(true);
    } catch (e) {
      P.auth.loading.value = false;
      return NetworkResponse(null, error: e.toString());
    }
  }

  static Future<NetworkResponse<bool>> addTransaction(TransactionHistory transactionHistory) async {
    try {
      DocumentReference ref = _store.collection("users").doc(AuthService.user!.uid).collection("transactions").doc();
      transactionHistory.id = ref.id;
      await ref.set(transactionHistory.toJson());
      return NetworkResponse(true);
    } catch (e) {
      P.auth.loading.value = false;
      return NetworkResponse(null, error: e.toString());
    }
  }

  static Stream<List<BankAccount>> getAccountsStream() {
    return _store.collection("bankAccounts").doc(AuthService.user!.uid).collection("accounts").snapshots().map((event) {
      List<BankAccount> retVal = [];
      event.docs.forEach((element) {
        retVal.add(BankAccount.fromJson(element.data()));
      });
      return retVal;
    });
  }

  static Stream<List<TransactionHistory>> getTransactionStream() {
    return _store.collection("users").doc(AuthService.user!.uid).collection("transactions").snapshots().map((event) {
      List<TransactionHistory> retVal = [];
      event.docs.forEach((element) {
        retVal.add(TransactionHistory.fromJson(element.data()));
      });
      return retVal;
    });
  }

  static Future<NetworkResponse<List<BankAccount>>> getBankAccounts() async {
    try {
      QuerySnapshot r = await _store.collection("bankAccounts").doc(AuthService.user!.uid).collection("accounts").get();
      List<BankAccount> accounts =
      r.docs.map((doc) => BankAccount.fromJson(doc.data() as Map<String, dynamic>)).toList();
      return NetworkResponse(accounts);
    } catch (e) {
      return NetworkResponse(null, error: e.toString());
    }
  }


  static Future<NetworkResponse<bool>> updateUser(User u) async {
    try {
      await _store.collection("users").doc(u.id).update(u.toJson());
      return NetworkResponse(true);
    } catch (e) {
      return NetworkResponse(null, error: e.toString());
    }
  }

  static Future<NetworkResponse<bool>> updateTransaction(TransactionHistory transactionHistory) async {
    try {
      await _store.collection("users").doc(AuthService.user!.uid).collection("transactions").doc(transactionHistory.id).update(transactionHistory.toJson());
      return NetworkResponse(true);
    } catch (e) {
      P.auth.loading.value = false;
      return NetworkResponse(null, error: e.toString());
    }
  }

  static Future<NetworkResponse<User>> getUser(String id) async {
    try {
      DocumentSnapshot r = await _store.collection("users").doc(id).get();
      print("Heieijehe ${r.data()}");
      return NetworkResponse(User.fromJson(r.data() as Map<String, dynamic>));
    } catch (e) {
      return NetworkResponse(null, error: e.toString());
    }
  }


}


