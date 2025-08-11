import 'package:flutter/material.dart';
import 'package:plano_a_dois/goals/widgets/goal_card.dart';
import 'package:plano_a_dois/goals/create_edit_goal_screen.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  // Dados de exemplo com URLs corrigidas
  final List<Map<String, dynamic>> _goals = [
    {
      'title': 'Viagem para a Europa',
      'currentAmount': 12000.0,
      'targetAmount': 20000.0,
      'imageUrl': 'https://picsum.photos/seed/europa/800/600', // URL CORRIGIDA
    },
    {
      'title': 'Reserva de Emergência',
      'currentAmount': 4500.0,
      'targetAmount': 5000.0,
      'imageUrl': 'https://picsum.photos/seed/savings/800/600', // URL CORRIGIDA
    }
  ];

  void _navigateToCreateGoal() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const CreateEditGoalScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metas e Objetivos'),
        backgroundColor: const Color(0xfff1f5f9),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _goals.length,
        itemBuilder: (context, index) {
          final goal = _goals[index];
          return GoalCard(
            title: goal['title'],
            currentAmount: goal['currentAmount'],
            targetAmount: goal['targetAmount'],
            imageUrl: goal['imageUrl'],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreateGoal,
        backgroundColor: const Color(0xff4f46e5),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      backgroundColor: const Color(0xfff1f5f9),
    );
  }
}