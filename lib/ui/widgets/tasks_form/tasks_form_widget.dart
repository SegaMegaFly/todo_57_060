import 'package:flutter/material.dart';
import 'package:todolist060/ui/widgets/tasks_form/tasks_form_widget_model.dart';



class TasksFormWidget extends StatefulWidget {
  final int groupKey;
  const TasksFormWidget({Key? key, required this.groupKey}) : super(key: key);

  @override
  State<TasksFormWidget> createState() => _TasksFormWidgetState();
}

class _TasksFormWidgetState extends State<TasksFormWidget> {
 late final TasksFormWidgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = TasksFormWidgetModel(groupKey: widget.groupKey);
  }

  // @override
  // void didChangeDependencies() { 
  //   super.didChangeDependencies();

  //   if (_model == null) {
  //     final groupKey = ModalRoute.of(context)!.settings.arguments as int;
  //     _model = TasksFormWidgetModel(groupKey: groupKey);
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return TasksFormWidgetModelProvider(model: _model, child: const _TextFormWidgetBody(),);
  }
}

class _TextFormWidgetBody extends StatelessWidget {
  const _TextFormWidgetBody ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая задача'),
      ),
      body:  const Center(
          child:  Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _TaskTextWidget(),
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => 
            TasksFormWidgetModelProvider.read(context)
            ?.model
            .saveTasks(context),
        child: const Icon(Icons.done_outline_sharp),
      ),
    );
  }
}

//текстовое поле
class _TaskTextWidget extends StatelessWidget {
  const _TaskTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksFormWidgetModelProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      maxLines: null,
      minLines: null,
      expands: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Текст задачи', 
      ),
      onChanged: (value) => model?.taskText = value, 
      onEditingComplete: () => model?.saveTasks(context),
    );
  }
}
