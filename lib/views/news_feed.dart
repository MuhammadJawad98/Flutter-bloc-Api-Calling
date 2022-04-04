import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/bloc/post_bloc/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/post_model.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  final PostBloc _newsFeedBloc = PostBloc();

  @override
  void initState() {
    _newsFeedBloc.add(GetPostList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => _newsFeedBloc,
        child: BlocListener<PostBloc, PostState>(
          listener: (context, state) {
            if (state is PostLoadingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is PostLoaded) {
                return _buildCard(context, state.postModel);
              } else if (state is PostLoadingError) {
                return const Center(child: Text('Error'));
              } else {
                return const Text('Something went wrong');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context,List<Post> postModel) {
    return ListView.builder(
        itemCount: postModel.length,
        itemBuilder: (context, index) {
      return Dismissible(
        key: UniqueKey(),
        child: Card(
          child: ListTile(
            title: Text('${postModel[index].title}'),
            subtitle: Text('${postModel[index].body}'),
            trailing: Text('${postModel[index].id}'),
          ),
        ),
      );
    });
  }
}
