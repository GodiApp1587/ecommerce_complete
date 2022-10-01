import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../shared/widgets/constant/firebase_constant.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> firebaseUser;
  RxBool isShowPW = true.obs;
  RxBool isShowrePW = true.obs;
  RxBool isRemember = false.obs;
  RxString errorLoginMsg = "".obs;
  RxString errorRegistMsg = "".obs;
  late UserCredential userCredential;

  @override
  void onInit() {
    super.onInit();

    firebaseUser = Rx<User?>(firebaseAuth.currentUser);

    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      // Get.offAll(() => const SignUp());
    } else {
      // Get.offAll(() => const HomeScreen());
    }
  }

  bool checkLoginValid(String email, String password) {
    if (email.isEmpty && password.isEmpty) {
      errorLoginMsg.value = 'Fill required fields';
      return false;
    }
    if (email.isEmpty) {
      errorLoginMsg.value = 'Gmail must be fill';
      return false;
    }

    if (password.isEmpty) {
      errorLoginMsg.value = 'Password must be fill';
      return false;
    }
    if (!email.isEmail) {
      errorLoginMsg.value = 'Gmail address is invalid';
      return false;
    }
    errorLoginMsg.value = '';
    return true;
  }

  bool checkRegisterValid(String email, String password, String repassword) {
    if (email.isEmpty && password.isEmpty && repassword.isEmpty) {
      errorRegistMsg.value = 'Fill required fields';
      return false;
    }
    if (email.isEmpty) {
      errorRegistMsg.value = 'Gmail must be fill';
      return false;
    }

    if (password.isEmpty) {
      errorRegistMsg.value = 'Password must be fill';
      return false;
    }
    if (!email.isEmail) {
      errorRegistMsg.value = 'Gmail address is invalid';
      return false;
    }
    if (repassword.isEmpty) {
      errorRegistMsg.value = 'Re-password must be fill';
      return false;
    }
    if (password != repassword) {
      errorRegistMsg.value = 'Re-password is not pair';
      return false;
    }
    errorRegistMsg.value = '';
    return true;
  }

  Future<bool> register(String email, password) async {
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user?.uid == null) {
        return false;
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorRegistMsg.value = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorRegistMsg.value = 'The account already exists for that email.';
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user?.uid == null) {
        return false;
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorLoginMsg.value = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorLoginMsg.value = 'Wrong password provided for that user.';
      }
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginAnonymously() async {
    userCredential = await FirebaseAuth.instance.signInAnonymously();
    print('ANONYMOUSLY LOGED IN: ${userCredential.toString()}');
  }
}
