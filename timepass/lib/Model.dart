import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    Welcome({
        this.success,
        this.data,
    });

    bool success;
    List<Datum> data;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.productCategoryName,
        this.productCategoryImageUrl,
        this.isActive,
        this.productSubCategory,
    });

    int id;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    String productCategoryName;
    String productCategoryImageUrl;
    int isActive;
    List<ProductSubCategory> productSubCategory;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        productCategoryName: json["product_category_name"],
        productCategoryImageUrl: json["product_category_image_url"],
        isActive: json["is_active"],
        productSubCategory: List<ProductSubCategory>.from(json["product_sub_category"].map((x) => ProductSubCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "product_category_name": productCategoryName,
        "product_category_image_url": productCategoryImageUrl,
        "is_active": isActive,
        "product_sub_category": List<dynamic>.from(productSubCategory.map((x) => x.toJson())),
    };
}

class ProductSubCategory {
    ProductSubCategory({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.productSubcategoryName,
        this.productSubcategoryImageUrl,
        this.productCategoryId,
        this.isActive,
    });

    int id;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    String productSubcategoryName;
    String productSubcategoryImageUrl;
    int productCategoryId;
    int isActive;

    factory ProductSubCategory.fromJson(Map<String, dynamic> json) => ProductSubCategory(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        productSubcategoryName: json["product_subcategory_name"],
        productSubcategoryImageUrl: json["product_subcategory_image_url"],
        productCategoryId: json["product_category_id"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "product_subcategory_name": productSubcategoryName,
        "product_subcategory_image_url": productSubcategoryImageUrl,
        "product_category_id": productCategoryId,
        "is_active": isActive,
    };
}
