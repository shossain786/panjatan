import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panjatan/bloc/sawal_bloc.dart';
import 'package:panjatan/bloc/sawal_event.dart';
import 'package:panjatan/bloc/sawal_state.dart';
import '../widgets/animated_card.dart';

class SawalScreen extends StatelessWidget {
  const SawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sawal o Jawab'),
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () {
              context.read<SawalBloc>().add(SyncSawals());
            },
          ),
        ],
      ),
      body: BlocBuilder<SawalBloc, SawalState>(
        builder: (context, state) {
          if (state is SawalLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SawalLoaded) {
            return ListView.builder(
              itemCount: state.sawals.length,
              itemBuilder: (context, index) {
                final sawal = state.sawals[index];
                return AnimatedCard(
                  content: sawal.content,
                  category: sawal.category,
                  date: sawal.date,
                );
              },
            );
          } else if (state is SawalError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
