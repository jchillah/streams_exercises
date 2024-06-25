import 'package:flutter/material.dart';
import 'package:streams_exercises/features/numbers/number_repository.dart';

class NumberScreen extends StatelessWidget {
  NumberScreen({
    super.key,
    required this.numberRepository,
  });

  final NumberRepository numberRepository;

  final Stream<int> numbers = NumberRepository().getNumberStream();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Screen'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: numbers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Icon(Icons.error);
            } else if (snapshot.hasData) {
              final numbers = snapshot.data;

              return Text('Nummern: $numbers');
            } else {
              return const Icon(Icons.error);
            }
          },
        ),
      ),
    );
  }
}
