import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Api {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  CollectionReference ref;
  Api();

  Future<void> signUp(String email, String passsword) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: passsword);
  }

  Future<bool> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    if (result != null) {
      return true;
    }
    return false;
  }

  Future<QuerySnapshot> getDataCollection(String path) {
    ref = _db.collection(path);
    return ref.getDocuments() ;
  }

  Stream<QuerySnapshot> streamDataCollection(String path) {
    ref = _db.collection(path);
    return ref.snapshots() ;
  }
  Future<DocumentSnapshot> getDocumentById(String path,String id) {
    ref = _db.collection(path);
    return ref.document(id).get();
  }

  Future<DocumentReference> addDocument(String path,Map data) {
    ref = _db.collection(path);
    return ref.add(data);
  }

}