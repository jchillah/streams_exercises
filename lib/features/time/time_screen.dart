import 'package:flutter/material.dart';
import 'package:streams_exercises/features/time/time_repository.dart';

class TimeScreen extends StatelessWidget {
  TimeScreen({
    super.key,
    required this.timeRepository,
  });

  final TimeRepository timeRepository;
  final Stream<DateTime> time = TimeRepository().dateTimeStream;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Screen'),
      ),
      body: Center(
        child: StreamBuilder<DateTime>(
          stream: time,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Icon(Icons.error);
            } else if (snapshot.hasData) {
              final time = snapshot.data;

              return Text('Zeit: $time');
            } else {
              return const Icon(Icons.error);
            }
          },
        ),
      ),
    );
  }
}
