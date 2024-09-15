import 'package:flutter/material.dart';

class HelperFunction {
  static void showAlert(
    BuildContext context,
    String name,
    String id,
    String status,
    String numberOfChairs,
  ) {
    Color statusColor;
    if (status == 'Available') {
      statusColor = Colors.green;
    } else if (status == 'Reserved') {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.black;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(name.toUpperCase()),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text(
                    'ID: ',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(id),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Status: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: statusColor),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Number of Chairs: ',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Text(numberOfChairs),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
