import 'package:riverpod/riverpod.dart';
import 'package:stun_sync/models/user_profile.dart';

class UserProfileData extends StateNotifier<UserProfile> {
  UserProfileData(super.state);

  void setUser(UserProfile user) {
    state = user;
  }
}

final userProfileProvider = StateNotifierProvider<UserProfileData, UserProfile>(
    (ref) => UserProfileData(UserProfile(
          name: '',
          password: '',
          height: 0.0,
          weight: 0.0,
          age: 0,
          lingkarKepala: 0,
          lingkarDada: 0,
          admin: false,
          datetime: DateTime.now(),
          dateOfBirth: DateTime.now(),
          isMale: true,
        )));
