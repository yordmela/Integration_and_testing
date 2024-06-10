import 'package:mongo_dart/mongo_dart.dart';

class AdminLocalDataSource {
  final DbCollection itemCollection;

  AdminLocalDataSource(this.itemCollection);

  Future<List<Map<String, dynamic>>> getItems() async {
    final items = await itemCollection.find().toList();
    return items;
  }

  Future<void> addItem(Map<String, dynamic> item) async {
    await itemCollection.insertOne(item);
  }

  Future<void> updateItem(Map<String, dynamic> item) async {
    await itemCollection.update(
      where.eq('_id', item['_id']),
      item,
    );
  }

  Future<void> deleteItem(String itemId) async {
    await itemCollection.remove(where.id(ObjectId.parse(itemId)));
  }
}

