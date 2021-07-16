import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/constants.dart';
import '../../../domain/models/task_group.dart';
import '../../../locale/locales.dart';
import '../../providers/task_group_provider.dart';
import '../../screens/task_group_description_screen.dart';
import '../task_progress_indicator.dart';
import 'gradient_icon.dart';

class TaskGroupWidget extends StatelessWidget {
  final TaskGroup taskGroup;
  final bool isDarkMode;
  const TaskGroupWidget({@required this.taskGroup, @required this.isDarkMode});
  @override
  Widget build(BuildContext context) {
    final taskGroupProvider = context.read<TaskGroupProvider>();
    return Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          color: isDarkMode ? Constants.appDarkBlue : Constants.appSkyBlue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(children: [
          Expanded(
            child: InkWell(
              onTap: () {
                taskGroupProvider.setCurrentTaskGroup(taskGroup);
                Navigator.of(context).pushNamed(
                    TaskGroupDescriptionScreen.routeName,
                    arguments: taskGroup);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    taskGroup.taskGroupName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                    child: Text(
                      '${taskGroup.completedCount} of ${taskGroup.tasks.length} tasks completed',
                      style: TextStyle(
                          color: isDarkMode
                              ? Constants.appLightGrey
                              : Constants.appDarkGrey,
                          fontSize: 12),
                    ),
                  ),
                  TaskProgressIndicator(
                    taskGroup.taskGroupProgress,
                    isDarkMode: isDarkMode,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 52.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PopupMenuButton<String>(
                  child: Icon(Icons.more_horiz, size: 16),
                  onSelected: (value) {
                    switch (value) {
                      case 'delete':
                        taskGroupProvider
                            .deleteTaskGroup(taskGroup.taskGroupId);
                    }
                  },
                  itemBuilder: (ctx) => [
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.delete_forever, color: Colors.red, size: 24),
                        SizedBox(width: 10),
                        Text(AppLocalizations.of(context).delete),
                      ]),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                GradientIcon(
                    size: 41.42,
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: isDarkMode
                            ? [
                                Constants.appLightGrey,
                                Colors.white.withOpacity(0.33)
                              ]
                            : [
                                Constants.appLightBlue,
                                Constants.appLightBlue,
                              ]),
                    child: SvgPicture.asset('assets/icons/clock.svg'))
              ],
            ),
          ),
        ]));
  }
}
