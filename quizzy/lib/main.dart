import 'package:flutter/material.dart';
import 'Question.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzy());

class Quizzy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body://QuizPage(),
         SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ));
  }
}


class QuizPage extends StatefulWidget {
  const QuizPage({super.key});
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper=[];

  int score=0;
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer=(quizBrain.getCorrectAnswer());
      setState(()
      {
        if (quizBrain.isFinished() == true) {
          //TODO Step 4 Part A - show an alert using rFlutter_alert,


          //Modified for our purposes:
          Alert(
            context: context,
            title: 'Finished!',
            desc: 'You\'ve reached the end of the quiz,\nAnd your score is $score',
          ).show();

          //TODO Step 4 Part C - reset the questionNumber,
          quizBrain.reset();

          //TODO Step 4 Part D - empty out the scoreKeeper.
          scoreKeeper = [];
          score=0;
        }

        else {
          if (userPickedAnswer == correctAnswer)
          {
            scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
            score++;
          }
          else {
            scoreKeeper.add(Icon(Icons.close, color: Colors.red,));
          }
          quizBrain.nextQuestion();
        }
      });



  }
  QuizBrain quizBrain=QuizBrain();
  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        //1.
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: Center(
              // child: Text((quizBrain.questionBank[questionNumber].question)!,
              child: Text((quizBrain.getQuestionText()),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white,),),
            ),),),
        //2.
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:TextButton(onPressed: (){
              checkAnswer(true);
            },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
              child:const Text("True", style: TextStyle(color: Colors.white, fontSize: 20.0,),),),
          ),),
        //3.
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:TextButton(onPressed: ()
            {

              checkAnswer(false);
            },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
              child:const Text("False",
                style: TextStyle(color: Colors.white, fontSize: 20.0,),
              ),
            ),
          ),
        ),
        Row(
          children:scoreKeeper
        )
      ],
    );
  }
}
