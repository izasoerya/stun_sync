import 'package:riverpod/riverpod.dart';
import 'package:stun_sync/models/user_profile.dart';

class UserProfileData extends StateNotifier<UserProfile> {
  UserProfileData(super.state);

  void setUser(UserProfile user) {
    state = user;
  }
}

final userProfile = StateNotifierProvider<UserProfileData, UserProfile>(
    (ref) => UserProfileData(const UserProfile(
          name: 'Ihza Soerya',
          height: 120,
          weight: 100,
          age: 30,
        )));
