import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_group_provider.dart';
import '../widgets/task_group_widget.dart';

class TaskGroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.add, color: Colors.black),
          onPressed: () {},
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
                    childCount: 20,
                  ),
                );
            },
            child:
                SliverToBoxAdapter(child: Container(child: Text('Empty List'))),
          )
        ]));
  }
}