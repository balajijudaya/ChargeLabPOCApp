import 'dart:async';
import 'package:ChargeLabPoCApp/amplifyconfiguration.dart';
import 'package:ChargeLabPoCApp/components/white_label.dart';
import 'package:ChargeLabPoCApp/login_page.dart';
import 'package:ChargeLabPoCApp/page_flow.dart';
import 'package:ChargeLabPoCApp/signup_page.dart';
import 'package:ChargeLabPoCApp/components/auth_service.dart';
import 'package:ChargeLabPoCApp/verification_page.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  // Initialize binding before runApp
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'chargelab-poc',
    options: FirebaseOptions(
      appId: '1:261706059002:android:b47b221d7189046f284d43',
      apiKey: 'AIzaSyBKpf4KS0Qx9umZ985Zx-1mYP8yTq3Ti_M',
      projectId: 'chargelabpoc',
      messagingSenderId: '261706059002',
      databaseURL: 'https://chargelab-poc-default-rtdb.firebaseio.com',
    )
  );

  runApp(ChargeLabPoCApp());
}


class ChargeLabPoCApp extends StatefulWidget {
  final FirebaseApp app;

  ChargeLabPoCApp({this.app});

  @override
  _ChargeLabPoCAppState createState() => _ChargeLabPoCAppState();
}

class _ChargeLabPoCAppState extends State<ChargeLabPoCApp> {
  final _amplify = Amplify;
  final _authService = AuthService();
  DatabaseReference _brandsRef;
  StreamSubscription<Event> _dbSubscription;
  PartnerBrand _partnerBrand;
  // Brand ID to fetch brand specific assets from Firebase RTDB
  static const String _brandID = 'ChargeLab';
  var _brand;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
    getBrandAssets();
    _authService.showLogin();
    //_authService.checkAuthStatus();    
  }


  getBrandAssets() async {
    if (_brandID == 'ChargeLab') {
      //Config database directly
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _brandsRef = database.reference().child('BrandID');
    _brandsRef.once().then((DataSnapshot snapshot) {
      print('Connected to database and read ${snapshot.value}');
      _brand = snapshot.value['ChargeLab'];

      setState(() {
        // Instantiate PartnerBrand Obj with partner specific info
        _partnerBrand = new PartnerBrand(
          greetMsg: _brand['greetMsg'],
          logo: _brand['logo'],
          supportPhone: _brand['supportPhone']
        );
      });
    });
    
    // Keep database in sync & cache synched data
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(1000000000);
    _brandsRef.keepSynced(true);

    // TODO: Maybe Axe
    _dbSubscription = _brandsRef.onValue.listen((event) {
      setState(() {
      });

    
    });


    } else if (_brandID == 'TestBrand') {

    }
  }

  @override
  void dispose() {
    // Close Database stream subscription TODO: Axe if Axed above subscription
    _dbSubscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charge Lab PoC App',
      theme: brandTheme(),
      home: StreamBuilder<AuthState>(
        stream: _authService.authStateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Navigator(
              pages: [
                // Show App Pages
                if (snapshot.data.authFlowStatus == AuthFlowStatus.session)
                  MaterialPage(child: 
                    PageFlow(shouldLogOut: _authService.logOut
                    )
                  ),

                // show sign up page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
                  MaterialPage(child: 
                    SignUpPage(
                      shouldShowLogin: _authService.showLogin,
                      didProvideCredentials: _authService.signUpWithCredentials,
                      )
                    ),

                // Show verification code page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.verification)
                  MaterialPage(child: 
                    VerificationPage(didProvideVerificationCode: _authService.verifyCode
                    )
                  ),

                // Show login page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
                  MaterialPage(child: 
                    LoginPage(
                      shouldShowSignUp: _authService.showSignUp,
                      didProvideCredentials: _authService.loginWithCredentials,
                      partnerBrand: _partnerBrand,
                    )
                  ),
              ],
              onPopPage: (route, result) => route.didPop(result),
            );
          } else {
            // Snapshot has no data, show loading indicator
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        }
      )
    );
  }

  // Configure amplify with Auth plugin
  void _configureAmplify() async {
    _amplify.addPlugin(AmplifyAuthCognito());

    try {
      await _amplify.configure(amplifyconfig);
      print("Successfully configured Amplify");
    } catch (e) {
      print("Could not configure Amplify");
    }
  }
}