import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_wrapper.dart';
import 'package:task_manager/presentation/controllers/cancelled_task_controller.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

import '../widgets/empty_list_widget.dart';
import '../widgets/show_snack_bar_message.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  TaskListWrapper _cancelledTaskListWrapper = TaskListWrapper();
  final CancelledTaskController _cancelledTaskController =
      Get.find<CancelledTaskController>();

  @override
  void initState() {
    super.initState();
    _getAllCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: GetBuilder<CancelledTaskController>(
            builder: (cancelledTaskController) {
          return Visibility(
            visible: !cancelledTaskController.inProgress,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                _getAllCancelledTaskList();
              },
              child: Visibility(
                visible:
                    _cancelledTaskListWrapper.taskList?.isNotEmpty ?? false,
                replacement: const EmptyListWidget(),
                child: ListView.builder(
                  itemCount: _cancelledTaskController
                          .cancelledTaskListWrapper.taskList?.length ??
                      0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskItem: _cancelledTaskController
                          .cancelledTaskListWrapper.taskList![index],
                      refreshList: () {
                        _getAllCancelledTaskList();
                      },
                    );
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> _getAllCancelledTaskList() async {
    bool result = await _cancelledTaskController.getAllCancelledTaskList();

    if (result) {
      _cancelledTaskListWrapper =
          _cancelledTaskController.cancelledTaskListWrapper;
    } else {
      if (mounted) {
        showSnackBarMessage(context, _cancelledTaskController.errorMessage);
      }
    }
  }
}
