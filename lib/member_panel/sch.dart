import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class sch extends StatelessWidget {
  final List<ButtonInfo> buttons = [
    ButtonInfo(
      title: 'Monday     ',
      link: 'https://www.youtube.com/watch?v=5DFAcAvT2mI&t',
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      icon: Icons.fitness_center,
    ),
    ButtonInfo(
      title: 'Tuesday    ',
      link: 'https://www.youtube.com/watch?v=6oc4e1mxY7I',
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      icon: Icons.fitness_center,
    ),
    ButtonInfo(
      title: 'Wednesday',
      link: 'https://www.youtube.com/watch?v=GBkN2RCZB4w',
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      icon: Icons.fitness_center,
    ),
    ButtonInfo(
      title: 'Thursday    ',
      link: 'youtube.com/watch?v=xgAAlGnHtrs',
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      icon: Icons.fitness_center,
    ),
    ButtonInfo(
      title: 'Friday         ',
      link: 'https://www.youtube.com/watch?v=QSmAp5rcUdU',
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      icon: Icons.fitness_center,
    ),
    ButtonInfo(
      title: 'Saturday     ',
      link: 'https://www.youtube.com/watch?v=XL8c6fvAZAk',
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      icon: Icons.fitness_center,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'img/app_backing.png'), // Replace with your custom image path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Today, Which Day?',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buttons.map((button) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        launch(button.link);
                      },
                      icon: Icon(button.icon),
                      label: Text(
                        button.title,
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: button.textColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 120.0, vertical: 16.0),
                        backgroundColor: button.backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 3.0,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonInfo {
  final String title;
  final String link;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;

  ButtonInfo({
    required this.title,
    required this.link,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
  });
}
