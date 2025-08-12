import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scan_sa_user/app/presentation/main_screens/main_app.dart';
import 'package:scan_sa_user/helper/get_di.dart';
import 'package:scan_sa_user/l10n/locale.dart';

Future<void> main() async {
  /// Ensure that Flutter bindings are initialized
  /// This is necessary for plugins that require platform channels
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Hive for local storage
  /// Ensure that the path_provider package is used to get the application documents directory
  // final appDocumentDirectory = await getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDirectory.path);

  if (GetPlatform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCJ5fHpupJKww00L4_rVtXu0F7_CyAcnjQ',
        appId: '1:221589331538:android:c5d6b2f89344124bfa498b',
        messagingSenderId: '221589331538',
        projectId: 'scan-sa',
        storageBucket: 'scan-sa.firebasestorage.app',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  /// Set the preferred orientations for the app
  /// This restricts the app to portrait mode only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// init all controller and repository
  await getDiInit();

  /// to init get storage
  await GetStorage.init();

  /// to init localization
  await LocalizationService.loadTranslations();

  /// run the app with MultiProvider
  /// to provide the GlobalProvider to the widget tree
  runApp(const MyApp());
}
