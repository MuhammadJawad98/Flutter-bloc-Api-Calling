part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostLoading extends PostState {}
class PostLoaded extends PostState {
  final List<Post> postModel;
  const PostLoaded(this.postModel);
}
class PostLoadingError extends PostState {
  final String? message;
  const PostLoadingError(this.message);
}
