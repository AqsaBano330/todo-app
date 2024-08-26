import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/instance/instance.dart';
import 'package:todoapp/widgets/bottombar.dart';

class SearchfromTask extends StatefulWidget {
  const SearchfromTask({super.key});

  @override
  State<SearchfromTask> createState() => _SearchfromTaskState();
}

class _SearchfromTaskState extends State<SearchfromTask> {
  TextEditingController tasksearchcontroller = TextEditingController();

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
  String search = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50, left: 12),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomBottomBar(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50, left: 7),
                height: 45,
                width: 260,
                child: TextField(
                  onChanged: (String value) {
                    // Update the search variable when text changes
                    setState(() {
                      search = value;
                    });
                  },
                  controller: tasksearchcontroller,
                  cursorHeight: 20,
                  obscureText: false,
                  cursorColor: AppColors.themecolor,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    hintText: "Search Tasks",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      borderSide: BorderSide(
                        color: AppColors.themecolor,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder(
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
                  return const Text("Loading");
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    int colorIndex = index % Customcolors.length;
                    DocumentSnapshot abc = snapshot.data!.docs[index];
                    late String position = abc["task"];

                    // Filter tasks based on the search query
                    if (search.isEmpty ||
                        position.toLowerCase().contains(search.toLowerCase())) {
                      return Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          title: Text(abc["task"]),
                          subtitle: Text(abc["date"]),
                          children: <Widget>[
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (abc["isFav"] == false) {
                                        addtofavtask1(
                                            abc["task"], abc["date"], abc.id);
                                      } else {
                                        addtofavtask2(abc["task"], abc.id);
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
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      addtocomplete(abc.id, abc["task"]);
                                    },
                                    icon: const Icon(
                                      Icons.check,
                                      color: Colors.black,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      edittasktoui(abc.id);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                AppColors.peachcolor,
                                            title:
                                                const Text("Task Description"),
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
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.notes,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox
                          .shrink(); // If task doesn't match the search query, return an empty SizedBox
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
