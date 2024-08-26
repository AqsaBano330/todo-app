import 'package:flutter/material.dart';
import 'package:todoapp/Screens/login_screen.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/instance/instance.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Signout() async {
    await credential.signOut();
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      Image.asset("assets/images/drawerimage.jpg"),
      ListTile(
        title: Container(
            padding: EdgeInsets.only(left: 30), child: Text("My Profile")),
      ),
      Container(
        color: AppColors.themecolor,
        height: 1,
        width: 250,
      ),
      ListTile(
        title: Container(
            padding: EdgeInsets.only(left: 30), child: Text("Change Theme")),
      ),
      Container(
        color: AppColors.themecolor,
        height: 1,
        width: 250,
      ),
      ListTile(
        title: Container(
            padding: EdgeInsets.only(left: 30), child: Text("FAQ")),
      ),
      Container(
        color: AppColors.themecolor,
        height: 1,
        width: 250,
      ),
      ListTile(title: Container(
            padding: EdgeInsets.only(left: 30), child: Text("About us")),),
      Container(
        color: AppColors.themecolor,
        height: 1,
        width: 250,
      ),
      
      
      ListTile(),
      Container(
        width: 250,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              AppColors.themecolor,
              AppColors.themecolor,
              AppColors.lightthemecolor
            ])),
        child: ElevatedButton(
          onPressed: () {
            Signout();
            ;
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent),
          child: Row(
            children: [
              Text(
                "          Logout          ",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              Icon(
                Icons.logout,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    ]));
  }
}
