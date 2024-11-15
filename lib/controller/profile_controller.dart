import 'package:food_app_project/services/firebase_setup.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var username = ''.obs;
  var email = ''.obs;
  var pswd = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProfile();
  }

  void fetchProfile() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        final profileSnapshot =
            await firebaseFirestore.collection('users').doc(user.uid).get();
        username.value = profileSnapshot.get('username');
        email.value = profileSnapshot.get('email');
        pswd.value = profileSnapshot.get('pswd');
      }
    } catch (e) {
      print("Error fetching profile data: $e");
    }
  }
}
