import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panjatan/bloc/sawal_bloc.dart';
import 'package:panjatan/repositories/sawal_repository.dart';
import 'db/local_db.dart';
import 'services/api_service.dart';
import 'screens/sawal_screen.dart';

void main() {
  final apiService = ApiService();
  final localDB = LocalDB.instance;
  final sawalRepository = SawalRepository(apiService: apiService, localDB: localDB);

  runApp(MyApp(sawalRepository: sawalRepository));
}

class MyApp extends StatelessWidget {
  final SawalRepository sawalRepository;

  const MyApp({super.key, required this.sawalRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SawalBloc(sawalRepository),
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
