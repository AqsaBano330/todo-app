import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/instance/instance.dart';

class ShowListItems extends StatefulWidget {
  const ShowListItems({super.key, required this.docid, required this.title});

  final String docid;
  final String title;

  @override
  State<ShowListItems> createState() => _ShowListItemsState();
}

class _ShowListItemsState extends State<ShowListItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 70),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(credential.currentUser!.uid)
                  .collection("lists")
                  .doc(widget.docid)
                  .collection("listitems")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot abc = snapshot.data!.docs[index];
                      bool isCompleted = abc["isCompleted"] ?? false;

                      return Column(
                        children: [
                          Container(
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, right: 10), // Reduce spacing here
                              leading: Text(
                                (index + 1).toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                              title: Text(abc["itemname"]),
                              trailing: Checkbox(
                                value: isCompleted,
                                onChanged: (bool? value) {
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(credential.currentUser!.uid)
                                      .collection("lists")
                                      .doc(widget.docid)
                                      .collection("listitems")
                                      .doc(abc.id)
                                      .update({"isCompleted": value});
                                },
                              ),
                            ),
                          ),
                          Row(
                            children: List.generate(
                              20,
                              (index) => Container(
                                padding: EdgeInsets.only(left: 8),
                                color: AppColors.themecolor,
                                height: 1,
                                width: 10,
                                margin: EdgeInsets.only(left: 8),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
