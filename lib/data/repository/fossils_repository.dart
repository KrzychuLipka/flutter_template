import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_template/common/utils/logger.dart';
import 'package:flutter_template/data/repository/dto/fossil_dto.dart';

class FossilsRepository {
  static const String _fossilsCollectionName = 'fossils';
  static const String _imagesPath = 'images';

  Future<String> uploadFossilPhoto({
    required XFile? photoFile,
  }) async {
    if (photoFile == null) return '';
    try {
      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('$_imagesPath/${photoFile.name}');
      final photoData = await photoFile.readAsBytes();
      final uploadTask = await firebaseStorageRef.putData(photoData);
      final photoURL = await uploadTask.ref.getDownloadURL();
      return photoURL;
    } catch (error) {
      Logger.d('$error');
      return '';
    }
  }

  Future<DocumentReference> saveFossil({
    required FossilDto fossilDto,
  }) =>
      FirebaseFirestore.instance
          .collection(_fossilsCollectionName)
          .add(fossilDto.toMap());
}
