

class GetModel {
    GetModel({
        this.data,
    });

    Data? data;

    factory GetModel.fromJson(Map<String, dynamic> json) => GetModel(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.persons,
    });

    List<Person>? persons;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        persons: List<Person>.from(json["persons"].map((x) => Person.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "persons": List<dynamic>.from(persons!.map((x) => x.toJson())),
    };
}

class Person {
    Person({
        this.id,
        this.name,
        this.lastName,
        this.age,
    });

    String? id;
    String? name;
    String? lastName;
    int? age;

    factory Person.fromJson(Map<String, dynamic> json) => Person(
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
