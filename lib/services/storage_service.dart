import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage{
  final firebase_storage.FirebaseStorage storage= firebase_storage.FirebaseStorage.instance;
  Future<void>upLoadFile(
      String filePath,
      String fileName,
      )async{
    File file = File(filePath);
    try{
      await storage.ref('items/$fileName').putFile(file);

     }
     on firebase_core.FirebaseException catch (e) {
      print('$e'+" jhamela hoiseeeee");
    }

    }
    Future<firebase_storage.ListResult> listFiles() async{
    firebase_storage.ListResult results = await storage.ref('items').listAll();

    results.items.forEach((firebase_storage.Reference ref)
    {
      print("file found: "+"$ref");
    });

    return results;
  }
  Future<String>downloadURL(String imageName) async{
    String downloadURL = await storage.ref('items/'+'$imageName').getDownloadURL();
    return downloadURL;
  }

}