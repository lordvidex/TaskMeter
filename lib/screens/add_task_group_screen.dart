import 'package:flutter/material.dart';

class AddTaskGroupScreen extends StatefulWidget {
  static const routeName = '/new-task-group';
  @override
  _AddTaskGroupScreenState createState() => _AddTaskGroupScreenState();
}

class _AddTaskGroupScreenState extends State<AddTaskGroupScreen> {
  GlobalKey<FormState> _formKey;
  @override
  void initState() {
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Task Group')),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(child: Column(children: []))),
    );
  }
}
