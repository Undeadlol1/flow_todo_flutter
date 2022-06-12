import 'package:flow_todo_flutter_2022/features/users/data/get_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/models/profile.dart';

class GetProfile {
  final GetProfileRepository getProfileRepository;
  const GetProfile({required this.getProfileRepository});

  Future<Profile?> call({required String userId}) async {
    return await getProfileRepository(userId: userId);
  }
}
