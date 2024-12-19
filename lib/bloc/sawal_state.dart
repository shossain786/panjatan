import '../models/sawal_model.dart';

abstract class SawalState {}

class SawalInitial extends SawalState {}

class SawalLoading extends SawalState {}

class SawalLoaded extends SawalState {
  final List<SawalModel> sawals;

  SawalLoaded(this.sawals);
}

class SawalError extends SawalState {
  final String message;

  SawalError(this.message);
}
