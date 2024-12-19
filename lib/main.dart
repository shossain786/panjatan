import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panjatan/bloc/sawal_bloc.dart';
import 'db/local_db.dart';
import 'services/api_service.dart';
import 'screens/sawal_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SawalBloc(ApiService(), LocalDB.instance),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: SawalScreen(),
      ),
    );
  }
}
