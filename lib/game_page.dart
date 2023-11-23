import 'package:flutter/material.dart';
import 'colors.dart';
import 'figure_image.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: Text("Hangman"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                figureImage(true , "assets/hang.png"),
                figureImage(true , "assets/head.png"),
                figureImage(true , "assets/body.png"),
                figureImage(true , "assets/ra.png"),
                figureImage(true , "assets/la.png"),
                figureImage(true , "assets/rl.png"),
                figureImage(true , "assets/ll.png"),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
