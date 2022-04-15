// Сам экран группы

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:todolist060/ui/widgets/groups/groups_widget_model.dart';

class GroupsWidget extends StatefulWidget {
  const GroupsWidget({Key? key}) : super(key: key);

  @override
  State<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {
  final _model = GroupsWidgetModel();

  @override
  Widget build(BuildContext context) {
    return GroupsWidgetModelProvider(
      model: _model,
      child: const _GroupWidgetBody(),
    );
  }
  // @override
  // void dispose() async{
  //   await _model.dispose();
  //   super.dispose();
  // }
}

class _GroupWidgetBody extends StatelessWidget {
  const _GroupWidgetBody({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Группы'),
      ),
      body: const SafeArea(
        child: _GroupListWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            GroupsWidgetModelProvider.read(context)?.model.showForm(context),
        child: const Icon(Icons.ac_unit),
      ),
      
    );
  }
}

class _GroupListWidget extends StatelessWidget {
  const _GroupListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsCount =
        GroupsWidgetModelProvider.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
      itemCount: groupsCount,
      itemBuilder: (BuildContext context, int index) {
        return _GroupListRowWidget(
          indexInList: index,
          // child: child,
          // onDismissed: ,

        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 1,
        );
      },
    );
  }
}

//виджет стоки
class _GroupListRowWidget extends StatelessWidget {

// final void Function(BuildContext context) onDismissed; // как я понял его нужно сюда добовлять
// final Widget child;

  final int indexInList;

  const _GroupListRowWidget({
    Key? key,
    required this.indexInList,

    // required this.child,
    // required this.onDismissed,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupsWidgetModelProvider.read(context)!.model;
    final group = model.groups[indexInList];

//final del = model.deleteGroup(indexInList);



    return Slidable(
       actionPane: const SlidableScrollActionPane(),
        
      secondaryActions: <Widget>[
        
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => model.deleteGroup(indexInList),
        ),
      ],
      child: ListTile(
        title: Text(group.name),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: () => model.showTasks(context, indexInList),
      ),
    );
  }
}

// void _deleting (BuildContext context) {
// // del - нужно придумать как это реализовать
// ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Как удалить группу?'),) );

// }

