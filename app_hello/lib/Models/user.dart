import 'dart:convert';

class User {
  //Define Fields
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
    required this.token,
  });

  //Seriazation: Covert User object to a map
  //Map: A map is a collection of key-value pairs
  //Why: Coverting to a map is an intermediate step that makes it easier to serialize
  //the object to formater like Json for storage or transmission

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
      'token': token,
    };
  }

  //Serialization: Convert a Json String
  //This method directly encodes the data from the map into a Json string

  //The json.encode() function converts a Dart object (such as a map or List)
  //between different systems.
  String toJson() {
    return json.encode(toMap());
  }

  //Deserialization: Convert a map to a User object
  //purpose - Manipulate and user : once the data is coverted a to a User object
  //we might want to display the user's fullname, email, etc on the UI. or we might
  //want to save the data locally.

  //the factory contructor takes a map (usually obtained from a Json object)
  //and coverts it into a User Object. if a field is not presend in the
  //it defaults to an empty string

  //fromMap: This contructor take a Map<String,dynamic> and returns a User object
  //. its usefull when yiu already have the data in map format

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      state: map['state'] as String? ?? '',
      city: map['city'] as String? ?? '',
      locality: map['locality'] as String? ?? '',
      password: map['password'] as String? ?? '',
      token: map['token'] as String? ?? '',
    );
  }

  //fromJson: This factory contructor takes a Json string and decodes into a Map<String,dynamic>
  //and then uses fromMap to covert that Map into a User object

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
