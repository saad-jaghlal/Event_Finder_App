
// import 'package:event_finder_app/core/theme/theme.dart';
import 'package:event_finder_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:event_finder_app/features/auth/presentation/pages/sign_in/sign_in_screen.dart';
import 'package:event_finder_app/init_dependencies.dart';
import 'package:flutter/material.dart';

import 'package:event_finder_app/features/auth/presentation/widget/routes.dart';
import 'package:event_finder_app/features/auth/presentation/widget/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyMain();
  }
}

class MyMain extends StatefulWidget {
  const MyMain({super.key});

  @override
  State<MyMain> createState() => _MyMainState();
}

class _MyMainState extends State<MyMain> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: AppTheme.lightThemeMode,
      theme: AppThemes.lightTheme(context),
      // ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      // home: const SignInScreen(),
      initialRoute: SignInScreen.routeName,
      routes: routes,
    );
  }
}
