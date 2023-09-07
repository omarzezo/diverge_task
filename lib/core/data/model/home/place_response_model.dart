class PlacesResponseModel {
  List<Categories>? categories;
  List<Places>? places;
  List<Places>? popular;

  PlacesResponseModel({this.categories, this.places, this.popular});

  PlacesResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['places'] != null) {
      places = <Places>[];
      json['places'].forEach((v) {
        places!.add(new Places.fromJson(v));
      });
    }
    if (json['popular'] != null) {
      popular = <Places>[];
      json['popular'].forEach((v) {
        popular!.add(new Places.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.places != null) {
      data['places'] = this.places!.map((v) => v.toJson()).toList();
    }
    if (this.popular != null) {
      data['popular'] = this.popular!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? name;
  String? image;

  Categories({this.name, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Places {
  String? name;
  String? description;
  String? image;
  String? location;
  double? price;
  double? rate;
  bool isFavourite=false;
  List<String>? subImages;
  List<LovedPeople>? lovedPeople;

  Places(
      {this.name,
        this.description,
        this.image,
        this.location,
        this.price,
        this.rate,
        this.isFavourite=false,
        this.subImages,
        this.lovedPeople});

  Places.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    image = json['image'];
    location = json['location'];
    price = json['price'];
    rate = json['rate'];
    isFavourite = json['is_favourite'];
    subImages = json['sub_images'].cast<String>();
    if (json['loved_people'] != null) {
      lovedPeople = <LovedPeople>[];
      json['loved_people'].forEach((v) {
        lovedPeople!.add(new LovedPeople.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['location'] = this.location;
    data['price'] = this.price;
    data['rate'] = this.rate;
    data['is_favourite'] = this.isFavourite;
    data['sub_images'] = this.subImages;
    if (this.lovedPeople != null) {
      data['loved_people'] = this.lovedPeople!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class LovedPeople {
  String? name;
  String? image;

  LovedPeople({this.name,this.image});

  LovedPeople.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

