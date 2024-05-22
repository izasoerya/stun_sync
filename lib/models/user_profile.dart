class UserProfile {
  final String name;
  final String password;
  final int age;
  final double height;
  final double weight;
  final bool admin;
  double get bmi => weight / (height * height / 10000);

  const UserProfile({
    required this.name,
    required this.password,
    required this.age,
    required this.height,
    required this.weight,
    required this.admin,
  });
}
