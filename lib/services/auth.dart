import 'package:be_thrift/models/models.dart';
import 'package:be_thrift/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'https://www.googleapis.com/auth/plus.me',
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/userinfo.profile',
  ]);

  CustomUser? get getUser => CustomUser.fromFirebaseUser(_auth.currentUser);

  Stream<CustomUser?> get user =>
      _auth.authStateChanges().map((user) => CustomUser.fromFirebaseUser(user));

  Future<CustomUser?> signInWithGoogle() async {
    try {
      AuthCredential credential = await getGoogleAuthCredential();
      var authResult = await _auth.signInWithCredential(credential);
      var user = await mapUserFromFirebaseUser(authResult);
      return user;
    } catch (e) {
      throw Exception('Something went horribly wrong, please try again later!');
    }
  }

  Future<AuthCredential> getGoogleAuthCredential() async {
    var googleAccount = await _googleSignIn.signIn();
    var googleAuthentication = await googleAccount?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuthentication?.idToken,
      accessToken: googleAuthentication?.accessToken,
    );
    return credential;
  }

  Future<CustomUser?> signInAnonymously() async {
    try {
      var authResult = await _auth.signInAnonymously();
      var user = await mapUserFromFirebaseUser(authResult);
      return user;
    } catch (e) {
      throw Exception('Something went horribly wrong, please try again later!');
    }
  }

  Future<CustomUser?> mapUserFromFirebaseUser(UserCredential authResult) async {
    var firebaseUser = authResult.user;
    var user = CustomUser.fromFirebaseUser(firebaseUser);
    try {
      if (user == null) return user;
      if (!(await UserDatabaseService(user).checkIfUserExists)) {
        UserDatabaseService(user).createUser();
      }
    } catch (_) {}
    return user;
  }

  Future signOut() async {
    try {
      _googleSignIn.signOut();
      return await _auth.signOut();
    } catch (e) {
      throw Exception('Something went horribly wrong, please try again later!');
    }
  }

  Future deleteUser() async {
    User firebaseUser = _auth.currentUser!;
    if (firebaseUser.providerData.firstOrNull?.providerId != 'firebase') {
      AuthCredential credential = await getGoogleAuthCredential();
      var authResult = await _auth.signInWithCredential(credential);
      firebaseUser = authResult.user!;
    }
    await firebaseUser.delete();
    signOut();
  }
}
