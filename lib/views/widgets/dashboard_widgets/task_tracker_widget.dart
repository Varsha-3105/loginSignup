import 'package:flutter/material.dart';
import 'package:task2/constants/app_colors.dart';

class TaskTrackerWidget extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;
  const TaskTrackerWidget({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return buildTaskDetailCard(tasks[index], isFirst: index == 0);
      },
    );
  }
}

Widget buildTaskDetailCard(Map<String, dynamic> task, {bool isFirst = false}) {
  Color getStatusColor(String status) {
    switch (status) {
      case "Not Started": return AppColors.statusNotStarted;
      case "In Progress": return AppColors.statusNotStarted;
      case "Completed": return AppColors.statusCompleted;
      case "Overdue": return AppColors.statusOverdue;
      default: return AppColors.statusNotStarted;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "Low": return AppColors.priorityLow;
      case "Medium": return isFirst ? AppColors.orange : AppColors.priorityMedium;
      case "High": return AppColors.priorityHigh;
      default: return AppColors.priorityLow;
    }
  }

  Widget progressRow = isFirst
      ? Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    value: task["progress"] / 100,
                    backgroundColor: AppColors.progressBackground,
                    color: AppColors.progressValue,
                    strokeWidth: 3,
                  ),
                ),
                Text('${task["progress"]}%', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                Icon(Icons.access_time, color: AppColors.orange, size: 16),
                const SizedBox(width: 2),
                Text(
                  '2 days remaining',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.orange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            if (task["assignedBy"] != null)
              Row(
                children: [
                  Icon(Icons.assignment_ind, size: 14, color: AppColors.grey),
                  const SizedBox(width: 5),
                  Text(
                    'Assigned By (optional)',
                    style: TextStyle(fontSize: 12, color: AppColors.grey),
                  ),
                ],
              ),
          ],
        )
      : Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    value: task["progress"] / 100,
                    backgroundColor: AppColors.progressBackground,
                    color: AppColors.progressValue,
                    strokeWidth: 3,
                  ),
                ),
                Text('${task["progress"]}%', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(width: 10),
            Text(
              task["status"] == "Completed" ? "" : (task["progress"] < 100 ? "${100 - task["progress"]} days remaining" : ""),
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textWarning,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (task["assignedBy"] != null)
              Row(
                children: [
                  Icon(Icons.assignment_ind, size: 14, color: AppColors.grey),
                  const SizedBox(width: 5),
                  Text(
                    'Assigned By (optional)',
                    style: TextStyle(fontSize: 12, color: AppColors.grey),
                  ),
                ],
              ),
          ],
        );

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: AppColors.greyWithOpacity1,
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Task Title and Due Date
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              task["title"]!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.statusCompleted, 
              ),
            ),
            Text(
              'Due Date: ${task["dueDate"]}',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Status
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text("Status: ", style: TextStyle(fontSize: 12, color: AppColors.grey)),
              // Add status indicators here as needed
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Progress, Days Remaining, Assigned By
        progressRow,
        const SizedBox(height: 10),
        // Priority
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text("Priority: ", style: TextStyle(fontSize: 12, color: AppColors.grey)),
              Text("Low", style: TextStyle(fontSize: 12, color: AppColors.priorityLow, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text("Medium", style: TextStyle(fontSize: 12, color: getPriorityColor("Medium"), fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text("High", style: TextStyle(fontSize: 12, color: AppColors.priorityHigh, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Actions
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: "Start",
                  groupValue: null,  
                  onChanged: null,
                  activeColor: isFirst ? AppColors.green : AppColors.blueAccent,
                  fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (isFirst) return AppColors.green;
                    return AppColors.blueAccent;
                  }),
                ),
                Text("Start", style: TextStyle(fontSize: 10, color: AppColors.black)),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: "Update",
                  groupValue: null,  
                  onChanged: null,
                  activeColor: isFirst ? AppColors.black : AppColors.blueAccent,
                  fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (isFirst) return AppColors.black;
                    return AppColors.blueAccent;
                  }),
                ),
                Text("Update", style: TextStyle(fontSize: 10, color: AppColors.black)),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: "Complete",
                  groupValue: null, // Not interactive for now
                  onChanged: null,
                  activeColor: isFirst ? AppColors.black : AppColors.blueAccent,
                  fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (isFirst) return AppColors.black;
                    return AppColors.blueAccent;
                  }),
                ),
                Text("Complete", style: TextStyle(fontSize: 10, color: AppColors.black)),
              ],
            ),
          ],
        ),
      ],
    ),
  );
} 