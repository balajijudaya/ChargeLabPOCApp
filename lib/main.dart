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
import 'package:cached_network_image/cached_network_image.dart';
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
  var _brand;
  /*
  Brand ID to fetch brand specific assets from Firebase RTDB
  Must match BrandID in Database
  Change to match partner's app build to fetch appropriate assets
  */
  static const String _brandID = 'ChargeLab';

  @override
  void initState() {
    getBrandAssets();
    _configureAmplify();
    _authService.showLogin();
    //_authService.checkAuthStatus();    
    super.initState();
  }


  getBrandAssets() {
    //Config database directly
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _brandsRef = database.reference().child('BrandID');
    _brandsRef.once().then((DataSnapshot snapshot) {
      print('Connected to database and read ${snapshot.value}');
      _brand = snapshot.value[_brandID];

      setState(() {
        // Instantiate PartnerBrand Obj with partner specific info
        _partnerBrand = new PartnerBrand(
          greetMsg: _brand['greetMsg'],
          logo: CachedNetworkImage(
            imageUrl: _brand['logo'],
            progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(
              value: downloadProgress.progress,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          supportPhone: _brand['supportPhone'],
          brandTheme: ThemeData(
            primaryColor: Color(int.parse(_brand['primaryColour'])),
            accentColor: Color(int.parse(_brand['secondaryColour']))
          ),
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
                      partnerBrand: _partnerBrand,
                      )
                    ),

                // Show verification code page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.verification)
                  MaterialPage(child: 
                    VerificationPage(
                      didProvideVerificationCode: _authService.verifyCode,
                      partnerBrand: _partnerBrand,
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