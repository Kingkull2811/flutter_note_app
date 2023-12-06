import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_app/network/provider/auth_provider.dart';

import '../repository/notes_repository.dart';

final notesRepository = Provider<NotesRepository>((ref) => NotesRepository(FirebaseFirestore.instance));

final firebaseProvider = StreamProvider<QuerySnapshot<Map<String, dynamic>>>((ref) => ref.watch(notesRepository).listNotes(ref.watch(authStateChangeProvider).value?.uid));

class FirebaseProvider {
  // final _fireStoreDatabase = FirebaseFirestore.instance;
  //
  // Stream<QuerySnapshot<Map<String, dynamic>>> listNotes(String uId) => _fireStoreDatabase.collection('users').doc(uId).collection('notes').snapshots();
}
