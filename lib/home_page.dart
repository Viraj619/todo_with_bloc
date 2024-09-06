
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_bloc/model/model_todo.dart';
import 'package:todo_with_bloc/todo_bloc.dart';
import 'package:todo_with_bloc/todo_events.dart';
import 'package:todo_with_bloc/todo_state.dart';

import 'detail_page.dart';

class HomePage extends StatelessWidget{
  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(Initiasion());
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo with Bloc"),
      ),
      body:Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<TodoBloc,TodoState>(builder: (_,state){
                if(state is LoadingState){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(state is ErrorState){
                  return Center(child: Text("error${state.error}"),);
                }
                if(state is LoadedState) {
                  List<ModelTodo>mNotes = state.mTodo;
                  return
                    SizedBox(
                      width: double.infinity,
                      height: 600,
                      child: ListView.builder(
                          itemCount: mNotes.length,
                          itemBuilder: (_, index) {
                            return  Stack(
                              children: [
                              Container(
                              height:120,
                              margin: EdgeInsets.all(11),
                              child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(sno: mNotes[index].sno!, title: mNotes[index].title, desc:mNotes[index].desc,),));
                                  },
                                  child: Card(
                                    elevation: 6,
                                    child: Column(
                                        children: [
                                        CheckboxListTile(
                                        controlAffinity: ListTileControlAffinity.leading,
                                        title: Row(
                                          children: [
                                            SizedBox(width: 180,child: Text(mNotes[index].title)),
          
                                            IconButton(onPressed: (){
                                              context.read<TodoBloc>().add(Delete(sno: mNotes[index].sno!));
                                            }, icon: Icon(Icons.delete)),
                                          ],
                                        ),
                                        value:mNotes[index].completed ==1, onChanged:(value){
                                      var update=ModelTodo(title:mNotes[index].title, desc:mNotes[index].desc,sno: mNotes[index].sno,completed: value! ?1:0);
                                      context.read<TodoBloc>().add(Update(updatedNotes: update, sno:mNotes[index].sno!));
          
                                    }),
          
                                    ],
                                  )
                              ),
                              )
                            )
                            ]
                            );
                          }),
                    );
                }
                return Container();
              })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          titleController.clear();
          descController.clear();
          showModalBottomSheet(context: context, builder: (_){
            return Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller:titleController ,
                    ),
                    TextField(
                      controller: descController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(onPressed: (){
                          context.read<TodoBloc>().add(AddNotes(newNotes: ModelTodo(title: titleController.text, desc:descController.text)));
                          Navigator.pop(context);
                        }, child: Text("add")),
                        ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Cancle")),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        },child: Icon(Icons.add),
      ),
    );
  }
}