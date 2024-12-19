import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/sawal_repository.dart';
import 'sawal_event.dart';
import 'sawal_state.dart';

class SawalBloc extends Bloc<SawalEvent, SawalState> {
  final SawalRepository sawalRepository;

  SawalBloc(this.sawalRepository) : super(SawalInitial()) {
    on<FetchSawals>(_onFetchSawals);
    on<SyncSawals>(_onSyncSawals);
  }

  Future<void> _onFetchSawals(FetchSawals event, Emitter<SawalState> emit) async {
    emit(SawalLoading());
    try {
      final sawals = await sawalRepository.fetchFromLocalDB();
      emit(SawalLoaded(sawals));
    } catch (e) {
      emit(SawalError('Failed to load data'));
    }
  }

  Future<void> _onSyncSawals(SyncSawals event, Emitter<SawalState> emit) async {
    emit(SawalLoading());
    try {
      await sawalRepository.syncData();
      add(FetchSawals());
    } catch (e) {
      emit(SawalError('Failed to sync data'));
    }
  }
}
