
import 'package:todo_with_bloc/database/db_helper.dart';

class ModelTodo{
  int? sno;
  String title,desc;
  int completed;

  ModelTodo({required this.title,required this.desc,this .sno,this.completed=0});
  /// from map
 factory ModelTodo.fromMap(Map<String,dynamic>map){
   return ModelTodo(sno:map[DbHelper.COLUMN_S_NO],title:map[DbHelper.COLUMN_TITLE], desc:map[DbHelper.COLUMN_DESC],completed: map[DbHelper.COMPLETED]);
 }
 Map<String,dynamic>toMap(){
   return{
     DbHelper.COLUMN_TITLE:title,
     DbHelper.COLUMN_DESC:desc,
     DbHelper.COMPLETED:completed,
   };
 }
}