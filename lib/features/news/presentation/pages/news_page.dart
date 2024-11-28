import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/route_aware.dart';
import '../../../../core/utils/transition.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/news_bloc.dart';
import '../widgets/message_display_widget.dart';
import '../widgets/news_list_widget.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with RouteAware {
  TransitionType _currentTransition = TransitionType.fade;
  AppBar _buildAppBar() => AppBar(
        title: const Text('News'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton<TransitionType>(
            onSelected: (type) {
              setState(() {
                _currentTransition = type;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: TransitionType.fade,
                child: Text("Fade"),
              ),
              const PopupMenuItem(
                value: TransitionType.scale,
                child: Text("Scale"),
              ),
              const PopupMenuItem(
                value: TransitionType.slide,
                child: Text("Slide"),
              ),
            ],
          ),
        ],
      );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
  }

  @override
  void didPush() {
    BlocProvider.of<NewsBloc>(context).add(RefreshNewsEvent());
    super.didPush();
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is LoadingNewsState) {
            return const LoadingWidget();
          } else if (state is LoadedNewsState) {
            return NewsListWidget(
                news: state.news, transitionType: _currentTransition);
          } else if (state is ErrorNewsState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }
}
