import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todoapp/Screens/login_screen.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/widgets/custom_button.dart';
import 'package:todoapp/widgets/custom_text.dart';

class CustomPageView extends StatelessWidget {
  CustomPageView({Key? key}) : super(key: key);

  final controller = PageController();

  final List<String> mainHeading = [
    "Task & List Management",
    "Event Scheduling",
    
  ];
  final List<String> subHeading = [
    "Effortlessly manage your tasks and create organized lists with our versatile to-do app. Stay on top of your commitments and take notes to boost productivity",
    "Plan and organize your events and appointments efficiently with our to-do app. Keep track of important dates and deadlines while managing tasks, lists, and notes in one place.",
    
  ];
  final image = [
    "assets/images/pageview1.png",
    "assets/images/pageview2.png",
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          color: AppColors.themecolor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                  colors: [ AppColors.lightthemecolor,AppColors.themecolor,AppColors.themecolor,]
                  )
                  ),
                  height: 350,
                  // color: AppColors.themecolor,
                ),
                Container(
                  height: 406,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(18),),
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(top: 60),
                            height: 300,
                            child: Image.asset(image[index],
                                width: 250, height: 250)),
                        Container(
                          padding: const EdgeInsets.only(
                              bottom: 0.0, right: 30, left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(top: 120),
                                  child: CustomText(
                                      text: mainHeading[index],
                                      textColor: AppColors.textthemecolor,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(height: 16.0),
                              CustomText(
                                  text: subHeading[index],
                                  textColor: AppColors.textthemecolor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400)
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: CustomButton(
                    onpressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    buttontext: "Get Started"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.only(bottom:20),
            child: SmoothPageIndicator(
              controller: controller,
              count: 2,
              axisDirection: Axis.horizontal,
              effect: ExpandingDotsEffect(
                spacing: 8.0,
                radius: 2,
                dotWidth: 8.0,
                dotHeight: 6.0,
                paintStyle: PaintingStyle.fill,
                strokeWidth: 1.5,
                dotColor: Colors.grey,
                activeDotColor: AppColors.themecolor,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
