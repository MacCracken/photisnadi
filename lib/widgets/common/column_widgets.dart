import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../models/board.dart';
import '../../models/project.dart';
import '../../models/task.dart';
import '../../services/task_service.dart';
import '../../common/constants.dart';
import 'common_widgets.dart';

class ColumnHeader extends StatelessWidget {
  final BoardColumn column;
  final Color color;
  final int totalCount;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ColumnHeader({
    super.key,
    required this.column,
    required this.color,
    required this.totalCount,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.headerPadding),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppConstants.borderRadiusLarge),
          topRight: Radius.circular(AppConstants.borderRadiusLarge),
        ),
      ),
      child: Row(
        children: [
          ReorderableDragStartListener(
            index: column.order,
            child: Icon(Icons.drag_handle,
                color: color, size: AppConstants.iconSizeLarge),
          ),
          const SizedBox(width: AppConstants.smallPadding),
          Expanded(
            child: Text(
              column.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: AppConstants.smallPadding),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.smallPadding,
              vertical: AppConstants.tinyPadding,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$totalCount',
              style: TextStyle(
                fontSize: AppConstants.taskKeyFontSize,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          EditDeleteMenu(
            onSelected: (value) {
              if (value == 'edit') {
                onEdit();
              } else if (value == 'delete') {
                onDelete();
              }
            },
          ),
        ],
      ),
    );
  }
}

void showEditColumnDialog(
  BuildContext context,
  Project project,
  BoardColumn column,
) {
  final titleController = TextEditingController(text: column.title);
  TaskStatus selectedStatus = column.status;
  String selectedColor = column.color;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('Edit Column'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Column Name',
              ),
            ),
            const SizedBox(height: AppConstants.headerPadding),
            DropdownButtonFormField<TaskStatus>(
              initialValue: selectedStatus,
              decoration: const InputDecoration(labelText: 'Status'),
              items: TaskStatus.values.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status.name),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedStatus = value);
                }
              },
            ),
            const SizedBox(height: AppConstants.headerPadding),
            ColorPicker(
              selectedColor: selectedColor,
              onColorSelected: (color) => setState(() => selectedColor = color),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final updatedColumn = column.copyWith(
                  title: titleController.text,
                  status: selectedStatus,
                  color: selectedColor,
                );
                context
                    .read<TaskService>()
                    .updateColumn(project.id, updatedColumn);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ),
  );
}

void showDeleteColumnDialog(
  BuildContext context,
  Project project,
  BoardColumn column,
) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete Column'),
      content: Text(
          'Are you sure you want to delete "${column.title}"? Tasks in this column will need to be moved to another column.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            context.read<TaskService>().deleteColumn(project.id, column.id);
            Navigator.pop(context);
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}

void showAddColumnDialog(
  BuildContext context,
  Project project,
) {
  final titleController = TextEditingController();
  TaskStatus selectedStatus = TaskStatus.todo;
  String selectedColor = '#6B7280';

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('Add Column'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Column Name',
                hintText: 'e.g., In Review',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TaskStatus>(
              initialValue: selectedStatus,
              decoration: const InputDecoration(labelText: 'Status'),
              items: TaskStatus.values.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status.name),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedStatus = value);
                }
              },
            ),
            const SizedBox(height: 16),
            ColorPicker(
              selectedColor: selectedColor,
              onColorSelected: (color) => setState(() => selectedColor = color),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final column = BoardColumn(
                  id: const Uuid().v4(),
                  title: titleController.text,
                  status: selectedStatus,
                  color: selectedColor,
                );
                context.read<TaskService>().addColumn(project.id, column);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    ),
  );
}
