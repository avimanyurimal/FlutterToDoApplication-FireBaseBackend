import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/model/todo_model.dart';

class TodoService {
  final todoCollection = FirebaseFirestore.instance.collection('todoApp');

  //CREATE
  void addNewTask(TodoModel model) {
    todoCollection.add(model.toMap());
  }

  //UPDATE

  void updateTask(String? docID, bool? valueUpdate) {
    todoCollection.doc(docID).update({
      'isDone': valueUpdate,
    });
  }

  // Delete

  void deleTask(String? docID) {
    todoCollection.doc(docID).delete();
  }
}
