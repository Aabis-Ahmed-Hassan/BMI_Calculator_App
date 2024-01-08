import 'package:bmi_calculator/bmi_chart.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/components.dart';

class HomeScreen extends StatefulWidget {
  var warning='';
  HomeScreen({super.key , required this.warning});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var weight = TextEditingController();
  var feet = TextEditingController();
  var inches = TextEditingController();
  var bmi = ''; //this value will be passed to the bmi_chart.dart screen


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BMI Calculator',
              style: TextStyle(
                color: Colors.white,
              )),
          centerTitle: true,
          backgroundColor: defaultColor,
          automaticallyImplyLeading: false,

        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: weight,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Weight in Kgs'),
                  ),
                ),
                TextField(
                  controller: feet,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Height in Feet'),
                  ),
                ),
                TextField(
                  controller: inches,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Height in Inches'),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    if (weight.text.isNotEmpty &&
                        feet.text.isNotEmpty &&
                        inches.text.isNotEmpty) {
                      var weightInDouble = double.parse(weight.text);

                      var feetInDouble = double.parse(feet.text);
                      var inchesInDouble = double.parse(inches.text);

                      var heightInInches = (feetInDouble * 12) + inchesInDouble;

                      var heightInCentimeters = heightInInches * 2.54;
                      var heightInMeters = heightInCentimeters / 100;

                      var solution =
                          weightInDouble / (heightInMeters * heightInMeters);

                      print('Your bmi is ' + solution.toString());

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BMIChart(
                                    bmi: bmi,
                                  )));

                      bmi = solution.toStringAsFixed(2).toString();
                      setState(() {});
                    } else {
                   widget.warning = 'All fields are required!';
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Calculate',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(widget.warning, style:TextStyle(color: Colors.red,),),
                SizedBox(
                  height: widget.warning.contains('All fields are required!') ? 50 : 0,
                ),

              ],
            ),
          ),
        ));
  }
}
