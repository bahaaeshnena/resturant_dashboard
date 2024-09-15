import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/src/features/home/models/tabel_model.dart';

class TableRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'tables';

  Future<List<TableModel>> getTables() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(_collectionPath).get();
      return querySnapshot.docs.map((doc) {
        return TableModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Stream<List<TableModel>> streamTables() {
    return _firestore.collection(_collectionPath).snapshots().map((snapshot) {
      List<TableModel> tables = snapshot.docs.map((doc) {
        // ignore: unnecessary_cast
        return TableModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      tables.sort((a, b) {
        final int aTableNumber = _extractTableNumber(a.name);
        final int bTableNumber = _extractTableNumber(b.name);
        return aTableNumber.compareTo(bTableNumber);
      });

      return tables;
    });
  }

  int _extractTableNumber(String tableName) {
    final regex = RegExp(r'(\d+)');
    final match = regex.firstMatch(tableName);
    if (match != null) {
      return int.parse(match.group(0)!);
    }
    return 0;
  }

  Future<void> addTable(TableModel table) async {
    try {
      await _firestore.collection(_collectionPath).add(table.toMap());
    } catch (e) {
      // ignore: avoid_print
      print('Error adding table: $e');
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

  Future<void> updateTable(TableModel table) async {
    try {
      // Get the document reference
      final querySnapshot = await _firestore
          .collection(_collectionPath)
          .where('id', isEqualTo: table.id)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('Document does not exist');
      }

      // Get the document ID
      final documentId = querySnapshot.docs.first.id;

      // Update the document using the document ID
      await _firestore
          .collection(_collectionPath)
          .doc(documentId)
          .update(table.toMap());
    } catch (e) {
      // ignore: avoid_print
      print('Error updating table: $e');
    }
  }

  Future<QuerySnapshot> getTablesByName(String name) async {
    try {
      return await _firestore
          .collection(_collectionPath)
          .where('name', isEqualTo: name)
          .get();
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching tables by name: $e');
      rethrow;
    }
  }
}
