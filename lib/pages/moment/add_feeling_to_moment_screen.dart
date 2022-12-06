import 'package:bletest/moment/moment_manager.dart';
import 'package:bletest/pages/moment/add_notes_to_moment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../moment/momentEnums.dart';

class AddFeelingToMomentScreen extends StatelessWidget {
  const AddFeelingToMomentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MomentManager manager = Provider.of<MomentManager>(context);

    return Scaffold(
        appBar: AppBar(
          title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Capture moment',
                ),
                Text(
                  'How did you feel?',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                ),
              ]),
          actions: [
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                // do something
              },
            )
          ],
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Column(children: [
                Container(
                    margin: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pick a Moodl from each line',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12),
                        ),
                        Image.asset('assets/pleasure.png'),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: Pleasure.values
                                .map((e) => Radio(
                                    value: e,
                                    groupValue: manager.pleasure,
                                    onChanged: (Pleasure? value) {
                                      manager.setPleasure(value!);
                                    }))
                                .toList()),
                        Image.asset('assets/arousal.png'),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: Arousal.values
                                .map((e) => Radio(
                                    value: e,
                                    groupValue: manager.arousal,
                                    onChanged: (Arousal? value) {
                                      manager.setArousal(value!);
                                    }))
                                .toList()),
                        Image.asset('assets/dominance.png'),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: Dominance.values
                                .map((e) => Radio(
                                    value: e,
                                    groupValue: manager.dominance,
                                    onChanged: (Dominance? value) {
                                      manager.setDominance(value!);
                                    }))
                                .toList()),
                      ],
                    ))
              ]))
        ]),
        bottomSheet: Container(
          margin: const EdgeInsets.all(24.0),
          child: ElevatedButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const AddNotesToMomentScreen()))),
            },
            child: Row(children: [Spacer(), const Text('Next'), Spacer()]),
          ),
        ));
  }
}
