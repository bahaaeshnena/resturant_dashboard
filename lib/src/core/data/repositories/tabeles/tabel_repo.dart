import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/src/features/home/models/tabel_model.dart';

class TableRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'tables';

  Future<List<TabelModel>> getTables() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(_collectionPath).get();
      return querySnapshot.docs.map((doc) {
        return TabelModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> addTable(TabelModel table) async {
    try {
      await _firestore.collection(_collectionPath).add(table.toMap());
    } catch (e) {
      // ignore: avoid_print
      print('Error adding table: $e');
    }
  }

  Future<void> updateTable(TabelModel updatedTable) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(_collectionPath)
          .where('id', isEqualTo: updatedTable.id)
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.update(updatedTable.toMap());
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error updating table: $e');
    }
  }

  Future<void> deleteTable(String id) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(_collectionPath)
          .where('id', isEqualTo: id)
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting table: $e');
    }
  }
}
