import 'package:flutter/material.dart';
import 'AdLog.dart';
import 'melog.dart';

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('img/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AdLog()))
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87, // Background color
                    ),
                    child: Text("ADMIN"),
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => melog()))
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87, // Background color
                    ),
                    child: Text("MEMBER"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
