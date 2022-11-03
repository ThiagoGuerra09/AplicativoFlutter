import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/item.dart';
import 'pages/home_page.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
  runApp(const MyApp());
}

final plugins = initializePlugins(
  contentsSidePanel: true,
  knobsSidePanel: true,
  initialDeviceFrameData: DeviceFrameData(
    isFrameVisible: true,
    device: Devices.android.bigPhone,
  ),
);

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Todo app',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.brown),
//       home: HomePage(),
//     );
//   }
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => Storybook(
        stories: [
          Story(
            name: 'Widgets/Aplicativo',
            description: 'Checkbox list',
            builder: (context) => MaterialApp(
                title: 'Todo app',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(primarySwatch: Colors.brown),
                home: HomePage()),
          ),
        ],
      );
}
