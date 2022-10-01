import 'package:freezed_annotation/freezed_annotation.dart';

import '../../shared/widgets/typedef.dart';

part 'CategoryModel.freezed.dart';
part 'CategoryModel.g.dart';

@freezed
class CategoryModel with _$CategoryModel {
  factory CategoryModel({
    required int id,
    required String name,
    required String image,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(JSON json) => _$CategoryModelFromJson(json);
}
