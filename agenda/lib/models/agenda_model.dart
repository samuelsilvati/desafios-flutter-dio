class AgendaModel {
  List<Results> results = [];

  AgendaModel(this.results);

  AgendaModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results.map((v) => v.toJson()).toList();
    return data;
  }
}

class Results {
  String objectId = "";
  String name = "";
  String phoneNumber = "";
  String createdAt = "";
  String updatedAt = "";
  String? imagePath = "";
  String? email = "";

  Results(this.objectId, this.name, this.phoneNumber, this.createdAt,
      this.updatedAt, this.imagePath, this.email);

  Results.create(this.name, this.phoneNumber, this.imagePath, this.email);

  Results.update(
      this.objectId, this.name, this.phoneNumber, this.imagePath, this.email);

  Results.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    name = json['Name'];
    phoneNumber = json['PhoneNumber'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    imagePath = json['ImagePath'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['Name'] = name;
    data['PhoneNumber'] = phoneNumber;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['ImagePath'] = imagePath;
    data['email'] = email;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['Name'] = name;
    data['PhoneNumber'] = phoneNumber;
    data['ImagePath'] = imagePath;
    data['email'] = email;
    return data;
  }
}
