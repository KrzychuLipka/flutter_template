import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_template/data/repository/dto/fossil_dto.dart';

class FossilsRepository {
  static const String _fossilsCollectionName = 'fossils';

  Future<DocumentReference> saveFossil({
    required FossilDto fossilDto,
  }) =>
      FirebaseFirestore.instance
          .collection(_fossilsCollectionName)
          .add(fossilDto.toMap());
}
