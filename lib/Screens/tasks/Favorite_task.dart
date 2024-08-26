import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/instance/instance.dart';

class FavoriteTask extends StatefulWidget {
  const FavoriteTask({super.key});

  @override
  State<FavoriteTask> createState() => _FavoriteTaskState();
}

class _FavoriteTaskState extends State<FavoriteTask> {
  TextEditingController taskeditcontroller = TextEditingController();

  

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
    
  }

  addtocomplete(String docid) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(credential.currentUser!.uid)
        .collection("tasks")
        .doc(docid)
        .update({"isFav": false});

    FirebaseFirestore.instance
        .collection("users")
        .doc(credential.currentUser!.uid)
        .collection("tasks")
        .doc(docid)
        .delete();
  }

  deletetask(String docid) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(credential.currentUser!.uid)
        .collection("tasks")
        .doc(docid)
        .delete();
  }

  edittasktofirebase(String docid, String editedtask) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(credential.currentUser!.uid)
        .collection("tasks")
        .doc(docid)
        .update({"task": editedtask});
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(credential.currentUser!.uid)
              .collection("tasks")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const  Text("Loading");
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                 int colorIndex = index % Customcolors.length;
                DocumentSnapshot abc = snapshot.data!.docs[index];
                return Visibility(
                  visible: abc["isFav"] == true,
                  child: Container(
                    margin:const  EdgeInsets.only(top: 10, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Customcolors[colorIndex],
                      border: Border.all(
                        color: Customcolors[colorIndex],
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 300,
                    child: ExpansionTile(
                      backgroundColor: Customcolors[colorIndex],
                      shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      title: Text(abc["task"]),
                      subtitle: Text(abc["date"]),
                      children: <Widget>[
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (abc["isFav"] == false) {
                                    addtofavtask1(
                                        abc["task"], abc["date"], abc.id);
                                
                                  } else {
                                    {
                                      addtofavtask2(abc["task"], abc.id);
                                      
                                    }
                                  }
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: abc["isFav"] == false
                                      ? Colors.black
                                      : Colors.red,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    deletetask(abc.id);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.black,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    edittasktoui(abc.id);
                                  },
                                  icon: const  Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                AppColors.peachcolor,
                                            title: const Text("Task Description"),
                                            content:
                                                Text(abc["taskdescription"]),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    taskeditcontroller.clear();
                                                  },
                                                  child: Text(
                                                    "Close",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .orangecolor),
                                                  ))
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.notes,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
    
  }
}
