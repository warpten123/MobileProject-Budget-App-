import 'package:budget_app/repositories/repository.dart';
import 'package:budget_app/screens/models/itemData.dart';

class ItemService {
  Repository _repository;

  ItemService() {
    _repository = Repository();
  }

  saveItems(ItemData itemData) async {
    return await _repository.insertData('items', itemData.toMap());
  }

  readItems() async {
    return await _repository.readData('items');
  }

  readItemsByCategoryId(int categoryId) async {
    return await _repository.readItemsByCategoryId('items', categoryId);
  }

  returnCategoryTotal(int categoryID) async {
    return await _repository.readCategoryTotal(categoryID);
  }
}
