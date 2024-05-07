class UserProfile {
  final String name;
  final int age;
  final double height;
  final double weight;
  double get bmi => weight / (height * height);

  const UserProfile({
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
  });
}
