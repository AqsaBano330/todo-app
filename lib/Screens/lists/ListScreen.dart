import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/Screens/lists/showlistitems.dart';

import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/instance/instance.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List images = [
    "assets/images/stickynotes1.png",
    "assets/images/stickynotes2.png",
    "assets/images/stickynotes3.png",
    "assets/images/stickynotes4.png",
    "assets/images/stickynotes5.png"
  ];
  addtofavtask1(String task, String date, String docid) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(credential.currentUser!.uid)
        .collection("tasks")
        .doc(docid)
        .update({"isFav": true});

    FirebaseFirestore.instance
        .collection("users")
        .doc(credential.currentUser!.uid)
        .collection("favtask")
        .doc(docid)
        .set({"task": task, "date": date});

    Fluttertoast.showToast(
        msg: "Task Added to Fav",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 58, 56, 56),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  addtofavtask2(String task, String docid) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(credential.currentUser!.uid)
        .collection("tasks")
        .doc(docid)
        .update({"isFav": false});

    FirebaseFirestore.instance
        .collection("users")
        .doc(credential.currentUser!.uid)
        .collection("favtask")
        .doc(docid)
        .delete();

    Fluttertoast.showToast(
        msg: "Task deleted to Fav",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 58, 56, 56),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  addtocomplete(String docid, String task) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    FirebaseFirestore.instance
        .collection("users")
        .doc(credential.currentUser!.uid)
        .collection("completed")
        .doc()
        .set({"task": task, "completeddate": formattedDate.toString()});

    FirebaseFirestore.instance
        .collection("users")
        .doc(credential.currentUser!.uid)
        .collection("tasks")
        .doc(docid)
        .delete();

    Fluttertoast.showToast(
        msg: "Task Completed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 58, 56, 56),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  deletetask(String docid) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(credential.currentUser!.uid)
        .collection("tasks")
        .doc(docid)
        .delete();

    Fluttertoast.showToast(
        msg: "Task Deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 58, 56, 56),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  edittasktofirebase(String docid, String editedtask) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(credential.currentUser!.uid)
        .collection("tasks")
        .doc(docid)
        .update({"task": editedtask});

    Fluttertoast.showToast(
        msg: "Task Edited",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 58, 56, 56),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  edittasktoui(String docid) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.peachcolor,
            title: const Text("Edit Task"),
            content: TextField(
              controller: taskeditcontroller,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    edittasktofirebase(
                        docid, taskeditcontroller.text.toString().trim());
                    Navigator.pop(context);
                    taskeditcontroller.clear();
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: AppColors.orangecolor),
                  ))
            ],
          );
        });
  }

  printCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    print(formattedDate);
  }

  TextEditingController taskeditcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(credential.currentUser!.uid)
              .collection("lists")
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
                int imageIndex = index % images.length;
                DocumentSnapshot abc = snapshot.data!.docs[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowListItems(
                                docid: abc.id,
                                title: abc["title"],
                              )),
                    );
                  },
                  child: Stack(
                    children: [
                      Image.asset(images[imageIndex]),
                      Positioned(
                          left: 30,
                          top: 70,
                          child: Text(
                            abc["title"],
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
                );

                // return Container(
                //   height: 200,
                //   width: 130,
                //   margin: const EdgeInsets.only(top: 15, left: 10, right: 20),
                //   decoration: BoxDecoration(
                //     color: Customcolors[colorIndex],
                //     border: Border.all(
                //       color: Customcolors[colorIndex],
                //       width: 2,
                //     ),
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   child: ListTile(
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => ShowListItems(
                //                   docid: abc.id,
                //                   title: abc["title"],
                //                 )),
                //       );
                //     },
                //     title: Column(
                //       children: [
                //         Container(
                //             padding: EdgeInsets.only(top: 10),
                //             child: Text(abc["title"])),
                //         Text(""),
                //         Text("1  -----------------"),
                //         Text("2  -----------------"),
                //         Text("3  -----------------"),
                //       ],
                //     ),
                //   ),
                // );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            );
          }),
    );
  }
}
