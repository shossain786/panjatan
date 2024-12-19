import '../models/sawal_model.dart';
import '../services/api_service.dart';
import '../db/local_db.dart';

class SawalRepository {
  final ApiService apiService;
  final LocalDB localDB;

  SawalRepository({
    required this.apiService,
    required this.localDB,
  });

  /// Fetch data from the local database
  Future<List<SawalModel>> fetchFromLocalDB() async {
    return await localDB.fetchAllSawals();
  }

  /// Fetch data from the API and store it in the local database
  Future<void> syncData() async {
    final sawals = await apiService.fetchSawals();
    for (var sawal in sawals) {
      await localDB.insertSawal(sawal);
    }
  }
}
