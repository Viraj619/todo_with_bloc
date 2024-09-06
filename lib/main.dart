
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_bloc/database/db_helper.dart';
import 'package:todo_with_bloc/home_page.dart';
import 'package:todo_with_bloc/todo_bloc.dart';

void main(){
  runApp(BlocProvider(
      create: (context) => TodoBloc(dbHelper: DbHelper.getInstance()),
      child: MainApp()));
}
class MainApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}