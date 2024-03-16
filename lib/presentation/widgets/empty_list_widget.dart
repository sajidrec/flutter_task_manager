import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) => const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            "No Items",
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      // child: const Center(
      //   // child: Text('No items'),
    );
  }
}
