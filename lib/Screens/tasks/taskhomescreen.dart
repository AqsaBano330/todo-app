import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Screens/tasks/Completed_task.dart';
import 'package:todoapp/Screens/tasks/CustomCalender.dart';
import 'package:todoapp/Screens/tasks/Favorite_task.dart';
import 'package:todoapp/Screens/tasks/searchfromtask.dart';
import 'package:todoapp/Screens/tasks/tasks_screen.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/instance/instance.dart';
import 'package:todoapp/widgets/custom_drawer.dart';
import 'package:todoapp/widgets/custom_text.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController taskcontroller = TextEditingController();
  TextEditingController taskdescriptioncontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();

  bool isFave = false;
  addtask() async {
    CollectionReference firestore =
        await FirebaseFirestore.instance.collection("users");
    firestore.doc(credential.currentUser!.uid).collection("tasks").doc().set({
      "task": taskcontroller.text.toString().trim(),
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

  List<String> items = ["All Task", "Favorites", "Completed", "Calendar"];

  String hi = "ghghghjjh";
  final List<Widget> screens = [
    const TaskScreen(),
    const FavoriteTask(),
    const CompletedTask(),
    const CustomCalendar(),
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
                          builder: (context) => const SearchfromTask()),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.search),
                      Text(
                        "   Search Task",
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
        // drawer: const CustomDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
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
                        width: 105,
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
            showModalBottomSheet<void>(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              context: context,
              builder: (BuildContext context) {
                return ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                    Container(height: 20),
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        controller: taskcontroller,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontSize: 15,
                            color: AppColors.themecolor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.themecolor),
                          ),
                          labelText: 'Add Task',
                        ),
                      ),
                    ),
                    Container(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextField(
                        controller: taskdescriptioncontroller,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontSize: 15,
                            color: AppColors.themecolor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.lightthemecolor),
                          ),
                          labelText: 'Task Description',
                        ),
                      ),
                    ),
                    Container(
                      height: 15,
                    ),
                    Container(height: 20),
                    Container(
                      child: Row(
                        children: [
                          Container(width: 40),
                          Container(
                            height: 32,
                            width: 32,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isFave = !isFave;
                                });
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: isFave == false
                                    ? AppColors.themecolor
                                    : Colors.red,
                                size: 24,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 30),
                              child: Icon(
                                Icons.calendar_month,
                                color: AppColors.themecolor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 70,
                      margin: const EdgeInsets.only(left: 150, right: 40),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.themecolor),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.themecolor,
                          backgroundColor: Colors.white,
                          minimumSize: const Size(150, 50),
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
                          addtask();

                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ));
  }
}
