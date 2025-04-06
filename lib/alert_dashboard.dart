import 'package:flutter/material.dart';

class AlertDashboard extends StatelessWidget {
  final Map<String, double> moodData;

  const AlertDashboard({super.key, required this.moodData});

  String getMoodLabel(double score) {
    if (score >= 3.5) return "Happy";
    if (score >= 2.0) return "Neutral";
    if (score >= 1.0) return "Sad";
    return "Very Sad";
  }

  @override
  Widget build(BuildContext context) {
    final alerts =
        moodData.entries.where((entry) => entry.value < 2.0).map((entry) {
      String mood = getMoodLabel(entry.value);
      return "⚠️ On ${entry.key}, your child felt $mood.";
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Alerts"),
        backgroundColor: Colors.redAccent,
      ),
      body: alerts.isEmpty
          ? const Center(
              child: Text(
                "🎉 No alerts. Your child seems fine!",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: alerts.length,
              itemBuilder: (context, index) => Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.warning, color: Colors.red),
                  title: Text(alerts[index]),
                ),
              ),
            ),
    );
  }
}
