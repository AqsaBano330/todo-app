import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/instance/instance.dart';

class AddItemonList extends StatefulWidget {
  const AddItemonList({super.key});

  @override
  State<AddItemonList> createState() => _AddItemonListState();
}

class _AddItemonListState extends State<AddItemonList> {
  List<TextEditingController> additemControllers = [];
  bool isChecked = true;
  TextEditingController listitemtitlecontroller = TextEditingController();
  int itemCount = 4;



getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        File convertedimage = File(pickedFile.path);
        fileName = pickedFile.name;
        profilepic = convertedimage;
      });
      await uploadImageToFirebase(profilepic!);
    }
  }

  getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        File convertedimage = File(pickedFile.path);
        fileName = pickedFile.name;
        profilepic = convertedimage;
      });
      await uploadImageToFirebase(profilepic!);
    }
  }





  Future<void> addItemToList() async {
    // Create a reference to the user's document
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection("users")
        .doc(credential.currentUser!.uid);

    // Create a new list document
    DocumentReference listDocRef = await userDocRef.collection("lists").add({
      "title": listitemtitlecontroller.text.toString().trim(),
      "date": DateTime.now().toString(),
      
    });

    // Create subcollection items for the list
    for (TextEditingController controller in additemControllers) {
      String item = controller.text.toString().trim();
      if (item.isNotEmpty) {
        await listDocRef.collection("listitems").add({"itemname": item,"isCompleted":false});
      }
    }

    // Clear the text field and list items
    listitemtitlecontroller.clear();
    additemControllers.forEach((controller) => controller.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              left: 100,
            ),
            child: TextField(
              controller: listitemtitlecontroller,
              decoration: const InputDecoration(
                hintText: "Add Title",
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 23,
                color: Colors.red, // Text color
                fontWeight: FontWeight.bold, // Bold text
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                TextEditingController additemController =
                    additemControllers.length > index
                        ? additemControllers[index]
                        : TextEditingController();
                if (additemControllers.length <= index) {
                  additemControllers.add(additemController);
                }

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
                        title: TextField(
                          controller: additemController,
                          decoration: const InputDecoration(
                            hintText: "Add Item",
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            padding: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            padding: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            padding: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            padding: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            padding: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            padding: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            padding: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            padding: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            padding: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            padding: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            padding: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                        Container(
                            padding: EdgeInsets.only(left: 8),
                            color: AppColors.themecolor,
                            height: 1,
                            width: 10),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
          Row(
            children: [
              Container(
                height: 40,
                //width: 40,
                margin: const EdgeInsets.only(left: 20, bottom: 20, top: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.themecolor),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.themecolor,
                    backgroundColor: Colors.white,
                    //minimumSize: const Size(40, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: Text(
                    "+",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    setState(() {
                      itemCount++;
                    });
                  },
                ),
              ),
              Container(
                height: 40,
                width: 150,
                margin: const EdgeInsets.only(
                    left: 100, right: 20, bottom: 20, top: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.themecolor),
                  borderRadius: BorderRadius.circular(25),
                ),
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
                    addItemToList();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
