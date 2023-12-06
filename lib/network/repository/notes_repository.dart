import 'package:cloud_firestore/cloud_firestore.dart';

class NotesRepository{
  final FirebaseFirestore _firestore;

  const NotesRepository(this._firestore);

  Stream<QuerySnapshot<Map<String, dynamic>>> listNotes(String? uId) => _firestore.collection('users').doc(uId).collection('notes').snapshots();

}