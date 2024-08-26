import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/Screens/lists/ListScreen.dart';
import 'package:todoapp/Screens/lists/additemsonlist.dart';
import 'package:todoapp/Screens/lists/favorite_list.dart';
import 'package:todoapp/Screens/lists/searchfromlist.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/instance/instance.dart';
import 'package:todoapp/widgets/custom_drawer.dart';
import 'package:todoapp/widgets/custom_text.dart';

class ListHomeScreen extends StatefulWidget {
  const ListHomeScreen({super.key});

  @override
  State<ListHomeScreen> createState() => _ListHomeScreenState();
}

class _ListHomeScreenState extends State<ListHomeScreen> {
  TextEditingController listtitlecontroller = TextEditingController();
  TextEditingController taskdescriptioncontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();

  bool isFave = false;
  addlist() async {
    CollectionReference firestore =
        await FirebaseFirestore.instance.collection("users");
    firestore
        .doc(credential.currentUser!.uid)
        .collection("list")
        .doc()
        .collection("listitems")
        .doc()
        .set({
      "list": listtitlecontroller.text.toString().trim(),
      "taskdescription": taskdescriptioncontroller.text.toString().trim(),
      "isFav": isFave,
      "date": datecontroller.text.toString().trim()
    });
    Fluttertoast.showToast(
        msg: "Task Created",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 58, 56, 56),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  Future<void> _selectDate(BuildContext context) async {
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

  showBottomsheet() {}

  int current = 0;
  PageController _pageController = PageController();

  List<String> items = ["All Lists", "Favorite List"];

  String hi = "ghghghjjh";
  final List<Widget> screens = [
    const ListScreen(),
    const FavoriteList(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
              height: 45,
              width: 600,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchFromList()),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.search),
                      Text(
                        "   Search List",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ))
              //
              //
              // TextField(
              //   onChanged: (String? value) {
              //     print(value);
              //     setState(() {
              //       search = value.toString();
              //     });
              //   },
              //   controller: searchtaskcontroller,
              //   cursorHeight: 20,
              //   obscureText: false,
              //   cursorColor: AppColors.themecolor,
              //   decoration: InputDecoration(
              //     suffixIcon: Icon(Icons.search),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(30)),
              //     ),
              //     labelStyle: TextStyle(
              //       color: Colors.grey,
              //       fontSize: 15,
              //       fontWeight: FontWeight.normal,
              //     ),
              //     hintText: "Search Tasks",
              //     hintStyle: TextStyle(
              //       color: Colors.grey,
              //       fontSize: 15,
              //       fontWeight: FontWeight.normal,
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(20)),
              //       borderSide: BorderSide(
              //         color: AppColors.themecolor,
              //         width: 1.0,
              //       ),
              //     ),
              //   ),
              // ),
              ),
        ),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              child: SizedBox(
                width: double.infinity,
                height: 46,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          current = index;
                          _pageController.animateToPage(
                            current,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 0),
                        margin: const EdgeInsets.all(5),
                        width: 155,
                        height: 18,
                        decoration: BoxDecoration(
                          color: current == index
                              ? AppColors.themecolor
                              : Colors.white,
                          borderRadius: current == index
                              ? BorderRadius.circular(25)
                              : BorderRadius.circular(25),
                          border: current == index
                              ? Border.all(
                                  color: AppColors.themecolor,
                                  width: 1.5,
                                )
                              : Border.all(
                                  color: AppColors.themecolor,
                                  width: 1.5,
                                ),
                        ),
                        child: Center(
                          child: Text(
                            items[index],
                            style: TextStyle(
                              color: current == index
                                  ? Colors.white
                                  : AppColors.themecolor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: screens,
                onPageChanged: (index) {
                  setState(() {
                    current = index;
                  });
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.themecolor,
          child: const CustomText(
            text: "+",
            textColor: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddItemonList()),
            );
          },
        ));
  }
}
