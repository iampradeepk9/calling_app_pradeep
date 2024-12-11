import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/call_log_controller.dart';

class CallLogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final callLogController = Get.find<CallLogController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Call Log'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade600, Colors.green.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Obx(() {
          final callLogs = callLogController.callLogs;
          return callLogs.isEmpty
              ? const Center(
            child: Text(
              'No call logs yet',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
          )
              : ListView.builder(
            itemCount: callLogs.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  leading: const Icon(
                    Icons.phone,
                    color: Colors.green,
                    size: 30,
                  ),
                  title: Text(
                    callLogs[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Tap to call again',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                  onTap: () => Get.toNamed('/outgoingCall',
                      arguments: callLogs[index]),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}