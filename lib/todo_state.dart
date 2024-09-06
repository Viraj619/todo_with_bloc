
import 'model/model_todo.dart';

abstract class TodoState{}

class InisialState extends TodoState{}
class LoadingState extends TodoState{}
class LoadedState extends TodoState{
  List<ModelTodo>mTodo;
  LoadedState({required this.mTodo});
}
class ErrorState extends TodoState{
  String error;
  ErrorState({required this.error});
}