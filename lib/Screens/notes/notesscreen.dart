import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Screens/notes/shownotes.dart';
import 'package:todoapp/constants/images/images.dart';
import 'package:todoapp/instance/instance.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(credential.currentUser!.uid)
              .collection("notes")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            return GridView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                int imageIndex = index % notesimage.length;
                DocumentSnapshot abc = snapshot.data!.docs[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowNotes(
                                docid: abc.id,
                              )),
                    );
                  },
                  child: Stack(
                    children: [
                      Image.asset(notesimage[imageIndex]),
                      Positioned(
                          left: 60,
                          top: 70,
                          child: Text(
                            abc["notestitle"],
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            );
          }),
    );
  }
}
