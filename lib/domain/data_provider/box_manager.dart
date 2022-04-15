import 'package:hive/hive.dart';
import 'package:todolist060/domain/entity/group.dart';
import 'package:todolist060/domain/entity/task.dart';


class BoxManager {
  // нужно чтобы один экземплят был на все приложение
  static final BoxManager instance = BoxManager._();

  final Map<String, int> _boxCounter = <String, int>{};

  //никто в приложении не должен создать экземпляр этого класса самостоятельно
  //делаем конструктор и делаем его приватным
  BoxManager._();


  Future<Box<Group>> openGroupBox() async{
    return _openBox('groups_box1', 1, GroupAdapter());
  }

   Future<Box<Task>> openTaskBox(int groupKey) async{
    return _openBox(makeTaskBoxName(groupKey), 2, TaskAdapter());
  }

  Future<void> closeBox<T>(Box<T> box) async{
    if (!box.isOpen) {
      _boxCounter.remove(box.name);
      return;
    }
    var count = _boxCounter[box.name] ?? 1;
    count -=1;
    _boxCounter[box.name] = count - 1;
    if (count > 0) return;
    
    _boxCounter.remove(box.name);
    await box.compact();
    await box.close();
  }
 
String makeTaskBoxName(int groupKey) => 'tasks_box1_$groupKey';

  Future<Box<T>> _openBox<T>(
    String name,
    int typeId,
    TypeAdapter<T> adapter, 
  ) async {
    if (Hive.isBoxOpen(name)) {
    final count = _boxCounter[name] ?? 1;
    _boxCounter[name] = count + 1;
    return Hive.box(name);
    }

    _boxCounter[name] = 1;
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }
    return Hive.openBox<T>(name);
  }
}
