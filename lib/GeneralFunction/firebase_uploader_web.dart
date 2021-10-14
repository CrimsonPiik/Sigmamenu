import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';


FirebaseStorage storage = FirebaseStorage.instance;

Future<String> fireBaseUploadFileWeb(String uid) async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(withData: true);

  if (result != null) {
    String extension0 = result.files.first.extension!;
    String imageId = uid + (".") + extension0;

    FirebaseStorage storage = FirebaseStorage.instance;
    Uint8List? data = result.files.single.bytes;
    Reference ref = storage.ref('images/$uid').child(imageId);
    if (data == null) return "";
    try {
      await ref.putData(data);
      final _finalImageUrl = await ref.getDownloadURL();
      return _finalImageUrl;
    } on FirebaseException catch (e) {
      print(e);
    }
  }
  return "";
}
