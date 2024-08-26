import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todoapp/Screens/events/month.dart';
import 'package:todoapp/Screens/events/week.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/instance/instance.dart';
import 'package:todoapp/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DayScreen extends StatefulWidget {
  const DayScreen({Key? key});

  @override
  State<DayScreen> createState() => _DayScreenState();
}

int current = 0;

List<String> items = ["Day", ""];
List<IconData> icons = [Icons.home, Icons.explore];

final List<Widget> screens = [
  DayScreen(),
  WeekScreen(),
  MonthScreen(),
];

class _DayScreenState extends State<DayScreen> {
  TextEditingController eventdatecontroller = TextEditingController();
  TextEditingController eventtimecontroller = TextEditingController();
  TextEditingController eventnamecontroller = TextEditingController();

  addevent() async {
    CollectionReference firestore = FirebaseFirestore.instance.collection("users");
    firestore.doc(credential.currentUser!.uid).collection("events").doc().set({
      "eventname": eventnamecontroller.text.toString().trim(),
      "time": eventtimecontroller.text.toString().trim(),
      "date": eventdatecontroller.text.toString().trim()
    });
    Fluttertoast.showToast(
        msg: "Event Created",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 58, 56, 56),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        eventdatecontroller.text = formattedDate;
      });
    }
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        eventtimecontroller.text = selectedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: TableCalendar(
              calendarStyle: const CalendarStyle(),
              rowHeight: 43,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 10, 16),
              onDaySelected: _onDaySelected,
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(credential.currentUser!.uid)
                    .collection("events")
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
                      return Visibility(
                        visible: abc["date"] == today.toString().split(" ")[0],
                        child: Container(
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
                            title: Text(abc["eventname"]),
                            subtitle: Text(abc["time"]),
                            children: [
                              // Additional event details or actions can be added here
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
          )
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
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                  ),
                  Container(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      controller: eventnamecontroller,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: AppColors.themecolor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.themecolor),
                        ),
                        labelText: 'Add Event',
                      ),
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 15,
                          color: AppColors.themecolor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lightthemecolor),
                        ),
                        labelText: 'Event Description',
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
                        GestureDetector(
                          onTap: () {
                            selectTime(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 30),
                            child: Icon(
                              Icons.watch,
                              color: AppColors.themecolor,
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
                        addevent();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
