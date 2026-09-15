import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:daryo/data/datasource/network/constants/constants.dart';
import 'package:daryo/data/datasource/preference/auth_preferences.dart';
import 'package:daryo/data/datasource/preference/user_preferences.dart';
import 'package:daryo/data/repositories/auth_repository.dart';
import 'package:daryo/presentation/features/auth/start/auth_launch_type.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/data/datasource/preference/language_preferences.dart';
import 'package:daryo/data/datasource/preference/theme_mode_preferences.dart';
import 'package:daryo/domain/models/theme/app_theme_mode.dart';
import 'package:daryo/presentation/application/di/get_it_injection.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/stream_controllers/app_theme_mode_stream_controller.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/support/state_message/state_message.dart';
import 'package:daryo/presentation/support/state_message/state_message_manager.dart';
import 'package:daryo/presentation/support/state_message/state_snack_bar_exts.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import '../features/auth/splash/splash_demo.dart';
import '../support/firebase/firebase_notification_service.dart';
import '../support/version_control/forse_update.dart';
import '../support/version_control/update.dart';
import '../support/version_control/version_control.dart';

class Application extends StatefulWidget {
  const Application({
    super.key,
  });

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final AppThemeModeStreamController appThemeModeStreamController = getIt.get();

  final ThemeModePreferences _themeModePreferences = getIt.get();
  final LanguagePreferences _languagePreferences = getIt.get();
  final UserPreferences _userPreferences=getIt.get();
  final AuthRepository _authRepository=getIt.get();
  final updater = ShorebirdUpdater();

  late ThemeMode _themeMode;
  StreamSubscription<AppThemeMode>? _themeSubscription;

  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    _themeMode = _themeModePreferences.appThemeMode.themeMode;
    _themeSubscription = appThemeModeStreamController.listen((event) {
      setState(() {
        _themeMode = event.themeMode;
      });
    });
    updater.readCurrentPatch().then((currentPatch) {
      Logger().w("The current patch number is: ${currentPatch?.number}");
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForUpdates();
      _checkAppVersion();
      _sendFCMToken();
    });
  }

  @override
  void dispose() {
    _themeSubscription?.cancel();
    super.dispose();
  }


  Future<void> _checkForUpdates() async {
    final status = await updater.checkForUpdate();
    Logger().w("statusCheckForUpdates $status");
    print("statusCheckForUpdates");
    if (status == UpdateStatus.outdated) {
      try {
        // Perform the update
        Logger().w(" // Perform the update");
        print("// Perform the update");
        await updater.update();
      } on UpdateException catch (error) {
        print("// Handle any errors that occur while updating");
        Logger().e(" // Handle any errors that occur while updating");
      }
    }
  }

  Future<void> _sendFCMToken() async{
    final token= await FirebaseApi().getFcmToken()??"";
    final oldToken=_userPreferences.fcmToken;
    if(token!=""){
      if(token==oldToken){
        Logger().w("old token");
      }else{
        /// call
         _authRepository.setFCMToken(token);
        _userPreferences.setFCMToken(token);
      }
    }
    Logger().w("ajsdncsd $token");
  }




  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkMode ? StaticColors.darkBackground : Colors.transparent,
      systemNavigationBarColor: isDarkMode ? StaticColors.darkBackground : context.appBarColor,
      statusBarIconBrightness: isDarkMode ? Brightness.dark : Brightness.light,
    ));
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Stack(
          children: [
            MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  elevation: 0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  scrolledUnderElevation: 0,
                  backgroundColor: Colors.white,
                ),
                fontFamily: 'Inter',
                useMaterial3: false,
                primaryColor: Color(0xFF3f9cfb),
                colorScheme: _getLightModeColorScheme(),
              ),
              darkTheme: ThemeData(
                fontFamily: 'Inter',
                useMaterial3: false,
                brightness: Brightness.dark,
                colorScheme: _getDarkModeColorScheme(),
              ),
              themeMode: _themeMode,
              routerConfig: _appRouter.config(
                deepLinkBuilder: (_) => DeepLink(
                 [SplashRoute()]),
                navigatorObservers: () => [],
              ),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
            ),
            Builder(
              builder: (context) {
                _initStateMessageManager(context);
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkAppVersion() async {
    try {
      final versionService = VersionService();
      final version = await versionService.getAppVersion();

      if (version != null) {
        debugPrint('Current version: ${version.currentVersion}');
        debugPrint('Min version: ${version.minVersion}');
        debugPrint('Current dwcadcido');
        int minVersion=versionStringToInt(version.minVersion);
        int currentVersion=versionStringToInt(version.currentVersion);
        if((Constants.appVersion<currentVersion)&&(Constants.appVersion>=minVersion)){
          final ctx = _appRouter.navigatorKey.currentContext;
          if (ctx != null){
            showDialog(
              context: ctx,
              barrierColor: Colors.black54,
              builder: (_) => const UpdateDialog(),
            );
          }
        }
        if(Constants.appVersion<minVersion){
          final ctx = _appRouter.navigatorKey.currentContext;
          if (ctx != null){
            showDialog(
              context: ctx,
              barrierDismissible:false,
              barrierColor: Colors.black87,
              builder: (_) => const ForceUpdateDialog(),
            );
          }
        }
      } else {
        debugPrint('Versiya maʼlumoti olinmadi');
      }
    } catch (e) {
      debugPrint('Versiya tekshirishda xatolik: $e');
    }
  }

  int versionStringToInt(String version) {
    List<String> parts = version.split('.');

    int major = int.parse(parts[0]);
    int minor = int.parse(parts[1]);
    int patch = int.parse(parts[2]);

    return major * 100 + minor * 10 + patch;
  }

  void _initStateMessageManager(BuildContext context) {
    final stateMessageManager = getIt<StateMessageManager>();

    stateMessageManager.setListeners(
      onShowBottomSheet: (m) => showStateMessageBottomSheet(context, m),
      onShowSnackBar: (m) => context.showStateMessageSnackBar(m),
    );
  }

  ColorScheme _getLightModeColorScheme() {
    return ColorScheme.fromSwatch(brightness: Brightness.light).copyWith(
      primary: Color(0xFF3f9cfb),
      secondary: Color(0xFFFFFFFF),
      background: Color(0xFFFFFFFF),
      onBackground: Color(0xFF000000),
      surface: Color(0xFFF3F3F3),
      onSurface: Color(0xFF000000),
    );
    // return ColorScheme(
    //   brightness: Brightness.light,
    //   // The overall brightness of the theme
    //   primary: Color(0xFF5C6AC4),
    //   // Project main color, used for primary elements like app bar, buttons
    //   onPrimary: Color(0xFFFFFFFF),
    //   // Color used for text/icons on primary elements
    //   secondary: Color(0xFFFFFFFF),
    //   // Project light mode background color, used for accents
    //   onSecondary: Color(0xFF41455F),
    //   // Color used for text/icons on secondary elements
    //   primaryContainer: Color(0xFFDFE2E9),
    //   // A lighter variant of primary, for container backgrounds
    //   onPrimaryContainer: Color(0xFF000000),
    //   // Color used for text/icons on primary container
    //   secondaryContainer: Color(0xFFB3E5FC),
    //   // A lighter variant of secondary, for container backgrounds
    //   onSecondaryContainer: Color(0xFF000000),
    //   // Color used for text/icons on secondary container
    //   error: Color(0xFFB00020),
    //   // Color used for error elements like form errors
    //   onError: Color(0xFFFFFFFF),
    //   // Color used for text/icons on error elements
    //   background: Color(0xFFFFFFFF),
    //   // General background color for the app
    //   onBackground: Color(0xFF000000),
    //   // Color used for text/icons on background
    //   surface: Color(0xFFF3F3F3),
    //   // Color used for surfaces like cards, sheets, etc.
    //   onSurface: Color(0xFF000000),
    //   // Color used for text/icons on surfaces
    // );
  }

  ColorScheme _getDarkModeColorScheme() {
    return ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
      primary: Color(0xFF3f9cfb),
      secondary: Color(0xFF000000),
      background: Color(0xFF121212),
      onBackground: Color(0xFFE0E0E0),
      surface: Color(0xFF333333),
      onSurface: Color(0xFFE0E0E0),
    );
    // return ColorScheme(
    //   brightness: Brightness.dark,
    //   // The overall brightness of the theme
    //   primary: Color(0xFF5C6AC4),
    //   // Project main color, used for primary elements like app bar, buttons
    //   onPrimary: Color(0xFFDFE2E9),
    //   // Color used for text/icons on primary elements
    //   secondary: Color(0xFF000000),
    //   // Project light mode background color, used for accents
    //   onSecondary: Color(0xFF41455F),
    //   // Color used for text/icons on secondary elements
    //   primaryContainer: Color(0xAB121212),
    //   // A lighter variant of primary, for container backgrounds
    //   onPrimaryContainer: Color(0xFFDFE2E9),
    //   // Color used for text/icons on primary container
    //   secondaryContainer: Color(0xFF404A80),
    //   // A lighter variant of secondary, for container backgrounds
    //   onSecondaryContainer: Color(0xFFDFE2E9),
    //   // Color used for text/icons on secondary container
    //   error: Color(0xFFCF6679),
    //   // Color used for error elements like form errors
    //   onError: Color(0xFF000000),
    //   // Color used for text/icons on error elements
    //   background: Color(0xFF121212),
    //   // General background color for the app
    //   onBackground: Color(0xFFE0E0E0),
    //   // Color used for text/icons on background
    //   surface: Color(0xFF333333),
    //   // Color used for surfaces like cards, sheets, etc.
    //   onSurface: Color(0xFFE0E0E0),
    //   // Color used for text/icons on surfaces
    // );
  }

  void showStateMessageBottomSheet(BuildContext context, StateMessage message) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return Material(
          color: context.bottomSheetColor,
          child: Container(
            color: context.bottomSheetColor,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30),
                Center(child: message.titleOrDefault.s(22).w(600)),
                SizedBox(height: 14),
                message.message.s(16).w(500).c(context.isDarkMode? Colors.yellow:context.textPrimary).copyWith(
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                SizedBox(height: 32),
                CustomElevatedButton(
                  text: Strings.closeTitle,
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.pop(buildContext);
                  },
                  backgroundColor: context.colors.buttonPrimary,
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
