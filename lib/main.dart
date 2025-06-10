import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:prankers/extensions/app_colors.dart';
import 'package:prankers/extensions/screen_size.dart';
import 'package:prankers/languages/I10n/app_localizations.dart';
import 'package:prankers/provider/MainController.dart';
import 'package:prankers/screens/ScreenSplash.dart';
import 'package:prankers/screens/premium/PremiumManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MainController());
  MobileAds.instance.initialize();
  await PremiumManager.instance.checkIfPremiumUser();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  initOneSignal();
  runApp(const Launcher());
}

void initOneSignal() async {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("6fccd530-f9ab-417c-a0ad-e36c9eb6a5a6");

  OneSignal.Notifications.requestPermission(true);
}

class Launcher extends StatefulWidget {
  const Launcher({super.key});

  @override
  State<Launcher> createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {
  RxBool isDarkMode = false.obs;

  void _updateStatusBar(BuildContext context) {
    var isDarkMode = false;
    final controller = Get.find<MainController>();

    final selectedTheme = controller.selectedTheme.value;
    if (selectedTheme == "dark") {
      isDarkMode = true;
    } else if (selectedTheme == "system") {
      final brightness = MediaQuery.of(context).platformBrightness;
      isDarkMode = brightness == Brightness.dark ? true : false;
    } else {
      isDarkMode = false;
    }
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.background(context),
        statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }

  final MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    _updateStatusBar(context);
    return ScreenUtilInit(
      designSize: Size(context.screenWidth, context.screenHeight),
      minTextAdapt: true,
      child: Obx(() {
        return GetMaterialApp(
          navigatorKey: Get.key,
          title: 'Prank App',
          locale: controller.locale,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'),
            Locale('ar'),
            Locale('fr'),
            Locale('es'),
            Locale('pt'),
            Locale('de'),
            Locale('tr'),
            Locale('nl'),
            Locale('it'),
            Locale('ru'),
            Locale('ro'),
            Locale('pt'),
            Locale('el'),
          ],
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: AppColors.background(context),
            canvasColor: AppColors.background(context),
            cardColor: AppColors.card(context),
            primaryColor: AppColors.primary(context),
            fontFamily: 'DM Sans',
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.background(context),
              foregroundColor: AppColors.text(context),
              toolbarHeight: 56.0,
              elevation: 0,
              centerTitle: false,
              titleTextStyle: TextStyle(fontFamily: 'DM Sans', fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: AppColors.background(context),
            canvasColor: AppColors.background(context),
            cardColor: AppColors.card(context),
            primaryColor: AppColors.primary(context),
            fontFamily: 'DM Sans',
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.background(context),
              foregroundColor: AppColors.text(context),
              centerTitle: false,
              titleTextStyle: TextStyle(fontFamily: 'DM Sans', fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
          themeMode: controller.selectedTheme.value == "light"
              ? ThemeMode.light
              : controller.selectedTheme.value == "dark"
              ? ThemeMode.dark
              : ThemeMode.system,
          home: const ScreenSplash(),
        );
      }),
    );
  }
}
