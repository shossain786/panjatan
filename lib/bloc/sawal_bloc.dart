import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/api_service.dart';
import '../db/local_db.dart';
import 'sawal_event.dart';
import 'sawal_state.dart';

class SawalBloc extends Bloc<SawalEvent, SawalState> {
  final ApiService apiService;
  final LocalDB localDB;

  SawalBloc(this.apiService, this.localDB) : super(SawalInitial()) {
    on<FetchSawals>(_onFetchSawals);
    on<SyncSawals>(_onSyncSawals);
  }

  Future<void> _onFetchSawals(FetchSawals event, Emitter<SawalState> emit) async {
    emit(SawalLoading());
    try {
      final sawals = await localDB.fetchAllSawals();
      emit(SawalLoaded(sawals));
    } catch (e) {
      emit(SawalError('Failed to load data'));
    }
  }

  Future<void> _onSyncSawals(SyncSawals event, Emitter<SawalState> emit) async {
    emit(SawalLoading());
    try {
      final sawals = await apiService.fetchSawals();
      for (var sawal in sawals) {
        await localDB.insertSawal(sawal);
      }
      add(FetchSawals());
    } catch (e) {
      emit(SawalError('Failed to sync data'));
    }
  }
}
