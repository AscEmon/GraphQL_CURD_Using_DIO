

class PostModel {
    PostModel({
        this.data,
    });

    Data? data;

    factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.addPerson,
    });

    AddPerson? addPerson;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        addPerson: AddPerson.fromJson(json["addPerson"]),
    );

    Map<String, dynamic> toJson() => {
        "addPerson": addPerson!.toJson(),
    };
}

class AddPerson {
    AddPerson({
        this.id,
        this.name,
        this.lastName,
        this.age,
    });

    String? id;
    String? name;
    String? lastName;
    int? age;

    factory AddPerson.fromJson(Map<String, dynamic> json) => AddPerson(
        id: json["id"],
        name: json["name"],
        lastName: json["lastName"],
        age: json["age"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastName": lastName,
        "age": age,
    };
}
