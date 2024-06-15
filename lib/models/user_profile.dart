enum Role { parent, posyandu }

enum Property { height, weight, bmi }

class UserProfile {
  final String name;
  final String password;
  final int age;
  final double height;
  final double weight;
  final int lingkarKepala;
  final int lingkarDada;
  final bool admin;
  double get bmi => weight / (height * height / 10000);
  final DateTime datetime;

  const UserProfile(
      {required this.name,
      required this.password,
      required this.age,
      required this.height,
      required this.weight,
      required this.lingkarKepala,
      required this.lingkarDada,
      required this.admin,
      required this.datetime});

  bool isSameDay(UserProfile currentUser, UserProfile mqttUser) {
    return currentUser.datetime.year == mqttUser.datetime.year &&
        currentUser.datetime.month == mqttUser.datetime.month &&
        currentUser.datetime.day == mqttUser.datetime.day;
  }
}
