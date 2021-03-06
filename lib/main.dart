import 'package:flutter/material.dart';
import 'package:quizapp/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(QuizzApp());
var quizBrain = QuizBrain();

class QuizzApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  // int scoreSheet() {
  //   setState(() {});
  //   Iterable<Icon> score = scoreKeeper.where(
  //     (element) => element == Icon(Icons.check),
  //   );
  //   print(score.length.toString());
  //   return score.length;
  // }

  // int countCorrectAnswer() {
  //   var foundElements =
  //       scoreKeeper.where((e) => e == Icon(Icons.check, color: Colors.green));
  //   print(foundElements.length);
  //   return foundElements.length;
  // }

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(
      () {
        if (quizBrain.isFinished() == true) {
          Alert(
            context: context,
            type: AlertType.success,
            title: "You finished the quiz",
            desc: "You scored 6",
            buttons: [
              DialogButton(
                child: Text(
                  "Restart",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context);

                  quizBrain.reset();
                  scoreKeeper.clear();
                  quizBrain.shuffleQuestions();
                },
                width: 120,
              )
            ],
          ).show();
        } else {
          if (userAnswer == correctAnswer) {
            scoreKeeper.add(
              Icon(
                Icons.check,
                color: Colors.green,
              ),
            );
          } else {
            scoreKeeper.add(
              Icon(
                Icons.close,
                color: Colors.red,
              ),
            );
          }
          quizBrain.nextQuestion();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              quizBrain.questionNumberText(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            // Text(
            //   '0',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 20,
            //   ),
            // ),
          ],
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                textStyle: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                textStyle: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
