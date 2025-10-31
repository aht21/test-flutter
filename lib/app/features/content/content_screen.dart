import 'package:flutter/material.dart';
import 'package:flutter_application/di/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/app/features/content/content_bloc.dart';

class ContentScreen extends StatefulWidget {
  final int id;

  const ContentScreen({super.key, required this.id});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late final ContentBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<ContentBloc>();
    _bloc.add(ContentLoad(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post #${widget.id}'),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<ContentBloc, ContentState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is ContentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContentLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/pic2.jpg',
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                  const SizedBox(height: 20),

                  Text(
                    state.item.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    state.item.body,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          } else if (state is ContentError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
