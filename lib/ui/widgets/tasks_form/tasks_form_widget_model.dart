import 'package:flutter/material.dart';
import 'package:todolist060/domain/data_provider/box_manager.dart';
import 'package:todolist060/domain/entity/task.dart';

class TasksFormWidgetModel {
  int groupKey;
  var taskText = '';
  TasksFormWidgetModel({required this.groupKey});
  // теперь в эту модель можем накидывать различные методы

//форма сохранения таски
  void saveTasks(BuildContext context) async {
    if (taskText.isEmpty) return; //если здесь пусто, то мы ничего не делаем

    final task = Task(text: taskText, isDone: false); 
    final box = await BoxManager.instance.openTaskBox(groupKey);
    await box.add(task);
    // await BoxManager.instance.closeBox(box);
    Navigator.of(context).pop();

  }
}

class TasksFormWidgetModelProvider extends InheritedWidget {
  final TasksFormWidgetModel model;  
  const TasksFormWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static TasksFormWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksFormWidgetModelProvider>()
        ?.widget;
    return widget is TasksFormWidgetModelProvider ? widget : null;
  }

  static TasksFormWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksFormWidgetModelProvider>();
  }

  @override
  bool updateShouldNotify(TasksFormWidgetModelProvider oldWidget) {
    return false;
  }
}
