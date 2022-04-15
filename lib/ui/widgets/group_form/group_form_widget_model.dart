

import 'package:flutter/material.dart';
import 'package:todolist060/domain/data_provider/box_manager.dart';
import 'package:todolist060/domain/entity/group.dart';


class GroupFormWidgetModel {
  // теперь в эту модель можем накидывать различные методы
  var groupName = '';

  final _groups = <Group>[];

  List<Group> get groups => _groups.toList();



  void saveGroup(BuildContext context) async{
    if (groupName.isEmpty) return; //если здесь пусто, то мы ничего не делаем
    
    final box = await BoxManager.instance.openGroupBox();
    final group = Group(name: groupName);
    await box.add(group);
    // await BoxManager.instance.closeBox(box);
    Navigator.of(context).pop();
     
  }
}

class GroupFormWidgetModelProvider extends InheritedWidget {
  final GroupFormWidgetModel model;
  const GroupFormWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
    
  }) : super(
          key: key,
          child: child,
        );

  static GroupFormWidgetModelProvider? read (BuildContext context) {
    final widget = context
    .getElementForInheritedWidgetOfExactType<GroupFormWidgetModelProvider>()
    ?.widget;
    return widget is GroupFormWidgetModelProvider ? widget : null;
  }

  static GroupFormWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupFormWidgetModelProvider>();
  }

  @override
  bool updateShouldNotify(GroupFormWidgetModelProvider oldWidget) {
    return false;
  }
}
