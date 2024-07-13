import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/repositories/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  List<Post> allPosts = []; // To keep all posts and filter them

  PostBloc(this.postRepository) : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
    on<SearchPosts>(_onSearchPosts);
  }

  void _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final posts = await postRepository.fetchPosts();
      allPosts = posts; // Save all posts for filtering
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  void _onSearchPosts(SearchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final filteredPosts = allPosts
          .where((post) =>
              post.title.contains(event.query) ||
              post.body.contains(event.query))
          .toList();
      emit(PostLoaded(filteredPosts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
