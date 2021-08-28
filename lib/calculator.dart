// import package
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

// import class
import 'calculatorButton.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '+',
    '-',
    '1',
    '2',
    '3',
    'x',
    '4',
    '5',
    '6',
    '/',
    '7',
    '8',
    '9',
    '%',
    '.',
    '0',
    '^', // sebelumnya adalah 'ANS'
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepOrange[100],
        child: Column(
          children: <Widget>[
            Expanded(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // Container(child: ,)
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        child:
                            Text(userQuestion, style: TextStyle(fontSize: 40)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          child:
                              Text(userAnswer, style: TextStyle(fontSize: 40))),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // Silahkan di nonaktifkan jika layarnya panjang
                  // childAspectRatio: 5 / 4,
                  childAspectRatio: screenRatio(),
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (buttons[index] == 'C') {
                    // Clear Button
                    return CalculatorButton(
                      textButton: buttons[index],
                      textColor: Colors.white,
                      color: Colors.green,
                      buttonTapped: () {
                        setState(() {
                          userQuestion = '';
                        });
                      },
                    );
                  } else if (buttons[index] == 'DEL') {
                    // Delete Button
                    return CalculatorButton(
                      textButton: buttons[index],
                      textColor: Colors.white,
                      color: Colors.red,
                      buttonTapped: () {
                        if (userQuestion.length < 1) {
                          // agar tidak error ketika menghapus string yang kosong
                          setState(() {});
                        } else {
                          setState(() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          });
                        }
                      },
                    );
                  } else if (buttons[index] == '=') {
                    // Equal Button
                    return CalculatorButton(
                      textButton: buttons[index],
                      textColor: Colors.white,
                      color: Colors.deepOrange[400],
                      buttonTapped: () {
                        setState(() {
                          equalTapped();
                          // userQuestion = userAnswer;
                        });
                      },
                    );
                  } else {
                    // Number Button and Operator Button
                    return CalculatorButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = userQuestion + buttons[index];
                        });
                      },
                      textButton: buttons[index],
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.deepOrange[400],
                      color: isOperator(buttons[index])
                          ? Colors.deepOrange[400]
                          : Colors.white,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

// Function ketika tombol operator ditekan
  bool isOperator(String symbol) {
    if (symbol == '+' ||
        symbol == '-' ||
        symbol == 'x' ||
        symbol == '/' ||
        symbol == '%' ||
        symbol == '=') {
      return true;
    } else {
      return false;
    }
  }

// Function ketika tombol '=' ditekan
  void equalTapped() {
    // Nilainya dipindah ke variabel lain agar userQuestion tidak berubah
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression expression = p.parse(finalQuestion);

    ContextModel cm = ContextModel();
    double eval = expression.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }

  double screenRatio() {
    // var ratio = MediaQuery.of(context).size;
    var ratio = WidgetsBinding.instance.window.physicalSize;
    double value;
    if (ratio.height / ratio.width == (16 / 9)) {
      value = 5 / 4;
    } else if (ratio.height / ratio.width == (19.5 / 9)) {
      value = 1 / 1;
    } else {
      value = 5 / 4;
    }
    return value;
    // double a = 2;
    // return a;
  }
}
