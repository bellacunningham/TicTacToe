import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'TicTacToe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ConfettiController _controllerBottomCenter;
  int turn = 0;
  var symbols = new List(9);

  @override
  void initState() {
    for (int i = 0; i < 9; i++) {
      symbols[i] = "";
    }
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 4));
    super.initState();
  }

  @override
  void dispose() {
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("Assets/grid2.jpg"), fit: BoxFit.fitWidth)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [cell(0), cell(1), cell(2)],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [cell(3), cell(4), cell(5)],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [cell(6), cell(7), cell(8)],
                    ),
                  ),
                ],
              ),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ConfettiWidget(
            confettiController: _controllerBottomCenter,
            blastDirection: -pi / 2,
            emissionFrequency: 0.01,
            numberOfParticles: 20,
            maxBlastForce: 100,
            minBlastForce: 80,
            gravity: 0.3,
          ),
        ),
      ],
    );
  }

  Widget cell(int pos) {
    return FlatButton(
        onPressed: () {
          print("Block " + pos.toString() + " pressed");
          turn++;

          if (symbols[pos] == "") {
            if (turn % 2 == 0) {
              print("Even turn, print X");
              setState(() {
                symbols[pos] = "X";
              });
            } else {
              print("odd turn, print O");
              setState(() {
                symbols[pos] = "O";
              });
            }
          } else {
            print("cannot overwrite");
          }
          if (hasWonX()) {
            print("X has won");
            showAlertDialog(context, "X winner", "Congrats");
            _controllerBottomCenter.play();
          }
          if (hasWonO()) {
            print("O has won");
            showAlertDialog(context, "O winner", "Congrats");
            _controllerBottomCenter.play();
          }
          if (isFinished()) {
            print("draw");
            showAlertDialog(context, "DRAW", "Oh well");
          }
        },
        child: Text(
          symbols[pos],
          style: TextStyle(fontSize: 100),
        ));
  }

  bool isFinished() {
    bool finished = true;
    for (int i = 0; i < 9; i++) {
      if (symbols[i] == "") {
        finished = false;
      }
    }
    return finished;
  }

  bool hasWonO() {
    if (symbols[0] == "O" && symbols[1] == "O" && symbols[2] == "O") {
      return true;
    }
    if (symbols[3] == "O" && symbols[4] == "O" && symbols[5] == "O") {
      return true;
    }
    if (symbols[6] == "O" && symbols[7] == "O" && symbols[8] == "O") {
      return true;
    }
    if (symbols[0] == "O" && symbols[3] == "O" && symbols[6] == "O") {
      return true;
    }
    if (symbols[1] == "O" && symbols[4] == "O" && symbols[7] == "O") {
      return true;
    }
    if (symbols[2] == "O" && symbols[5] == "O" && symbols[8] == "O") {
      return true;
    }
    if (symbols[0] == "O" && symbols[4] == "O" && symbols[8] == "O") {
      return true;
    }
    if (symbols[2] == "O" && symbols[4] == "O" && symbols[6] == "O") {
      return true;
    }
    return false;
  }

  bool hasWonX() {
    if (symbols[0] == "X" && symbols[1] == "X" && symbols[2] == "X") {
      return true;
    }
    if (symbols[3] == "X" && symbols[4] == "X" && symbols[5] == "X") {
      return true;
    }
    if (symbols[6] == "X" && symbols[7] == "X" && symbols[8] == "X") {
      return true;
    }
    if (symbols[0] == "X" && symbols[3] == "X" && symbols[6] == "X") {
      return true;
    }
    if (symbols[1] == "X" && symbols[4] == "X" && symbols[7] == "X") {
      return true;
    }
    if (symbols[2] == "X" && symbols[5] == "X" && symbols[8] == "X") {
      return true;
    }
    if (symbols[0] == "X" && symbols[4] == "X" && symbols[8] == "X") {
      return true;
    }
    if (symbols[2] == "X" && symbols[4] == "X" && symbols[6] == "X") {
      return true;
    }
    return false;
  }

  showAlertDialog(BuildContext context, String title, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        setState(() {
          for (int i = 0; i < 9; i++) {
            symbols[i] = "";
          }
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
