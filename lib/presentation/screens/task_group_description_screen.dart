import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../providers/task_group_provider.dart';
import '../widgets/task_group_description/task_card.dart';
import '../widgets/task_progress_indicator.dart';
import '../widgets/task_timer/action_button.dart';
import 'create_task_group_screen.dart';

class TaskGroupDescriptionScreen extends StatelessWidget {
  static const routeName = '/task-group-description';
  @override
  Widget build(BuildContext context) {
    final taskGroup = context.watch<TaskGroupProvider>().currentTaskGroup;
    final mediaQuery = MediaQuery.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        backgroundColor:
            isDarkMode ? Constants.appDarkBlue : Constants.appLightBlue,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Container(
                  child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 14, 30, 14)),
                            onPressed: () => Navigator.of(context).pop(),
                            child: SvgPicture.asset('assets/icons/back.svg',
                                color: isDarkMode
                                    ? Colors.white
                                    : Constants.appNavyBlue),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 27.0, bottom: 12),
                            child: Text(
                              taskGroup.taskGroupName,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            '${taskGroup.completedCount} of ${taskGroup.tasks.length} tasks completed',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode
                                    ? Constants.appLightGrey
                                    : Constants.appDarkGrey),
                          ),
                          Padding(
                            child: TaskProgressIndicator(
                              taskGroup.taskGroupProgress,
                              isDarkMode: isDarkMode,
                              showPercentage: true,
                            ),
                            padding: const EdgeInsets.only(
                                top: 32, right: 42, bottom: 48),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/bell.png',
                    height: 175.44,
                  )
                ],
              )),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      24, 36, 24, 16 + mediaQuery.padding.bottom),
                  decoration: BoxDecoration(
                      color: isDarkMode ? Colors.black : Constants.appWhiteBlue,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (ctx, index) {
                            return TaskCard(
                                taskGroup: taskGroup,
                                task: taskGroup.sortedTasks[index]);
                          },
                          itemCount: taskGroup.tasks.length,
                        ),
                      ),
                      if (taskGroup.isEditable)
                        ActionButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed(CreateTaskGroupScreen.routeName),
                            fillColor: Constants.appBlue,
                            text: 'Edit task')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
