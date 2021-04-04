class AppContactModel {
  AppContactModel({
    this.displayName,
    this.givenName,
    this.middleName,
    this.prefix,
    this.suffix,
    this.familyName,
    this.company,
    this.jobTitle,
    this.emails,
    this.phones,
    // this.postalAddresses,
    // this.avatar,
    this.photoURL,
    this.birthday,
    this.zimsterId,
    // this.androidAccountType,
    // this.androidAccountTypeRaw,
    // this.androidAccountName,
  });

  AppContactModel.fromMinimal({this.zimsterId,
  this.photoURL});



  String identifier,
      displayName,
      givenName,
      middleName,
      prefix,
      suffix,
      familyName,
      company,
      jobTitle,
      photoURL,
      zimsterId;
  Iterable<Item> emails = [];
  Iterable<Item> phones = [];
  // var postalAddresses = [];
  // Iterable<PostalAddress> postalAddresses = [];
  // Uint8List avatar;
  DateTime birthday;
}

class Item {
  Item({this.label, this.value});

  String label, value;

  Item.fromMap(Map m) {
    label = m["label"];
    value = m["value"];
  }
}
