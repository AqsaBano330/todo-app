import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Screens/pageview/pageview.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.themecolor,
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.themecolor),
        useMaterial3: true,
      ),
      home: CustomPageView(),
    );
  }
}


// import 'package:flutter/material.dart';

// /// Flutter code sample for [SliverAppBar].

// void main() {
//   runApp(const StretchableSliverAppBar());
// }

// class StretchableSliverAppBar extends StatefulWidget {
//   const StretchableSliverAppBar({super.key});

//   @override
//   State<StretchableSliverAppBar> createState() =>
//       _StretchableSliverAppBarState();
// }

// class _StretchableSliverAppBarState extends State<StretchableSliverAppBar> {
 
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       body: CustomScrollView(
//         physics: const BouncingScrollPhysics(),
//         slivers: <Widget>[
//           SliverAppBar(
//             stretch: _stretch,
//             onStretchTrigger: () async {
//               // Triggers when stretching
//             },
//             // [stretchTriggerOffset] describes the amount of overscroll that must occur
//             // to trigger [onStretchTrigger]
//             //
//             // Setting [stretchTriggerOffset] to a value of 300.0 will trigger
//             // [onStretchTrigger] when the user has overscrolled by 300.0 pixels.
//             stretchTriggerOffset: 300.0,
//             expandedHeight: 200.0,
//             flexibleSpace: const FlexibleSpaceBar(
//               title: Text('SliverAppBar'),
//               background: FlutterLogo(),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 return Container(
//                   color: index.isOdd ? Colors.white : Colors.black12,
//                   height: 100.0,
//                   child: Center(
//                     child: Text('$index', textScaleFactor: 5),
//                   ),
//                 );
//               },
//               childCount: 20,
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Padding(
//           padding: const EdgeInsets.all(8),
//           child: OverflowBar(
//             overflowAlignment: OverflowBarAlignment.center,
//             alignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   const Text('stretch'),
//                   Switch(
//                     onChanged: (bool val) {
//                       setState(() {
//                         _stretch = val;
//                       });
//                     },
//                     value: _stretch,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }

