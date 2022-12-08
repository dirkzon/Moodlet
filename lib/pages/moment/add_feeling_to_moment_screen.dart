import 'package:bletest/moment/moment_manager.dart';
import 'package:bletest/pages/moment/add_notes_to_moment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../moment/momentEnums.dart';

class AddFeelingToMomentScreen extends StatelessWidget {
  const AddFeelingToMomentScreen({super.key});

  Widget _buildPopupDialog(BuildContext context) {
    return new CupertinoAlertDialog(
      title: const Text('Self Assessment Manikin (SAM)'),
      actions: <Widget>[
        new CupertinoButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Close",
              // textAlign: TextAlign.center,
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
        ),
      ],
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              "The Self-Assessment Mannequin (SAM) is a non-verbal pictorial appraisal strategy that measures your full-of-feeling response's joy, excitement, and dominance to a wide assortment of boosts."),
        ],
      ),
    );
  }

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
                manager.clearMoment();
                Navigator.of(context).popUntil((route) => route.isFirst);
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
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                          child: Row(children: [
                            Text(
                              'Pick a Moodl from each line',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () => {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildPopupDialog(context),
                                )
                              },
                              icon: Icon(Icons.info_outline),
                              color: Theme.of(context).colorScheme.primary,
                            )
                          ]),
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [const Text('Next')]),
          ),
        ));
  }
}
