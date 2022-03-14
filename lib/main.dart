import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:management/app/modules/content_entry/puja_view/views/puja_tab.dart';
import 'package:management/app/modules/content_entry/samagri_section/view/samagri_add_delete.dart';
import 'package:management/app/modules/management/view/pandit_user_details.dart';
import 'package:management/resources/app_config.dart';
import 'package:management/resources/app_exports.dart';
import 'package:management/resources/app_strings.dart';
import 'package:system_theme/system_theme.dart';
import 'app/modules/home/view/home_view.dart';
import 'app/modules/management/view/client_users_list.dart';
import 'app/modules/management/view/pandit_users_list.dart';
import 'resources/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBZ13A_jaEZIItP8ezgFVwrFDmkBJohBbk",
          authDomain: "swastik13-8242d.firebaseapp.com",
          databaseURL: "https://swastik13-8242d.firebaseio.com",
          projectId: "swastik13-8242d",
          storageBucket: "swastik13-8242d.appspot.com",
          messagingSenderId: "536545876267",
          appId: "1:536545876267:web:21154dbdb599a7b9abcd6e",
          measurementId: "G-VP4VMCWCD8"));
  if (kIsWeb || [TargetPlatform.windows, TargetPlatform.android].contains(defaultTargetPlatform)) {
    SystemTheme.accentInstance;
  }

  var configuredApp = AppConfig(
    appTitle: "Flutter Flavors Dev",
    buildFlavor: "Development",
    child: MyApp(),
  );
  return runApp(configuredApp);
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      initialRoute: '/home/${AppStrings.CONTENT_ENTRY}',
      getPages: [
        GetPage(name: '/home/:tab', page: () => HomeView(), children: [
          GetPage(
            name: '/client_users',
            page: () => ClientUserList(),
          ),
          GetPage(name: '/pandit_users', page: () => PanditUserList(), children: [
            GetPage(
              name: '/:id',
              page: () => PanditUserDetails(),
            )
          ]),
          GetPage(
            name: '/update_puja/:tab',
            page: () => AddUpdatePuja(),
          ),
        ])
      ],
    );
  }
}
