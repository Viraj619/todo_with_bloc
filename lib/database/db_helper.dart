
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_with_bloc/model/model_todo.dart';

class DbHelper{
  DbHelper._();

  static DbHelper getInstance()=>DbHelper._();

  static String TABLE_TODO="todo";
  static String COLUMN_S_NO="s_no";
  static String COLUMN_TITLE="title";
  static String COLUMN_DESC="desc";
  static String COMPLETED="completed";

  Database? mDb;

  Future<Database>getDB()async{
    mDb??=await openDB();
    return mDb!;
  }

     /// all Queries

  /// opening database
 Future<Database>openDB()async{
    Directory appDir=await getApplicationDocumentsDirectory();
    String dbPath=join(appDir.path,"todoDB.db");

    /// opening database
   return await openDatabase(dbPath,onCreate:(db,version){
     db.execute("create table $TABLE_TODO ( $COLUMN_S_NO integer primary key autoincrement, $COLUMN_TITLE text, $COLUMN_DESC text, $COMPLETED integer)");
   },version: 1);
 }
 /// addNotes
 Future<bool>addNotes({required ModelTodo newNotes})async{
    var mDb=await getDB();
    int rowEffected=await mDb.insert(TABLE_TODO, newNotes.toMap());
    return rowEffected>0;
 }
    /// update
 Future<bool>updateNotes({required ModelTodo updateNotes,required int sno})async{
    var mDb=await getDB();
    int rowEffected = await mDb.update(TABLE_TODO,updateNotes.toMap(),where:"$COLUMN_S_NO=?",whereArgs: [sno]);
    return rowEffected>0;
 }
  ///  delete
 Future<bool>delete({required int sno})async{
    var mDb=await getDB();
    int rowEffected = await mDb.delete(TABLE_TODO,where: "$COLUMN_S_NO=?",whereArgs: [sno]);
    return rowEffected>0;
 }
 /// fetchAllNotes
 Future<List<ModelTodo>> fetchAllNotes()async{
    var mDb=await getDB();
    var data=await mDb.query(TABLE_TODO);
    List<ModelTodo>mNotes=[];
    for(Map<String,dynamic> eachData in data){
      mNotes.add(ModelTodo.fromMap(eachData));
    }
    return mNotes;
 }

}