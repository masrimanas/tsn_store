import 'dart:developer';
import 'dart:math' show Random;

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;
import 'package:cloud_firestore/cloud_firestore.dart'
    show FirebaseFirestore, QuerySnapshot;
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException, UserCredential;
import 'package:tsn_store/data/models/product_model.dart';
import 'package:tsn_store/domain/entities/product.dart';

import '../../domain/entities/user.dart';
import '../models/user_model.dart';

String currentTime =
    DateFormat('HH:mm:ss').format(DateTime.now()).replaceAll(':', '.');
String numberRandom = Random().nextInt(100).toString();
String orderNo = 'Order-$numberRandom-$currentTime';

class FirebaseHelper {
  final UserModel _userModel;

  final FirebaseFirestore _db;
  final FirebaseAuth _auth;

  get auth => _auth;
  get db => _db;

  FirebaseHelper(
    this._userModel,
    this._db,
    this._auth,
  );

  Stream<QuerySnapshot<Map<String, dynamic>>> loadCart(User user) async* {
    yield* FirebaseFirestore.instance
        .collection('user')
        .doc(user.id)
        .collection('cart')
        .snapshots();
  }

  Future<void> addToCart(Product product, User user) async {
    try {
      log(orderNo);
      final db =
          _db.collection('user').doc(user.id).collection('cart').doc(orderNo);

      final data = ProductModel().toFireStore(product);
      db.set(data);
    } on Exception {
      rethrow;
    }
  }

  Future<List<ProductModel>> getProducts() async {
    try {
      final snapshot = await _db.collection("products").get();
      return snapshot.docs
          .map((data) => ProductModel.fromFireStore(data))
          .toList();
    } on Exception {
      rethrow;
    }
  }

  Stream<User> getUserState() {
    try {
      return _auth.authStateChanges().map((firebaseUser) {
        final user = firebaseUser == null
            ? User(id: '', email: '', name: '')
            : _userModel.fromAuth(firebaseUser);
        return user;
      });
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<UserCredential?> signUpUser(UserModel user) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: user.email!, password: user.password!);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<UserCredential?> logInUser(UserModel user) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  // Future<void> verifyEmail() async {
  //   User? user = _auth.currentUser;
  //   if (user != null && !user.emailVerified) {
  //     return await user.sendEmailVerification();
  //   }
  // }

  Future<void> logOutUser() async {
    return await _auth.signOut();
  }
}
