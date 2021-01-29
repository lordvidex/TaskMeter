import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/second': (_) => SecondScreen()},
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home page'),
        ),
        body: NewWidget(),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(child: Text('Welcome')),
          Text('Reqdsbgiaoskdlgf'),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/second');
            },
            child: Container(
                child: Text('See me?'),
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.red, Colors.blue]))),
          )
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(), body: Center(child: Text('Second Screen')));
  }
}
