import 'package:bletest/moment/moment_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNotesToMomentScreen extends StatelessWidget {
  const AddNotesToMomentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MomentManager manager = Provider.of<MomentManager>(context);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
              Text(
                'Capture moment',
              ),
              Text(
                'What happened?',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ),
            ])),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add additional notes',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12),
                          ),
                          SizedBox(height: 6),
                          SizedBox(
                              width: 340,
                              child: TextField(
                                onChanged: (value) => manager.setName(value),
                                minLines: 6,
                                maxLines: 10,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    hintText:
                                        'F.e. note what you liked and disliked'),
                              )),
                        ],
                      )),
                ],
              ))
        ]),
        bottomSheet: Container(
          margin: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: 340,
            child: ElevatedButton(
              onPressed: () => {},
              child: const Text('Done'),
            ),
          ),
        ));
  }
}
