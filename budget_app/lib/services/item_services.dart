import 'package:budget_app/repositories/repository.dart';
import 'package:budget_app/screens/models/itemData.dart';

class ItemService {
  Repository _repository;

  ItemService() {
    _repository = Repository();
  }

  saveCategory(ItemData itemData) async {
    return await _repository.insertData('item', itemData.toMap());
  }
}
