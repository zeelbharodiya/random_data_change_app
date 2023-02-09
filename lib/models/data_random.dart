class RandomData {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String avatar;
  final String gender;
  final String country;
  final String dateOfBirth;
  final String city;


  RandomData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.avatar,
    required this.gender,
    required this.country,
    required this.dateOfBirth,
    required this.city,
  });

  factory RandomData.fromMap({required Map data}) => RandomData(
    id: data["id"],
    firstName: data['first_name'],
    lastName: data['last_name'],
    username: data["username"],
    email: data["email"],
    avatar: data["avatar"],
    gender: data["gender"],
    country: data["address"]["country"],
    dateOfBirth: data["date_of_birth"],
    city: data["address"]["city"],
    );
  }


// String api = "https://randomuser.me/api/";

// firstName: data['results'][0]['name']['first'],
// lastName: data['results'][0]['name']['last'],