import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "History Transaksi",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text("daw"),
              color: Color(0xFFFFFFFF),
            ),
            elevation: 1,
          ),
        ],
      ),
    );
  }

  Widget BuildListTile({
    required String title,
  }) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
