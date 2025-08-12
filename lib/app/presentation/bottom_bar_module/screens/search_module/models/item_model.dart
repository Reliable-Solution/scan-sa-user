import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/online_cart_model.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';

class ItemModel {
  ItemModel({
    this.totalSize,
    this.limit,
    this.offset,
    this.items,
    this.categories,
  });

  ItemModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'] as int?;
    limit = json['limit'].toString();
    offset =
        (json['offset'] != null && json['offset'].toString().trim().isNotEmpty)
        ? int.parse(json['offset'].toString())
        : null;
    if (json['products'] != null) {
      items = [];
      json['products'].forEach((v) {
        items!.add(Item.fromJson(v as Map<String, dynamic>));
        // if (v['module_type'] == null ||
        //     !Get.find<SplashController>().getModuleConfig(v['module_type']).newVariation! ||
        //     v['variations'] == null ||
        //     v['variations'].isEmpty ||
        //     (v['food_variations'] != null && v['food_variations'].isNotEmpty)) {
        //   items!.add(Item.fromJson(v));
        // }
      });
    }
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        if (v['module_type'] == null ||
            !(Get.find<GlobalController>()
                    .getModuleConfig(v['module_type'] as String?)
                    ?.newVariation ??
                false) ||
            v['variations'] == null ||
            ((v['variations'] as String?)?.isEmpty ?? true) ||
            (v['food_variations'] != null &&
                ((v['variations'] as String?)?.isNotEmpty ?? false))) {
          items!.add(Item.fromJson(v as Map<String, dynamic>));
        }
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  int? totalSize;
  String? limit;
  int? offset;
  List<Item>? items;
  List<Categories>? categories;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (items != null) {
      data['products'] = items!.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  Item({
    this.id,
    this.name,
    this.description,
    this.imageFullUrl,
    this.imagesFullUrl,
    this.categoryId,
    this.categoryIds,
    this.variations,
    this.foodVariations,
    this.addOns,
    this.choiceOptions,
    this.price,
    this.tax,
    this.discount,
    this.discountType,
    this.availableTimeStarts,
    this.availableTimeEnds,
    this.storeId,
    this.storeName,
    this.zoneId,
    this.storeDiscount,
    this.scheduleOrder,
    this.avgRating,
    this.ratingCount,
    this.veg,
    this.moduleId,
    this.moduleType,
    this.unitType,
    this.stock,
    this.organic,
    this.quantityLimit,
    this.flashSale,
    this.isStoreHalalActive,
    this.isHalalItem,
    this.isPrescriptionRequired,
    this.nutritionsName,
    this.allergiesName,
    this.genericName,
  });

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    description = json['description'] as String?;
    imageFullUrl = json['image_full_url'] as String?;
    if (json['images_full_url'] != null) {
      imagesFullUrl = [];
      json['images_full_url'].forEach((v) {
        if (v != null) {
          imagesFullUrl!.add(v.toString());
        }
      });
    }
    categoryId = json['category_id'] as int?;
    if (json['category_ids'] != null) {
      categoryIds = [];
      json['category_ids'].forEach((v) {
        categoryIds!.add(CategoryIds.fromJson(v as Map<String, dynamic>));
      });
    }
    variations = [];
    if (json['variations'] != null) {
      json['variations'].forEach((v) {
        variations!.add(Variation.fromJson(v as Map<String, dynamic>));
      });
    }
    foodVariations = [];
    if (json['food_variations'] != null &&
        (json['food_variations'] as List<dynamic>).isNotEmpty) {
      json['food_variations'].forEach((v) {
        foodVariations!.add(FoodVariation.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['add_ons'] != null) {
      addOns = [];
      if (((json['add_ons'] is List
                      ? (json['add_ons'] as List?)?.length
                      : (json['add_ons'] as String?)?.length) ??
                  0) >
              0 &&
          json['add_ons'][0] != '[') {
        json['add_ons'].forEach((v) {
          addOns!.add(AddOns.fromJson(v as Map<String, dynamic>));
        });
      } else if (json['addons'] != null) {
        json['addons'].forEach((v) {
          addOns!.add(AddOns.fromJson(v as Map<String, dynamic>));
        });
      }
    }
    if (json['choice_options'] != null) {
      choiceOptions = [];
      json['choice_options'].forEach((v) {
        choiceOptions!.add(ChoiceOptions.fromJson(v as Map<String, dynamic>));
      });
    }
    price = json['price'].toDouble() as double?;
    tax = json['tax']?.toDouble() as double?;
    discount = json['discount'].toDouble() as double?;
    discountType = json['discount_type'] as String?;
    availableTimeStarts = json['available_time_starts'] as String?;
    availableTimeEnds = json['available_time_ends'] as String?;
    storeId = json['store_id'] as int?;
    storeName = json['store_name'] as String?;
    zoneId = json['zone_id'] as int?;
    storeDiscount = json['store_discount'].toDouble() as double?;
    scheduleOrder = json['schedule_order'] as bool?;
    avgRating = json['avg_rating'].toDouble() as double?;
    ratingCount = json['rating_count'] as int?;
    moduleId = json['module_id'] as int?;
    moduleType = json['module_type'] as String?;
    veg = json['veg'] != null ? int.parse(json['veg'].toString()) : 0;
    stock = json['stock'] as int?;
    unitType = json['unit_type'] as String?;
    availableDateStarts = json['available_date_starts'] as String?;
    organic = json['organic'] as int?;
    quantityLimit = json['maximum_cart_quantity'] as int?;
    flashSale = json['flash_sale'] as int?;
    isStoreHalalActive = json['halal_tag_status'] == 1;
    isHalalItem = json['is_halal'] == 1;
    isPrescriptionRequired = json['is_prescription_required'] == 1;
    nutritionsName = json['nutritions_name']?.cast<String>() as List<String>?;
    allergiesName = json['allergies_name']?.cast<String>() as List<String>?;
    genericName = json['generic_name']?.cast<String>() as List<String>?;
  }
  int? id;
  String? name;
  String? description;
  String? imageFullUrl;
  List<String>? imagesFullUrl;
  int? categoryId;
  List<CategoryIds>? categoryIds;
  List<Variation>? variations;
  List<FoodVariation>? foodVariations;
  List<AddOns>? addOns;
  List<ChoiceOptions>? choiceOptions;
  double? price;
  double? tax;
  double? discount;
  String? discountType;
  String? availableTimeStarts;
  String? availableTimeEnds;
  int? storeId;
  String? storeName;
  int? zoneId;
  double? storeDiscount;
  bool? scheduleOrder;
  double? avgRating;
  int? ratingCount;
  int? veg;
  int? moduleId;
  String? moduleType;
  String? unitType;
  int? stock;
  String? availableDateStarts;
  int? organic;
  int? quantityLimit;
  int? flashSale;
  bool? isStoreHalalActive;
  bool? isHalalItem;
  bool? isPrescriptionRequired;
  List<String>? nutritionsName;
  List<String>? allergiesName;
  List<String>? genericName;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image_full_url'] = imageFullUrl;
    data['images_full_url'] = imagesFullUrl;
    data['category_id'] = categoryId;
    if (categoryIds != null) {
      data['category_ids'] = categoryIds!.map((v) => v.toJson()).toList();
    }
    if (variations != null) {
      data['variations'] = variations!.map((v) => v.toJson()).toList();
    }
    if (foodVariations != null) {
      data['food_variations'] = foodVariations!.map((v) => v.toJson()).toList();
    }
    if (addOns != null) {
      data['add_ons'] = addOns!.map((v) => v.toJson()).toList();
    }
    if (choiceOptions != null) {
      data['choice_options'] = choiceOptions!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['tax'] = tax;
    data['discount'] = discount;
    data['discount_type'] = discountType;
    data['available_time_starts'] = availableTimeStarts;
    data['available_time_ends'] = availableTimeEnds;
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['zone_id'] = zoneId;
    data['store_discount'] = storeDiscount;
    data['schedule_order'] = scheduleOrder;
    data['avg_rating'] = avgRating;
    data['rating_count'] = ratingCount;
    data['veg'] = veg;
    data['module_id'] = moduleId;
    data['module_type'] = moduleType;
    data['stock'] = stock;
    data['unit_type'] = unitType;
    data['available_date_starts'] = availableDateStarts;
    data['organic'] = organic;
    data['maximum_cart_quantity'] = quantityLimit;
    data['flash_sale'] = flashSale;
    data['halal_tag_status'] = isStoreHalalActive;
    data['is_halal'] = isHalalItem;
    data['is_prescription_required'] = isPrescriptionRequired;
    data['nutritions_name'] = nutritionsName;
    data['allergies_name'] = allergiesName;
    data['generic_name'] = genericName;
    return data;
  }
}

class CategoryIds {
  CategoryIds({this.id, this.position});

  CategoryIds.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString()) ?? 0;
    position = int.tryParse(json['position'].toString()) ?? 0;
  }
  int? id;
  int? position;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['position'] = position;
    return data;
  }
}

class AddOns {
  AddOns({this.id, this.name, this.price});

  AddOns.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    price = json['price'] as double?;
  }
  int? id;
  String? name;
  double? price;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}

class ChoiceOptions {
  ChoiceOptions({this.name, this.title, this.options});

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    title = json['title'] as String?;
    options = json['options'].cast<String>() as List<String>;
  }
  String? name;
  String? title;
  List<String>? options;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['title'] = title;
    data['options'] = options;
    return data;
  }
}

class FoodVariation {
  FoodVariation({
    this.name,
    this.multiSelect,
    this.min,
    this.max,
    this.required,
    this.variationValues,
  });

  FoodVariation.fromJson(Map<String, dynamic> json) {
    if (json['max'] != null) {
      name = json['name'] as String?;
      multiSelect = json['type'] == 'multi';
      min = multiSelect! ? int.parse(json['min'].toString()) : 0;
      max = multiSelect! ? int.parse(json['max'].toString()) : 0;
      required = json['required'] == 'on';
      if (json['values'] != null) {
        variationValues = [];
        json['values'].forEach((v) {
          variationValues!.add(
            VariationValue.fromJson(v as Map<String, dynamic>),
          );
        });
      }
    }
  }
  String? name;
  bool? multiSelect;
  int? min;
  int? max;
  bool? required;
  List<VariationValue>? variationValues;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = multiSelect;
    data['min'] = min;
    data['max'] = max;
    data['required'] = required;
    if (variationValues != null) {
      data['values'] = variationValues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariationValue {
  VariationValue({this.level, this.optionPrice, this.isSelected});

  VariationValue.fromJson(Map<String, dynamic> json) {
    level = json['label'] as String?;
    optionPrice = double.parse(json['optionPrice'].toString());
    isSelected = json['isSelected'] as bool?;
  }
  String? level;
  double? optionPrice;
  bool? isSelected;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['label'] = level;
    data['optionPrice'] = optionPrice;
    data['isSelected'] = isSelected;
    return data;
  }
}

class Categories {
  Categories({
    this.id,
    this.name,
    this.image,
    this.parentId,
    this.position,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.priority,
    this.moduleId,
    this.slug,
    this.featured,
    this.productsCount,
    this.childesCount,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    image = json['image'] as String?;
    parentId = json['parent_id'] as int?;
    position = json['position'] as int?;
    status = json['status'] as int?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    priority = json['priority'] as int?;
    moduleId = json['module_id'] as int?;
    slug = json['slug'] as String?;
    featured = json['featured'] as int?;
    productsCount = json['products_count'] as int?;
    childesCount = json['childes_count'] as int?;
  }
  int? id;
  String? name;
  String? image;
  int? parentId;
  int? position;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? priority;
  int? moduleId;
  String? slug;
  int? featured;
  int? productsCount;
  int? childesCount;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['parent_id'] = parentId;
    data['position'] = position;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['priority'] = priority;
    data['module_id'] = moduleId;
    data['slug'] = slug;
    data['featured'] = featured;
    data['products_count'] = productsCount;
    data['childes_count'] = childesCount;
    return data;
  }
}
