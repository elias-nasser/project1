import 'dart:math';

import 'package:flutter/material.dart';
import 'colors.dart';
import 'figure_image.dart';
import 'game.dart';
import 'letter.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> words = ['elias','elena','flutter', 'hangman', 'dart', 'widget'];
  String currentWord = '';
  List<String> alphabets = [
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N",
    "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
  ];
  List<bool> correctGuesses = [];

  void startNewGame() {
    Game.tries = 0;
    int randomIndex = Random().nextInt(words.length);
    currentWord = words[randomIndex];
    correctGuesses = List.generate(currentWord.length, (index) => false);
    Game.selectedChar = [];
  }

  bool isGameWon() {
    return correctGuesses.every((element) => element);
  }

  bool isGameLost() {
    return Game.tries >= 6;
  }
  void onLetterPressed(String letter) {
    if (!isGameWon() && !isGameLost()) {
      if (!Game.selectedChar.contains(letter)) {
        setState(() {
          Game.selectedChar.add(letter);
          print(Game.selectedChar);

          bool isCorrectGuess = currentWord.split('').contains(letter.toLowerCase());

          if (isCorrectGuess) {
            // Correct guess
            for (int i = 0; i < currentWord.length; i++) {
              if (currentWord[i].toUpperCase() == letter.toUpperCase()) {
                if (!correctGuesses[i]) {
                  correctGuesses[i] = true;
                }
              }
            }
          } else {
            // Incorrect guess
            Game.tries++;
          }

          if (isGameWon()) {
            // Handle win condition
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('You Win!'),
                  content: Text('Congratulations! You guessed the word.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Clear the displayed word and start a new game
                        setState(() {
                          startNewGame();
                        });

                      },
                      child: Text('Play Again'),
                    ),

                  ],
                );
              },
            );
          } else if (isGameLost()) {
            // Handle lose condition
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('You Lose!'),
                  content: Text('Sorry! You couldn\'t guess the word. The word was: $currentWord'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Clear the displayed word
                        setState(() {
                          startNewGame();
                        });
                      },
                      child: Text('Try Again'),
                    ),
                  ],
                );
              },
            );
          }
        });
      }
    }
  }

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
                figureImage(Game.tries >= 0, "assets/hang.png"),
                figureImage(Game.tries >= 1, "assets/head.png"),
                figureImage(Game.tries >= 2, "assets/body.png"),
                figureImage(Game.tries >= 3, "assets/ra.png"),
                figureImage(Game.tries >= 4, "assets/la.png"),
                figureImage(Game.tries >= 5, "assets/rl.png"),
                figureImage(Game.tries >= 6, "assets/ll.png"),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: currentWord
                .split('')
                .map((e) => letter(e.toUpperCase(),
                !Game.selectedChar.contains(e.toUpperCase())))
                .toList(),
          ),
          SizedBox(
            width: double.infinity,
            height: 250.0,
            child: GridView.count(
              crossAxisCount: 7,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: EdgeInsets.all(8.0),
              children: alphabets.map((e) {
                return RawMaterialButton(
                  onPressed: () => onLetterPressed(e),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    e,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  fillColor: Game.selectedChar.contains(e)
                      ? Colors.black87
                      : AppColor.primaryColorDark,
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
