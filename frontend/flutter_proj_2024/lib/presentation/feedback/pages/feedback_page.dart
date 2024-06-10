import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/feedback/bloc/feedback_bloc.dart';
import 'package:flutter_proj_2024/application/feedback/bloc/feedback_event.dart';
import 'package:flutter_proj_2024/infrastructure/feedback/repositories/feedback_repository_impl.dart';
import 'package:flutter_proj_2024/infrastructure/feedback/data_sources/feedback_remote_data_source.dart';
import 'package:flutter_proj_2024/presentation/feedback/widgets/appbar.dart';
import 'package:flutter_proj_2024/presentation/feedback/widgets/drawer.dart';
import 'package:flutter_proj_2024/presentation/feedback/widgets/feedback_form.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final feedbackRemoteDataSource = FeedbackRemoteDataSource();
    final feedbackRepository = FeedbackRepositoryImpl(remoteDataSource: feedbackRemoteDataSource);

    return Scaffold(
      appBar: AppAppBar(),
      drawer: AppDrawer(),
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      body: BlocProvider(
        create: (context) => FeedbackBloc(feedbackRepository: feedbackRepository)..add(LoadFeedbackEvent()),
        child: FeedbackForm(),
      ),
    );
  }
}
