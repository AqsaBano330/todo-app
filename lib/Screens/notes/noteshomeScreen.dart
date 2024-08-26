import 'package:flutter/material.dart';
import 'package:todoapp/Screens/notes/createnotes.dart';
import 'package:todoapp/Screens/notes/favorites_notes.dart';
import 'package:todoapp/Screens/notes/notesScreen.dart';
import 'package:todoapp/Screens/notes/searchfromnotes.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/widgets/custom_text.dart';

class NotesHomeScreen extends StatefulWidget {
  const NotesHomeScreen({super.key});

  @override
  State<NotesHomeScreen> createState() => _NotesHomeScreenState();
}

class _NotesHomeScreenState extends State<NotesHomeScreen> {
  int current = 0;

  PageController _pageController = PageController();

  List<String> items = [
    "Notes",
    "Favorite Notes",
  ];
  List<IconData> icons = [
    Icons.home,
    Icons.explore,
  ];

  final List<Widget> screens = [
    NotesScreen(),
    FavoriteNotes(),
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
                          builder: (context) => const SerachFromNotes()),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.search),
                      Text(
                        "   Search Notes",
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
                        width: 158,
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
          onPressed: () { Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const CreateNotes()),
  );},
        ));
  }
}
