import 'package:bmi_calculator/components.dart';
import 'package:bmi_calculator/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

class BMIChart extends StatefulWidget {
  final bmi;

  const BMIChart({super.key, required this.bmi});

  @override
  State<BMIChart> createState() => _BMIChartState();
}

class _BMIChartState extends State<BMIChart> {
  var statementText = 'a';
  var statementColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    statementText = statementFunction(double.parse(widget.bmi), statementText);

    statementColor = colorFunction(double.parse(widget.bmi), statementColor);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(warning: '')));

              },
              icon: const Icon(Icons.arrow_back, color: Colors.white)),
          title: const Text(
            'BMI Calculator',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: defaultColor,

        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              PrettyGauge(
                  gaugeSize: 200,
                  minValue: 0,
                  maxValue: double.parse(widget.bmi) <= 40
                      ? 40
                      : double.parse(widget.bmi),
                  segments: [
                    GaugeSegment('Underweight', 18, Colors.yellow),
                    GaugeSegment('Healthy', 7, Colors.green),
                    GaugeSegment('Overweight', 5, Colors.orange),
                    GaugeSegment(
                        'Obesity',
                        double.parse(widget.bmi) <= 40
                            ? 10
                            : double.parse(widget.bmi) - 30,
                        Colors.red),
                  ],
                  currentValue: double.parse(widget.bmi),
                  displayWidget:
                      const Text('Your BMI', style: TextStyle(fontSize: 12))),
              Center(
                child: Text(
                  statementText.toString(),
                  style: TextStyle(fontSize: 22, color: statementColor),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(warning: '')));
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Calculate Again',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),


                ),
              ),
              SizedBox(height: 50,),
            ],
          ),
        ));
  }
}

String statementFunction(double bmi, var statementText) {
  if (bmi < 18.5) {
    statementText = 'You are underweight!';
  } else if (bmi >= 18.5 && bmi < 25) {
    statementText = 'You are healthy!';
  } else if(bmi >= 25 && bmi < 30){
    statementText = 'You are overweight!';
  }
  else{
    statementText = 'You are Obese!';

  }
  return statementText;
}

Color colorFunction(double bmi, Color statementColor) {
  if (bmi < 18.5) {
    statementColor = Colors.yellow;
  } else if (bmi >= 18.5 && bmi < 25) {
    statementColor = Colors.green;
  } else if (bmi >= 25 && bmi < 30) {
    statementColor = Colors.orange;
  } else {
    statementColor = Colors.red;
  }
  return statementColor;
}
