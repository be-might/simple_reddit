import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_reddit/core/resources/colors.dart';
import 'package:simple_reddit/domain/entities/post.dart';
import 'package:simple_reddit/injector.dart';
import 'package:simple_reddit/presentation/main/home/cubit/home_cubit.dart';
import 'package:simple_reddit/presentation/view/text.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector.get<HomeCubit>()
        ..getPosts(), //TODO Why we need to use underscore in params and ..
      child: Builder(
        builder: (context) {
          return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            if (state.topPosts.isNotEmpty) {
              return ListView.builder(
                  itemCount: state.topPosts.length,
                  itemBuilder: (context, index) {
                    return PostCard(state.topPosts[index]);
                  });
            } else
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      // height: 300,
                      // child: DecoratedBox(
                      //   decoration: BoxDecoration(
                      //       border: Border.all(color: Colors.black)),
                      // ),
                      ),
                ),
              );
          });
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  Post _post;

  PostCard(this._post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.ac_unit,
                        size: 20.0,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            TextBold("r/${_post.subreddit}", 12, RColors.Black),
                            TextRegular(
                                ' • Posted by u/${_post.author_fullname}',
                                12,
                                RColors.Grey),
                          ],
                        ),
                        
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Text(_post.title),
        ],
      ),
    );
  }
}
