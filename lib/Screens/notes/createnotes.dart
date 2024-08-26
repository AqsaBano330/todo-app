import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/instance/instance.dart';

class CreateNotes extends StatefulWidget {
  const CreateNotes({super.key});

  @override
  State<CreateNotes> createState() => _CreateNotesState();
}

class _CreateNotesState extends State<CreateNotes> {
  Future<void> _selectDate(BuildContext context) async {}

  _selectdate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate);
      setState(() {
        datecontroller.text = formattedDate;
      });
    }
  }

  addnotes() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(credential.currentUser!.uid)
        .collection("notes")
        .doc()
        .set({
      "notestitle": notestitlecontroller.text.toString().trim(),
      "notes": notescontroller.text.toString().trim(),
      "date": datecontroller.text
    });
  }

  TextEditingController notestitlecontroller = TextEditingController();
  TextEditingController notescontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Image.asset(
            "assets/images/notes.png",
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        _selectdate();
                      },
                      child: Container(
                          padding: EdgeInsets.only(top: 60, left: 20),
                          child: Text(
                            "Date:  ",
                            style: TextStyle(fontSize: 17),
                          ))),
                  Container(
                      height: 60,
                      width: 150,
                      margin: EdgeInsets.only(
                        top: 70,
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.themecolor,
                        cursorHeight: 20,
                        obscureText: false,
                        readOnly: true,
                        controller: datecontroller,
                      )),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 80),
                child: TextField(
                  controller: notestitlecontroller,
                  decoration: const InputDecoration(
                    hintText: "Add Title ...",
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 23,
                    color: Colors.red, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 12, left: 20),
                child: TextField(
                  controller: notescontroller,
                  decoration: const InputDecoration(
                    hintText: "Write Something...",
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 15,
                    // Text color
                    //fontWeight: FontWeight.bold, // Bold text
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(top: 450, left: 170),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.themecolor,
                    backgroundColor: Colors.white,
                    minimumSize: const Size(150, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Text('     Create   '),
                      Icon(Icons.edit),
                    ],
                  ),
                  onPressed: () {
                    addnotes();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
