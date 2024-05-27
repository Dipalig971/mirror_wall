
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/mirror_wall_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerTrue = Provider.of<GoogleProvider>(context);
    final providerFalse = Provider.of<GoogleProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History Lists'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            providerTrue.historyList.length,
                (index) => ListTile(
              onTap: () {
                providerFalse.openWebsite(providerTrue.historyList[index].url);
                Navigator.pop(context);
              },
              title: Text(providerTrue.historyList[index].text),
              subtitle: Text(
                providerTrue.historyList[index].url,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: CupertinoButton(
                onPressed: () {
                  providerFalse.deleteHistory(index);
                },
                child: const Icon(Icons.cancel),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
