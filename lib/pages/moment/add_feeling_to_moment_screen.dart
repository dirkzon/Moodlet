import 'package:bletest/moment/moment_manager.dart';
import 'package:bletest/pages/moment/add_notes_to_moment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Pleasure { unpleasant, unsatisfied, neutral, pleased, pleasant }

enum Arousal { calm, dull, neutral, wideAwake, excited }

enum Dominance { independent, powerful, neutral, powerlessness, dependent }

class AddFeelingToMomentScreen extends StatefulWidget {
  const AddFeelingToMomentScreen({super.key});

  @override
  _AddFeelingToMomentScreenState createState() =>
      _AddFeelingToMomentScreenState();
}

class _AddFeelingToMomentScreenState extends State<AddFeelingToMomentScreen> {
  Pleasure? _pleasure = Pleasure.neutral;
  Arousal? _arousal = Arousal.neutral;
  Dominance? _dominance = Dominance.neutral;

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
            ])),
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
                                    groupValue: _pleasure,
                                    onChanged: (Pleasure? value) {
                                      setState(() {
                                        _pleasure = value;
                                      });
                                    }))
                                .toList()),
                        Image.asset('assets/arousal.png'),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: Arousal.values
                                .map((e) => Radio(
                                    value: e,
                                    groupValue: _arousal,
                                    onChanged: (Arousal? value) {
                                      setState(() {
                                        _arousal = value;
                                      });
                                    }))
                                .toList()),
                        Image.asset('assets/dominance.png'),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: Dominance.values
                                .map((e) => Radio(
                                    value: e,
                                    groupValue: _dominance,
                                    onChanged: (Dominance? value) {
                                      setState(() {
                                        _dominance = value;
                                      });
                                    }))
                                .toList()),
                      ],
                    ))
              ]))
        ]),
        bottomSheet: Container(
          margin: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: 340,
            child: ElevatedButton(
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            const AddNotesToMomentScreen()))),
              },
              child: const Text('Next'),
            ),
          ),
        ));
  }
}
