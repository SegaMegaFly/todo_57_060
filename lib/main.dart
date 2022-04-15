
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist060/ui/widgets/app/my_app.dart';
 

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  const app = MyApp();
  runApp(app);
}



