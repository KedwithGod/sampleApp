class CategoryResponse {
  int? id;
  String? name;
  String? slug;
  int? parent;
  String? description;
  String? display;
  CategoryImage? image;
  int? menuOrder;
  int? count;
  CategoryLinks? lLinks;

  CategoryResponse(
      {this.id,
        this.name,
        this.slug,
        this.parent,
        this.description,
        this.display,
        this.image,
        this.menuOrder,
        this.count,
        this.lLinks});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    parent = json['parent'];
    description = json['description'];
    display = json['display'];
    image = json['image'] != null ?  CategoryImage.fromJson(json['image']) : null;
    menuOrder = json['menu_order'];
    count = json['count'];
    lLinks = json['_links'] != null ?  CategoryLinks.fromJson(json['_links']) : null;
  }

}

class CategoryImage {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;

  CategoryImage(
      {this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.src,
        this.name,
        this.alt});

  CategoryImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    name = json['name'];
    alt = json['alt'];
  }

}

class CategoryLinks {
  List<CategorySelf>? self;
  List? collection;

  CategoryLinks({this.self, this.collection});

  CategoryLinks.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <CategorySelf>[];
      json['self'].forEach((v) {
        self!.add( CategorySelf.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = json['collection'];
    }
  }

}

class CategorySelf {
  String? href;

  CategorySelf({this.href});

  CategorySelf.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }
}
