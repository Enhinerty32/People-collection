import 'package:flutter/material.dart';

import '../models/user_model.dart';

class SleepPatternWidget extends StatelessWidget {
  final SleepPattern sleepPattern;

  const SleepPatternWidget({super.key, required this.sleepPattern});

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildSleepInfoCard('Despertar', formatDateTime(sleepPattern.wakeUp)),
          _buildSleepInfoCard('Hora de dormir', formatDateTime(sleepPattern.sleepTime)),
          _buildSleepInfoCard('Duración del sueño', '${sleepPattern.sleepDuration} hours'),
          _buildSleepInfoCard('Pico de energía', formatDateTime(sleepPattern.energyPeak)),
          _buildSleepInfoCard('Pico de cansancio', formatDateTime(sleepPattern.tirednessPeak)),
        ],
      ),
    );
  }

  Widget _buildSleepInfoCard(String title, String value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(
          Icons.access_alarm,
          color: Colors.deepPurple,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: Text(
          value,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple),
        ),
      ),
    );
  }
}
