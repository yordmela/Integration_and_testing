import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/feedback/bloc/feedback_bloc.dart';
import 'package:flutter_proj_2024/application/feedback/bloc/feedback_event.dart';
import 'package:flutter_proj_2024/application/feedback/bloc/feedback_state.dart';
import 'package:flutter_proj_2024/domain/feedback/entities/feedback.dart' as CustomFeedback;

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _messageController,
            decoration: InputDecoration(labelText: 'Message'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a message';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          Text(
            'Rate our service:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.sentiment_very_dissatisfied),
                color: _rating == 1 ? Colors.red : null,
                onPressed: () {
                  setState(() {
                    _rating = 1;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.sentiment_dissatisfied),
                color: _rating == 2 ? Colors.orange : null,
                onPressed: () {
                  setState(() {
                    _rating = 2;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.sentiment_neutral),
                color: _rating == 3 ? Colors.yellow : null,
                onPressed: () {
                  setState(() {
                    _rating = 3;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.sentiment_satisfied),
                color: _rating == 4 ? Colors.lightGreen : null,
                onPressed: () {
                  setState(() {
                    _rating = 4;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.sentiment_very_satisfied),
                color: _rating == 5 ? Colors.green : null,
                onPressed: () {
                  setState(() {
                    _rating = 5;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                final feedback = CustomFeedback.Feedback(
                  id: '',
                  customerName: _nameController.text,
                  message: _messageController.text,
                  rating: _rating,
                  createdAt: DateTime.now(),
                );

                BlocProvider.of<FeedbackBloc>(context).add(
                  SubmitFeedbackEvent(feedback),
                );
              }
            },
            child: Text('Submit Feedback'),
          ),
          BlocBuilder<FeedbackBloc, FeedbackState>(
            builder: (context, state) {
              if (state is FeedbackLoading) {
                return CircularProgressIndicator();
              } else if (state is FeedbackLoadSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.feedbackList.length,
                    itemBuilder: (context, index) {
                      final feedback = state.feedbackList[index];
                      return ListTile(
                        title: Text(feedback.customerName),
                        subtitle: Text(
                          'Message: ${feedback.message}\nCreated at: ${feedback.createdAt}\nRating: ${feedback.rating}',
                        ),
                      );
                    },
                  ),
                );
              } else if (state is FeedbackFailure) {
                return Text('Failed to load feedback: ${state.message}');
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
