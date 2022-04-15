// single sourse of true
//здесь представлен код, ктр отвечает только за навигацию

import 'package:flutter/material.dart';
import 'package:todolist060/ui/widgets/example/dsmissible_ex.dart';
import 'package:todolist060/ui/widgets/group_form/group_form_widget.dart';
import 'package:todolist060/ui/widgets/groups/groups_widget.dart';
import 'package:todolist060/ui/widgets/tasks/tasks_widget.dart';
import 'package:todolist060/ui/widgets/tasks_form/tasks_form_widget.dart';

// делаем все экраны константами
abstract class MainNavigationRouteNames {
  static const groups = '/';
  static const groupsForm = '/groupsForm';
  static const tasks = '/tasks';
  static const tasksForm = '/tasks/form';
}

class MainNavigation {
  final initialRoute = MainNavigationRouteNames.groups;
  final routes = {
    //может быть нужно добавить марч
    MainNavigationRouteNames.groups: (context) => const GroupsWidget(),
    MainNavigationRouteNames.groupsForm: (context) => const GroupFormWidget(),

    // эти предполагают работу с ключиками, аргументами
    // MainNavigationRouteNames.tasks: (context) => const TasksWidget(),
    // MainNavigationRouteNames.tasksForm: (context) => const TasksFormWidget(),

    'example': (context) => const DismissibleWidgetEx(),
  };

// если маршрут показан не будет, то сюда будут передаваться settings
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.tasks:
        final configuration = settings.arguments as TasksWidgetConfiguration;
        return MaterialPageRoute(
          builder: (context) => TasksWidget(configuration: configuration),
        );
      case MainNavigationRouteNames.tasksForm:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => TasksFormWidget(groupKey: groupKey),
        );
      default:
        const widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
