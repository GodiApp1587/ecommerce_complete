import '../models/categories/CategoryModel.dart';
import '../repositories/CategoryRepository.dart';

class CategoryProvider {
  final CategoryRepository _categoryRepository;

  CategoryProvider(this._categoryRepository);

  Future<List<CategoryModel>> getCategories() async {
    var categories = await _categoryRepository.getCategories();

    return categories
        .map((category) => CategoryModel.fromJson(category))
        .toList();
  }
}
