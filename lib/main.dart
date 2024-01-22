import 'package:amaclone/auth_service.dart';
import 'package:amaclone/common/widgets/navbar.dart';
import 'package:amaclone/constants/global_variables.dart';
import 'package:amaclone/features/admin/screens/admin_screen.dart';
import 'package:amaclone/features/authentication/screens/auth_screen.dart';
import 'package:amaclone/provider/user_provider.dart';
import 'package:amaclone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    authService.getUserData(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // takes care of generating routes for us
        onGenerateRoute: (settings) => generateRoute(settings),
        title: GlobalVariables.appName,
        theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            primarySwatch: Colors.blue,
            colorScheme: const ColorScheme.light(
              primary: GlobalVariables.secondaryColor,
            ),
            appBarTheme: const AppBarTheme(
                elevation: 0, iconTheme: IconThemeData(color: Colors.black))),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? Provider.of<UserProvider>(context).user.type == 'user'
                ? const Navbar()
                : const AdminScreen()
            : const AuthScreen());
  }
}
