class CategoriesModel {
  bool? result;
  Data? data;
  String? message;
  List<dynamic>? errors;

  CategoriesModel({this.result, this.data, this.message, this.errors});

  static CategoriesModel? _categoriesModel;
  // Getter to access the instance globally
  static CategoriesModel? get instance => _categoriesModel;

// Check if data is already loaded
  static bool get hasData => _categoriesModel != null;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    _categoriesModel = CategoriesModel(
      result: json['result'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
      errors: json['errors'] != null ? List<dynamic>.from(json['errors']) : [],
    );

    return _categoriesModel!;
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'data': data?.toJson(),
      'message': message,
      'errors': errors,
    };
  }
}

class Data {
  List<Category>? categories;

  Data({this.categories});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      categories: json['categories'] != null
          ? (json['categories'] as List)
              .map((i) => Category.fromJson(i))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories?.map((category) => category.toJson()).toList(),
    };
  }
}

class Category {
  int? id;
  String? title;
  String? slug;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Category({
    this.id,
    this.title,
    this.slug,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'type': type,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
