
 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_bloc/database/db_helper.dart';
import 'package:todo_with_bloc/todo_events.dart';
import 'package:todo_with_bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvents,TodoState>{
  DbHelper dbHelper;
  TodoBloc({required this.dbHelper}):super(InisialState()){

    /// add
    on<AddNotes>((event,emi)async{
      emi(InisialState());
      bool check=await dbHelper.addNotes(newNotes: event.newNotes);
      if(check){
        var notes=await dbHelper.fetchAllNotes();
        emi(LoadedState(mTodo: notes));
      }else{
        emi(ErrorState(error: "Note not added !!!"));
      }
    });
    /// update
    on<Update>((event,emit)async{
      emit(InisialState());
      bool check=await dbHelper.updateNotes(updateNotes: event.updatedNotes, sno: event.sno);
      if(check){
        var notes=await dbHelper.fetchAllNotes();
        emit(LoadedState(mTodo: notes));
      }else{
        emit(ErrorState(error: "note not updated !!!"));
      }
    });
    ///
    on<Delete>((event,emit)async{
      emit(InisialState());
      bool check=await dbHelper.delete(sno: event.sno);
      if(check){
        var notes=await dbHelper.fetchAllNotes();
        emit(LoadedState(mTodo: notes));
      }else{
        emit(ErrorState(error: "note not deleted !!!"));
      }
    });
    on<Initiasion>((event,emit)async{
      var note=await dbHelper.fetchAllNotes();
      emit(LoadedState(mTodo: note));
    });
  }
}