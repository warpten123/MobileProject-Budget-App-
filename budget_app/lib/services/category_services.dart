import 'package:budget_app/repositories/repository.dart';
import 'package:budget_app/screens/models/categoryData.dart';

class CategoryService {
  Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  saveCategory(CategoryData categoryData) async {
    return await _repository.insertData('category', data);
  }
}
