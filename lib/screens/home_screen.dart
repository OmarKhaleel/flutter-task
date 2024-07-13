import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/blocs/post_bloc/post_bloc.dart';
import 'package:flutter_task/blocs/post_bloc/post_event.dart';
import 'package:flutter_task/blocs/post_bloc/post_state.dart';
import 'package:flutter_task/components/highlight_text.dart';
import 'package:flutter_task/components/textfield.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextField(
                controller: searchController,
                hintText: 'Search',
                obscureText: false,
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(Icons.search),
                onChanged: (query) {
                  context.read<PostBloc>().add(SearchPosts(query!));
                  return null;
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is PostInitial) {
                    return const Center(child: Text('Please wait...'));
                  } else if (state is PostLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PostLoaded) {
                    final query = searchController.text;
                    return ListView.builder(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return Card(
                          child: ListTile(
                            title: RichText(
                              text: highlightText(post.title, query),
                            ),
                            subtitle: RichText(
                              text: highlightText(post.body, query),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is PostError) {
                    return Center(
                        child: Text('Failed to load posts: ${state.message}'));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
