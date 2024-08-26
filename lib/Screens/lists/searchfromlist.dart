import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Screens/lists/showlistitems.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/images/images.dart';
import 'package:todoapp/instance/instance.dart';
import 'package:todoapp/widgets/bottombar.dart';

class SearchFromList extends StatefulWidget {
  const SearchFromList({Key? key});

  @override
  State<SearchFromList> createState() => _SearchFromListState();
}

class _SearchFromListState extends State<SearchFromList> {
  TextEditingController listSearchController = TextEditingController();
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
                  controller: listSearchController,
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
                    hintText: "Search Lists",
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
                  .collection("lists")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    int imageIndex = index % images.length;
                    DocumentSnapshot abc = snapshot.data!.docs[index];

                    // Filter based on the search query
                    if (search.isEmpty ||
                        abc["title"]
                            .toLowerCase()
                            .contains(search.toLowerCase())) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowListItems(
                                      docid: abc.id,
                                      title: abc["title"],
                                    )),
                          );
                        },
                        child: Stack(
                          children: [
                            Image.asset(images[imageIndex]),
                            Positioned(
                                left: 30,
                                top: 70,
                                child: Text(
                                  abc["title"],
                                  style: TextStyle(fontSize: 20),
                                ))
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink(); // Hide if not a match
                    }
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
