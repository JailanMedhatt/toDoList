import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/Task.dart';

//CollectionReference<Task>
class FireBaseMethods {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance.collection("tasks").withConverter<Task>(
        fromFirestore: (snapchot, option) =>
            Task.fromFireStore(snapchot.data()!),
        toFirestore: (task, option) => task.toFireStore());
  }
  static Future<void> addTaskToFireStore(Task task){
    var taskCollection= getTasksCollection();
    DocumentReference<Task> docRef= taskCollection.doc();
    task.id=docRef.id;
    return docRef.set(task);
  }
  static Future<void> deleteTaskFromFireStore(Task task){
    return getTasksCollection().doc(task.id).delete();
  }
}
