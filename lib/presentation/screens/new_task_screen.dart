import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/count_by_status_wrapper.dart';
import 'package:task_manager/data/models/task_list_wrapper.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/controllers/count_task_by_status_controller.dart';
import 'package:task_manager/presentation/controllers/new_task_controller.dart';
import 'package:task_manager/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager/presentation/utils/app_colors.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager/presentation/widgets/show_snack_bar_message.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';
import 'package:task_manager/presentation/widgets/task_counter_card.dart';

import '../../data/models/task_count_by_status_data.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  // bool _getAllTaskCountByStatusInProgress = false;
  // bool _getNewTaskListInProgress = false;

  // CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();
  // TaskListWrapper _newTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getDataFromApis();
  }

  void _getDataFromApis() {
    // _getAllTaskCountByStatus();
    // _getAllNewTaskList();

    Get.find<CountTaskByStatusController>().getCountByTaskStatus();
    Get.find<NewTaskController>().getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: Column(
          children: [
            GetBuilder<CountTaskByStatusController>(
                builder: (countTaskByStatusController) {
              return Visibility(
                visible: !countTaskByStatusController.inProgress,
                replacement: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(),
                ),
                child: taskCounterSection(countTaskByStatusController
                        .countByStatusWrapper.listOfTaskByStatusData ??
                    []),
              );
            }),
            Expanded(
              child:
                  GetBuilder<NewTaskController>(builder: (newTaskController) {
                return Visibility(
                  visible: !newTaskController.inProgress,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async => _getDataFromApis(),
                    child: Visibility(
                      visible: newTaskController
                              .newTaskListWrapper.taskList?.isNotEmpty ??
                          false,
                      replacement: const EmptyListWidget(),
                      child: ListView.builder(
                        itemCount: newTaskController
                                .newTaskListWrapper.taskList?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            taskItem: newTaskController
                                .newTaskListWrapper.taskList![index],
                            refreshList: () {
                              _getDataFromApis();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );

          if (result != null && result == true) {
            _getDataFromApis();
          }
        },
        backgroundColor: AppColors.themeColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget taskCounterSection(List<TaskCountByStatus> listOfTaskCountByStatus) {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: listOfTaskCountByStatus.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TaskCounterCard(
              title: listOfTaskCountByStatus[index].sId ?? '',
              amount: listOfTaskCountByStatus[index].sum ?? 0,
            );
          },
          separatorBuilder: (_, __) {
            return const SizedBox(
              width: 8,
            );
          },
        ),
      ),
    );
  }

  // Future<void> _getAllTaskCountByStatus() async {
  //   _getAllTaskCountByStatusInProgress = true;
  //   setState(() {});
  //   final response = await NetworkCaller.getRequest(Urls.taskCountByStatus);
  //
  //   if (response.isSuccess) {
  //     _countByStatusWrapper =
  //         CountByStatusWrapper.fromJson(response.responseBody);
  //     _getAllTaskCountByStatusInProgress = false;
  //     setState(() {});
  //   } else {
  //     _getAllTaskCountByStatusInProgress = false;
  //     setState(() {});
  //     if (mounted) {
  //       showSnackBarMessage(
  //           context,
  //           response.errorMessage ??
  //               'Get task count by status has been failed');
  //     }
  //   }
  // }

  // Future<void> _getAllNewTaskList() async {
//   _getNewTaskListInProgress = true;
//   setState(() {});
//   final response = await NetworkCaller.getRequest(Urls.newTaskList);
//   if (response.isSuccess) {
//     _newTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
//     _getNewTaskListInProgress = false;
//     setState(() {});
//   } else {
//     _getNewTaskListInProgress = false;
//     setState(() {});
//     if (mounted) {
//       showSnackBarMessage(context,
//           response.errorMessage ?? 'Get new task list has been failed');
//     }
//   }
// }
}
