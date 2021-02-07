import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_group_provider.dart';
import '../widgets/task_group_widget.dart';
import 'create_task_group_screen.dart';

class TaskGroupScreen extends StatelessWidget {
  static const routeName = '/task-group';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.add, color: Colors.black),
          onPressed: () =>
              Navigator.of(context).pushNamed(CreateTaskGroupScreen.routeName),
        ),
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.settings, color: Colors.black),
                onPressed: () {},
              )
            ],
            backgroundColor: Colors.white,
            expandedHeight: 120,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Task Groups',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
          Consumer<TaskGroupProvider>(
            builder: (ctx, provider, child) {
              final groups = provider.taskGroups;
              if (groups.isEmpty)
                return child;
              else
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, index) => TaskGroupWidget(
                      taskGroup: groups[index],
                    ),
                    childCount: groups.length,
                  ),
                );
            },
            child: SliverToBoxAdapter(
                child: Center(
                    child: Column(
              children: [
                Image.asset('assets/images/donkey.png'),
                Text('Task Group list is empty.'),
                Flex(
                    mainAxisAlignment: MainAxisAlignment.center,
                    direction: Axis.horizontal,
                    children: [
                      Text('Click on '),
                      Icon(Icons.add),
                      Text('to add new Task Group')
                    ]),
              ],
            ))),
          )
        ]));
  }
}
