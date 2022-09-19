import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  var lastPosition = 0.0;
  var random = new Random();
  late AnimationController animationController;

  double getRandomNumber() {
    lastPosition = random.nextDouble();
    return lastPosition;
  }

  @override
  void initState() {
    super.initState();
    spintheBottle();
  }

  spintheBottle() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Flip the Bottle",
          style: TextStyle(fontSize: 30, color: Colors.greenAccent),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "lib/assets/bg.png",
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Container(
              // ignore: sort_child_properties_last
              child: RotationTransition(
                  turns: Tween(begin: lastPosition, end: getRandomNumber())
                      .animate(CurvedAnimation(
                          parent: animationController, curve: Curves.linear)),
                  child: GestureDetector(
                      onTap: () {
                        if (animationController.isCompleted) {
                          setState(() {
                            spintheBottle();
                          });
                        }
                      },
                      child: Image.asset("lib/assets/3.png"))),
              height: 300,
              width: 300,
            ),
          )
        ],
      ),
    );
  }
}
