import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Calculator", style: TextStyle(fontSize: 30)),
        ),
        body: Container(
          decoration: BoxDecoration(
            color:const Color.fromARGB(255, 120, 122, 124)
          ),
          child: Center(child: CalculatorApp()),
        ),
      ),
    ),
  );
}

class CalculatorApp extends StatefulWidget {
  @override
  State<CalculatorApp> createState() {
    return CalculatorState();
  }
}

class CalculatorState extends State<CalculatorApp> {
  String screenText = "";
  String lastAnswer = "";

  String evaluation(String expression) {
    final exp = Expression.parse(expression);
    final evaluator = const ExpressionEvaluator();
    final result = evaluator.eval(exp, {});
    return result.toString();
  }

  onButtonClick(String label) {
    if (label != "=" && label != "CLR") {
      setState(() {
        screenText += label;
      });
    } else if (label == "CLR") {
      setState(() {
        screenText = "";
      });
    } 
    else if(screenText.contains("/0")){
      setState(() {
        screenText= "Cannot divide by Zero";
      });
    }
    
    
    else {
      setState(() {
        lastAnswer = evaluation(screenText);
        screenText = lastAnswer;
      });
    }
  }

  Widget buildButton(String label, bool isDigit) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: FloatingActionButton(
            elevation: 10,
            backgroundColor:
                isDigit
                    ? const Color.fromARGB(255, 24, 99, 247)
                    : Color.fromRGBO(107, 149, 247, 1),
            foregroundColor: Colors.white,
          onPressed: () => {onButtonClick(label)},
          child: Text(
            label,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.maxFinite,
            height: 100,
            color: const Color.fromARGB(255, 206, 205, 205),
            child: Text(
              screenText,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Row(
          children: [
            buildButton('7', true),
            buildButton('8', true),
            buildButton('9', true),
            buildButton('*', false),
          ],
        ),
        Row(
          children: [
            buildButton('4', true),
            buildButton('5', true),
            buildButton('6', true),
            buildButton('/', false),
          ],
        ),
        Row(
          children: [
            buildButton('1', true),
            buildButton('2', true),
            buildButton('3', true),
            buildButton('+', false),
          ],
        ),
        Row(
          children: [
            buildButton('.', false),
            buildButton('0', true),
            buildButton('%', false),
            buildButton('-', false),
          ],
        ),
        Row(children: [buildButton('=', false), buildButton('CLR', false)]),
      ],
    );
  }
}
