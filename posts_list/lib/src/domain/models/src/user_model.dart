class UserModel {
  int _id;
  String _name;
  String _username;
  String _email;
  AddressModel _address;
  String _phone;
  String _website;
  CompanyModel _company;

  int get id => _id;

  String get name => _name;

  String get username => _username;

  String get email => _email;

  AddressModel get address => _address;

  String get phone => _phone;

  String get website => _website;

  CompanyModel get company => _company;

  UserModel(
      {int id,
      String name,
      String username,
      String email,
      AddressModel address,
      String phone,
      String website,
      CompanyModel company}) {
    _id = id;
    _name = name;
    _username = username;
    _email = email;
    _address = address;
    _phone = phone;
    _website = website;
    _company = company;
  }

  UserModel.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _username = json["username"];
    _email = json["email"];
    _address = json["address"] != null ? AddressModel.fromJson(json["address"]) : null;
    _phone = json["phone"];
    _website = json["website"];
    _company = json["company"] != null ? CompanyModel.fromJson(json["company"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["username"] = _username;
    map["email"] = _email;
    if (_address != null) {
      map["address"] = _address.toJson();
    }
    map["phone"] = _phone;
    map["website"] = _website;
    if (_company != null) {
      map["company"] = _company.toJson();
    }
    return map;
  }
}

class CompanyModel {
  String _name;
  String _catchPhrase;
  String _bs;

  String get name => _name;

  String get catchPhrase => _catchPhrase;

  String get bs => _bs;

  CompanyModel({String name, String catchPhrase, String bs}) {
    _name = name;
    _catchPhrase = catchPhrase;
    _bs = bs;
  }

  CompanyModel.fromJson(dynamic json) {
    _name = json["name"];
    _catchPhrase = json["catchPhrase"];
    _bs = json["bs"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["catchPhrase"] = _catchPhrase;
    map["bs"] = _bs;
    return map;
  }
}

class AddressModel {
  String _street;
  String _suite;
  String _city;
  String _zipcode;
  GeoModel _geo;

  String get street => _street;

  String get suite => _suite;

  String get city => _city;

  String get zipcode => _zipcode;

  GeoModel get geo => _geo;

  AddressModel({String street, String suite, String city, String zipcode, GeoModel geo}) {
    _street = street;
    _suite = suite;
    _city = city;
    _zipcode = zipcode;
    _geo = geo;
  }

  AddressModel.fromJson(dynamic json) {
    _street = json["street"];
    _suite = json["suite"];
    _city = json["city"];
    _zipcode = json["zipcode"];
    _geo = json["geo"] != null ? GeoModel.fromJson(json["geo"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["street"] = _street;
    map["suite"] = _suite;
    map["city"] = _city;
    map["zipcode"] = _zipcode;
    if (_geo != null) {
      map["geo"] = _geo.toJson();
    }
    return map;
  }
}

class GeoModel {
  String _lat;
  String _lng;

  String get lat => _lat;

  String get lng => _lng;

  GeoModel({String lat, String lng}) {
    _lat = lat;
    _lng = lng;
  }

  GeoModel.fromJson(dynamic json) {
    _lat = json["lat"];
    _lng = json["lng"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["lat"] = _lat;
    map["lng"] = _lng;
    return map;
  }
}
