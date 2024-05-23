enum Role { parent, puskesmas }

enum Property { height, weight, bmi }

class UserProfile {
  final String name;
  final String password;
  final int age;
  final int height;
  final int weight;
  final int lingkarKepala;
  final int lingkarDada;
  final bool admin;
  double get bmi => weight / (height * height / 10000);

  const UserProfile({
    required this.name,
    required this.password,
    required this.age,
    required this.height,
    required this.weight,
    required this.lingkarKepala,
    required this.lingkarDada,
    required this.admin,
  });
}
