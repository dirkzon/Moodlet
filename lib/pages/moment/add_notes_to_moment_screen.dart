import 'package:bletest/comms/hive/adaptors/hiveEntryRepository.dart';
import 'package:bletest/comms/hive/adaptors/hiveMomentRepository.dart';
import 'package:bletest/comms/hive/models/hiveMoment.dart';
import 'package:bletest/moment/moment_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNotesToMomentScreen extends StatelessWidget {
  const AddNotesToMomentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MomentManager manager = Provider.of<MomentManager>(context);

    HiveEntryRepository entryRepo = Provider.of<HiveEntryRepository>(context);

    HiveMomentRepository momentRepo =
        Provider.of<HiveMomentRepository>(context);

    saveMoment() {
      var entries = entryRepo.getEntries(manager.startDate, manager.endDate);

      var average = 0;
      var ground = 0;
      var peak = 0;

      if (entries.isNotEmpty) {
        average = entries.map((entry) => entry.mm).reduce((a, b) => a + b) ~/
            entries.length;

        ground =
            entries.map((entry) => entry.mm).reduce((a, b) => a < b ? a : b);

        peak = entries.map((entry) => entry.mm).reduce((a, b) => a > b ? a : b);
      }

      if (manager.id == "") {
        print("Dit is een nieuw moment");
        HiveMoment momentToSave = new HiveMoment(
            startDate: manager.startDate,
            endDate: manager.endDate,
            name: manager.name,
            location: manager.location,
            categories: manager.categoryNames(),
            pleasure: manager.pleasure.index,
            arousal: manager.arousal.index,
            dominance: manager.dominance.index,
            additionalNotes: manager.additionalNotes,
            averageMM: average,
            groundMM: ground,
            peakMM: peak);

        momentRepo.saveMoment(momentToSave);
      } else {
        print("Nu ga je updaten");
        HiveMoment momentToSave = new HiveMoment(
            startDate: manager.startDate,
            endDate: manager.endDate,
            name: manager.name,
            location: manager.location,
            categories: manager.categoryNames(),
            pleasure: manager.pleasure.index,
            arousal: manager.arousal.index,
            dominance: manager.dominance.index,
            additionalNotes: manager.additionalNotes,
            averageMM: average,
            groundMM: ground,
            peakMM: peak);

        momentRepo.updateMoment(manager.id, momentToSave);
      }

      manager.clearMoment();
      Navigator.of(context).popUntil((route) => route.isFirst);
    }

    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                            SizedBox(height: 6),
                            TextFormField(
                              onChanged: (value) =>
                                  manager.setAdditionalNotes(value),
                              initialValue: manager.additionalNotes,
                              minLines: 6,
                              maxLines: 10,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  hintText:
                                      'F.e. note what you liked and disliked'),
                            ),
                          ],
                        )),
                  ],
                ))
          ]),
          bottomSheet: Container(
            margin: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: manager.isValid() ? () => {saveMoment()} : null,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [const Text('Done')]),
            ),
          ),
        ));
  }
}
