import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/instance/instance.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({super.key});

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(credential.currentUser!.uid)
              .collection("completed")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                 int colorIndex = index % Customcolors.length;
                DocumentSnapshot abc = snapshot.data!.docs[index];
                return Container(
                    height: 80,
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Customcolors[colorIndex],
                      border: Border.all(
                        color: Customcolors[colorIndex],
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 300,
                    child: Container(
                      padding:const  EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(abc["task"]),
                          Text("Completed Date:  ${abc["completeddate"]}")
                        ],
                      ),
                    ));
              },
            );
          }),
    );
  }
}
