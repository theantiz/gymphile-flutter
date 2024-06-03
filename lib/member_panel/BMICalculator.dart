import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  double height = 0;
  double weight = 0;
  double bmi = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('img/app_backing.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter your height (cm):',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    height = double.tryParse(value) ?? 0;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Enter your weight (kg):',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    weight = double.tryParse(value) ?? 0;
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: calculateBMI,
                child: Text('Calculate BMI'),
              ),
              SizedBox(height: 16.0),
              Text(
                'BMI: $bmi',
                style: TextStyle(fontSize: 24.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calculateBMI() {
    if (height > 0 && weight > 0) {
      double heightInMeters = height / 100;
      bmi = weight / (heightInMeters * heightInMeters);
      _showBMICategory();
    } else {
      bmi = 0;
    }
    setState(() {});
  }

  void _showBMICategory() {
    String category;
    if (bmi < 18.5) {
      category = 'Underweight';
    } else if (bmi < 25) {
      category = 'Normal Weight';
    } else if (bmi < 30) {
      category = 'Overweight';
    } else {
      category = 'Obese';
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('BMI Category: $category'),
      ),
    );
  }
}
