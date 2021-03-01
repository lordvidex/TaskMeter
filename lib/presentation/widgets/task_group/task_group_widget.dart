import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../locale/locales.dart';
import '../../../domain/models/task_group.dart';
import '../../providers/task_group_provider.dart';
import '../../screens/task_group_description_screen.dart';
import '../task_progress_indicator.dart';

class TaskGroupWidget extends StatelessWidget {
  final TaskGroup taskGroup;
  const TaskGroupWidget({@required this.taskGroup});
  @override
  Widget build(BuildContext context) {
    final taskGroupProvider =
        Provider.of<TaskGroupProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        taskGroupProvider.setCurrentTaskGroup(taskGroup);
        Navigator.of(context).pushNamed(TaskGroupDescriptionScreen.routeName,
            arguments: taskGroup);
      },
      child: Container(
          padding: const EdgeInsets.only(bottom: 3),
          margin: const EdgeInsets.all(15),
          //height: 300,
          decoration: BoxDecoration(
            color: taskGroup.taskGroupColor[800],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Stack(children: [
            Positioned(
                top: 0,
                right: 0,
                child: DropdownButton(
                  onChanged: (_) {},
                  items: [
                    DropdownMenuItem(
                        value: 'delete',
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.delete_forever,
                                color: Colors.red, size: 24),
                            SizedBox(width: 10),
                            Text(AppLocalizations.of(context).delete),
                          ],
                        ),
                        onTap: () => taskGroupProvider
                            .deleteTaskGroup(taskGroup.taskGroupId))
                  ],
                  icon: Icon(Icons.more_vert, color: Colors.white),
                )),
            Positioned(
                right: -10,
                bottom: -30,
                child: SvgPicture.asset('assets/icons/checklists.svg',
                    color: taskGroup.taskGroupColor[500])),
            Row(children: [
              Flexible(
                flex: 7,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taskGroup.taskGroupName,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(taskGroup.taskGroupSubtitle,
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(height: 5),
                      Text(AppLocalizations.of(context).progress,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: taskGroup.taskGroupColor[100],
                          )),
                      SizedBox(height: 3),
                      TaskProgressIndicator(
                        taskGroup.taskGroupColor[100],
                        taskGroup.taskGroupProgress,
                        showPercentage: true,
                      )
                    ],
                  ),
                ),
              ),
              Flexible(flex: 3, child: Container())
            ]),
          ])),
    );
  }
}
