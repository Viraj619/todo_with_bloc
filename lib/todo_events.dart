
import 'package:todo_with_bloc/model/model_todo.dart';

abstract class TodoEvents {}
/// add event
class AddNotes extends TodoEvents{
  ModelTodo newNotes;
  AddNotes({required this.newNotes});
}
/// update event
class Update extends TodoEvents{
  ModelTodo updatedNotes;
  int sno;
  Update({required this.updatedNotes,required this.sno});
}
///delete event
class Delete extends TodoEvents{
  int sno;
  Delete({required this.sno});
}
/// initiasion
class Initiasion extends TodoEvents{}