import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class FirebaseStorageClass{
    // firebase instance
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  // firebase reference for users
  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
      .ref('users/profileImage');
  var streamData=0.0;

  // upload file to firebase
// download file form firebase
  Stream uploadFile(File file, userId) {
    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
        .ref('users/$userId')
    .putFile(file);
    task.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
     /* print('Task state: ${snapshot.state}');
      streamData=(snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      print(
          'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');*/
    }, onError: (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
      print(task.snapshot);

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    });

    try {
      // Storage tasks function as a Delegating Future so we can await them.
      firebase_storage.TaskSnapshot snapshot = task.snapshot;
      print('Uploaded ${snapshot.bytesTransferred} bytes.');
      return task.snapshotEvents;

    } on FirebaseException catch (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
      print(task.snapshot);

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
      // ...
    }
    return  task.snapshotEvents;
  }

  // download file stored in firebase storage
  Future<String> downloadURLExample(userId) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('users/$userId')
        .getDownloadURL();
    print('i am downloadUrl $downloadURL');
    return downloadURL;
    // Within your widgets:
    // Image.network(downloadURL);
  }
}