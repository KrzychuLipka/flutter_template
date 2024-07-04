import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_template/common/utils/logger.dart';
import 'package:flutter_template/data/repository/dto/fossil_dto.dart';

class FossilsRepository {
  static const String _fossilsCollectionName = 'fossils';
  static const String _imagesPath = 'images';

  CollectionReference<Map<String, dynamic>> get _fossilsCollectionRef {
    return FirebaseFirestore.instance.collection(_fossilsCollectionName);
  }

  Future<List<FossilDto>> getFossils() async {
    final collectionRef = _fossilsCollectionRef.withConverter<FossilDto>(
      fromFirestore: (snapshot, _) => FossilDto.fromJson(snapshot.data()!),
      toFirestore: (fossilDto, _) => fossilDto.toJson(),
    );
    final querySnapshot = await collectionRef.get();
    final queryDocsSnapshots = querySnapshot.docs;
    return queryDocsSnapshots.map((fossilSnapshot) {
      final fossil = fossilSnapshot.data();
      fossil.id = fossilSnapshot.id;
      return fossil;
    }).toList();
  }

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
      _fossilsCollectionRef.add(fossilDto.toJson());
}
