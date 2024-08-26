import 'package:flutter/material.dart';
import 'package:todoapp/Screens/events/day.dart';
import 'package:todoapp/Screens/lists/listhomescreen.dart';
import 'package:todoapp/Screens/tasks/taskhomescreen.dart';
import 'package:todoapp/Screens/lists/ListScreen.dart';
import 'package:todoapp/Screens/notes/noteshomeScreen.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/widgets/custom_drawer.dart';
import 'package:todoapp/widgets/custom_text.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    // Text(
    //   'Index 0: Home',
    //   style: optionStyle,
    // ),
    ListHomeScreen(),
    // Text(
    //   'Index 1: Business',
    //   style: optionStyle,
    // ),
    NotesHomeScreen(),
    DayScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(left: 30),
          child: Row(
            children: [
              Image.asset(
                "assets/images/todoapplogo.png",
                height: 50,
                width: 50,
              ),
              CustomText(
                  text: "  ToDo",
                  textColor: AppColors.themecolor,
                  fontSize: 30,
                  fontWeight: FontWeight.w700)
            ],
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Event',
          ),
        ],
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.themecolor,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(color: AppColors.themecolor),
        onTap: _onItemTapped,
      ),
      drawer: CustomDrawer(),
    );
  }
}
