import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:learn_french/dictionary.dart';
import 'dart:io';

// Flashcard screen widget
class FlashCardScreen extends StatefulWidget {
  // categories of flashcards to display
  final String category;
  const FlashCardScreen({required this.category});

  @override
  State<FlashCardScreen> createState() =>
      _FlashCardScreenState(category: category);
}

// state class
class _FlashCardScreenState extends State<FlashCardScreen> {
  // categories of flashcards
  final String category;
  _FlashCardScreenState({required this.category});
  // current flashcard index
  var _currItem = 0;
  // list to store flashcards
  late List<Map<String, String>> jsonData;
  // key to control flip card
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  // styling the text
  TextStyle textStyle = TextStyle(
    color: Colors.red.shade900,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  @override
  void initState() async {
    super.initState();
    // load flashcard data based on category
    var dict = Dictionary();
    await dict.init();
    var dictData = dict.data;
    jsonData = (dictData[this.category] as List).cast<Map<String, String>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffA7D397),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Little Vocab Every Day"),
        elevation: 5,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Guess the meaning of this word ????",
              style: TextStyle(fontSize: 30, color: Colors.redAccent),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 25),
            SizedBox(
              width: 300,
              height: 300,

              // flip card
              child: FlipCard(
                key: cardKey,
                direction: FlipDirection.HORIZONTAL,
                front: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 7,
                  shadowColor: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        jsonData[_currItem]["word"] ?? "",
                        textAlign: TextAlign.center,
                        style: textStyle,
                      ),
                    ),
                  ),
                ),
                // back of the card
                back: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 7,
                  shadowColor: Colors.grey,
                  color: Colors.yellow.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        jsonData[_currItem]["result"] ?? "",
                        textAlign: TextAlign.center,
                        style: textStyle,
                      ),
                    ),
                  ),
                ),
                // end of back of card
              ),

              // end of flip card
            ),
            // add some spacing
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // move pointer to the next flashcard
                  _currItem = (_currItem + 1) % jsonData.length;
                  // flip card back to the front
                  cardKey.currentState?.toggleCard();
                });
              },
              // button to go to next flashcard
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
