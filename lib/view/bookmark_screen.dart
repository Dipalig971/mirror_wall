
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/mirror_wall_provider.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final providerTrue = Provider.of<GoogleProvider>(context);
    final providerFalse = Provider.of<GoogleProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BookMark Lists'),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: List.generate(providerTrue.bookmarkList.length, (index) => ListTile(
              onTap: () {
                providerFalse.openWebsite(providerTrue.bookmarkList[index].url);
                Navigator.pop(context);
              },
              title: Text(providerTrue.bookmarkList[index].text),
              subtitle: Text(providerTrue.bookmarkList[index].url,overflow: TextOverflow.ellipsis,),
              trailing: CupertinoButton(
                onPressed: () {
                  providerFalse.deleteBookMark(index);
                },
                child: const Icon(Icons.cancel),
              ),
            ))
        ),
      ),
    );
  }
}
