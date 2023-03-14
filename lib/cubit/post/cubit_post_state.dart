part of 'cubit_post_cubit.dart';

@immutable
abstract class CubitPostState {}

// initial state
class InitPostState extends CubitPostState {}

// initial state
class LoadingPostState extends CubitPostState {}

// loaded state
class LoadedPostState extends CubitPostState {
  // definition for upload image
  final List<PostImage?> postImage;
  LoadedPostState(this.postImage);
}

// error state
class ErrorPostState extends CubitPostState {
  final String? error;
  ErrorPostState({this.error});
}
