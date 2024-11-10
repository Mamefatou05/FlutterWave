import 'package:flutter/material.dart';

import '../../models/CreateClient.dart';
import '../../models/NotificationTypeModel.dart';

class NotificationTypeSelector extends StatelessWidget {
  final NotificationType selectedType;
  final ValueChanged<NotificationType> onChanged;

  const NotificationTypeSelector({
    Key? key,
    required this.selectedType,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Type de notification',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            RadioListTile<NotificationType>(
              title: const Text('SMS'),
              value: NotificationType.SMS,
              groupValue: selectedType,
              onChanged: (value) => onChanged(value!),
            ),
            RadioListTile<NotificationType>(
              title: const Text('Email'),
              value: NotificationType.EMAIL,
              groupValue: selectedType,
              onChanged: (value) => onChanged(value!),
            ),

          ],
        ),
      ),
    );
  }
}