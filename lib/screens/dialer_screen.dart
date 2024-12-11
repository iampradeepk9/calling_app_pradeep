import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/call_log_controller.dart';

class DialerScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final callLogController = Get.find<CallLogController>();

    void _showDialerPad(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) {
          return DialerPad(
            controller: _controller,
            onCallPressed: () {
              final number = _controller.text;
              if (number.isNotEmpty) {
                callLogController.addCall(number);
                _controller.clear();
                Navigator.pop(context);
                Get.toNamed('/outgoingCall', arguments: number);
              } else {
                Get.snackbar(
                  'Error',
                  'Please enter a phone number',
                  backgroundColor: Colors.red.shade400,
                  colorText: Colors.white,
                );
              }
            },
          );
        },
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Dialer',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Colors.white),
            onPressed: () => Get.toNamed('/callLog'),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade700, Colors.teal.shade400],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: kToolbarHeight + 40),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _controller,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Enter phone number',
                      prefixIcon: Icon(Icons.phone, color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: FloatingActionButton.extended(
                onPressed: () => _showDialerPad(context),
                label: const Text(
                  'Open Dialer',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                icon: Icon(Icons.dialpad, color: Colors.white),
                backgroundColor: Colors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DialerPad extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onCallPressed;

  const DialerPad({
    required this.controller,
    required this.onCallPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Dial Number',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 12,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.8,
              ),
              itemBuilder: (context, index) {
                if (index == 9) return SizedBox.shrink();
                if (index == 11) {
                  return IconButton(
                  icon: Icon(Icons.backspace),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      controller.text = controller.text.substring(0, controller.text.length - 1);
                    }
                  },
                );
                }

                String text = index == 10 ? '0' : '${index + 1}';
                return ElevatedButton(
                  onPressed: () {
                    controller.text += text;
                  },
                  child: Text(text),
                );
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: onCallPressed,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.call, color: Colors.white), // The icon
                  SizedBox(width: 8),
                  Text(
                    'Call',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}