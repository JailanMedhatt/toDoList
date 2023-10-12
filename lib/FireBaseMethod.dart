import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/Task.dart';
import 'package:todo/models/User.dart';

//CollectionReference<Task>
class FireBaseMethods {
  static CollectionReference<Task> getTasksCollection(String id) {
    return getUserCollection().doc(id).collection("tasks").withConverter<Task>(
        fromFirestore: (snapchot, option) =>
            Task.fromFireStore(snapchot.data()!),
        toFirestore: (task, option) => task.toFireStore());
  }
  static Future<void> addTaskToFireStore(Task task, String id){
    var taskCollection= getTasksCollection(id);
    DocumentReference<Task> docRef= taskCollection.doc();
    task.id=docRef.id;
    return docRef.set(task);
  }
  static Future<void> deleteTaskFromFireStore(Task task,String id){
    return getTasksCollection(id).doc(task.id).delete();
  }
  static CollectionReference<MyUser> getUserCollection(){
    return FirebaseFirestore.instance.collection("users").withConverter<MyUser>(fromFirestore: (snapChot,options)=> MyUser.fromFireStore(snapChot.data()!),
        toFirestore:(user,options)=>user.toFireStore());

  }
  static Future<void> addUserToFireStore(MyUser user){
    return getUserCollection().doc(user.id).set(user);
  }
  static Future<MyUser?> getUserFromFirestore(String id) async{
    var querySnapChot= await getUserCollection().doc(id).get();
    return querySnapChot.data();
  }
}
