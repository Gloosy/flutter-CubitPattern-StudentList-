
part of 'update_cubit.dart';

@immutable
abstract class UpdateState {}

// initial state
class InitUpdateState extends UpdateState {}

// initial state
class LoadingUpdateState extends UpdateState {}

// loaded state
class LoadedUpdateState extends UpdateState {
  // definition for upload image
  final List<UpdateInfo?> postImage;
  LoadedUpdateState(this.postImage);
}

// error state
class ErrorUpdateState extends UpdateState {
  final String? error;
  ErrorUpdateState({this.error});
}
