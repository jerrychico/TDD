import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd/core/services/injection_container.dart';
import 'package:tdd/src/Authentification/presentation/cubit/authentification_cubit.dart';
import 'package:tdd/src/Authentification/presentation/views/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthentificationCubit>(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
