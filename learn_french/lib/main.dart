import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:learn_french/flashCard.dart';

// Main function to run the app
void main() {
  runApp(const MyApp());
}

// main app widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // hide debug banner
      debugShowCheckedModeBanner: false,
      title: 'French Learning App',
      //set app theme
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const MyHomePage(title: 'Stacy\'s French Learning App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        // Column to hold cards and Grid View
        child: Center(
          child: Column (
            children: [
              const SizedBox(height: 20),
              Text("What do you want to learn today? ????????",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black),
              ),
              
              const SizedBox(height: 20),
              Container (
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  padding: const EdgeInsets.all(10.0),
                  children: <Widget> [
                    _buildCard("Basics"),
                    _buildCard("Food"),
                    _buildCard("Travel"),
                    _buildCard("School"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // UI widget for category cards wrapped in gesture detector for navigation
  Widget _buildCard(String text) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlashCardScreen(category: text),
        ));
      },
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          color: const Color(0xffA7D397),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Center(
          child: Text(
            text, 
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 24, 
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}


