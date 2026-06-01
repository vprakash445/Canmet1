import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'utils/app_theme.dart';
import 'utils/providers.dart';
import 'screens/login_screen.dart';
import 'screens/main_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  final langProvider = LanguageProvider();
  final userProvider = UserProvider();
  await langProvider.init();
  await userProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: langProvider),
        ChangeNotifierProvider.value(value: userProvider),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const CanmetApp(),
    ),
  );
}

class CanmetApp extends StatelessWidget {
  const CanmetApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();

    return MaterialApp(
      title: 'CANMET',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: user.isLoggedIn ? const MainShell() : const LoginScreen(),
    );
  }
}
