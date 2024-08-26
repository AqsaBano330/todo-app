import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final credential = FirebaseAuth.instance;
DocumentReference firestore = FirebaseFirestore.instance.collection("users").doc(
  credential.currentUser!.uid
);
