import 'package:bletest/comms/hive/models/hiveEntry.dart';
import 'package:bletest/comms/hive/models/hiveMoment.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import "package:collection/collection.dart";

class MoodChart extends StatelessWidget {
  List<HiveEntry> data = [];
  late Duration duration;
  late DateTime start;
  late DateTime end;
  Color background = Colors.transparent;
  bool singleDay = true;
  List<HiveMoment> moments = [];

  MoodChart(this.data, this.start, this.end, this.background, this.moments,
      {super.key}) {
    duration = end.difference(start);
    singleDay = duration.inHours <= 24;
  }

  List<HiveEntry> _changeDataResulution(Iterable<HiveEntry> data) {
    var grouped = groupBy(data, (HiveEntry entry) {
      var date = entry.date;
      if (singleDay) {
        return DateTime(date.year, date.month, date.day, date.hour);
      }
      if (duration.inHours < 24) {
        return DateTime(
            date.year, date.month, date.day, date.hour, date.minute);
      }
      if (duration.inDays > 1) {
        return DateTime(date.year, date.month, date.day);
      }
      if (duration.inDays > 6) {
        return DateTime(date.year, date.month, date.day);
      }
      return DateTime(date.year, date.month, date.day, date.hour);
    });

    return grouped.entries.map((MapEntry<DateTime, List<HiveEntry>> item) {
      return HiveEntry(
          date: item.key,
          mm: item.value.map((entry) => entry.mm).reduce((a, b) => a + b) ~/
              item.value.length);
    }).toList();
  }

  int _getPleasure(DateTime date) {
    List momentList = [];
    if (singleDay) {
      momentList = moments
          .where((moment) =>
              moment.startDate.microsecondsSinceEpoch <
                  date.microsecondsSinceEpoch &&
              moment.endDate.microsecondsSinceEpoch >
                  date.microsecondsSinceEpoch)
          .toList();
    } else {
      momentList =
          moments.where((moment) => moment.startDate.day == date.day).toList();
    }
    if (momentList.isNotEmpty) {
      return momentList.map((m) => m.pleasure).reduce((a, b) => a + b) ~/
          momentList.length;
    }
    return -1;
  }

  List<charts.Series<HiveEntry, DateTime>> _getData() {
    return [
      charts.Series<HiveEntry, DateTime>(
          id: 'moodData',
          measureFn: (entry, index) => entry.mm,
          domainFn: (entry, index) => entry.date,
          data: _changeDataResulution(data),
          fillColorFn: (entry, index) {
            _getPleasure(entry.date);
            switch (_getPleasure(entry.date)) {
              case -1:
                return const charts.Color(r: 157, g: 157, b: 157);
              case 0:
                return const charts.Color(r: 255, g: 123, b: 84);
              case 1:
                return const charts.Color(r: 255, g: 178, b: 107);
              case 2:
                return const charts.Color(r: 255, g: 213, b: 111);
              case 3:
                return const charts.Color(r: 147, g: 155, b: 98);
              case 4:
                return const charts.Color(r: 171, g: 194, b: 112);
              default:
                return const charts.Color(r: 157, g: 157, b: 157);
            }
          }),
    ];
  }

  List<charts.TickSpec<num>> _createPrimaryTickSpec() {
    const styleSpec = charts.TextStyleSpec(fontSize: 12);
    return const [
      charts.TickSpec(0, label: ''),
      charts.TickSpec(10, label: 'Low', style: styleSpec),
      charts.TickSpec(55, label: 'Med', style: styleSpec),
      charts.TickSpec(100, label: 'High', style: styleSpec),
    ];
  }

  List<charts.TickSpec<DateTime>> _createSingleDayDomainTickSpec() {
    const styleSpec = charts.TextStyleSpec(fontSize: 12);
    DateTime startOfDay = DateTime(start.year, start.month, start.day);
    return [
      charts.TickSpec(startOfDay.add(const Duration(hours: 0)),
          label: '', style: styleSpec),
      charts.TickSpec(startOfDay.add(const Duration(hours: 6)),
          label: 'sunrise', style: styleSpec),
      charts.TickSpec(startOfDay.add(const Duration(hours: 12)),
          label: 'midday', style: styleSpec),
      charts.TickSpec(startOfDay.add(const Duration(hours: 18)),
          label: 'sundown', style: styleSpec),
      charts.TickSpec(startOfDay.add(const Duration(hours: 22)),
          label: 'night', style: styleSpec),
      charts.TickSpec(startOfDay.add(const Duration(hours: 24)),
          label: '', style: styleSpec),
    ];
  }

  List<charts.TickSpec<DateTime>> _createMultidayDomainTickSpec() {
    List<charts.TickSpec<DateTime>> output = [];
    for (var i = 0; i < duration.inDays; i += duration.inDays <= 7 ? 1 : 2) {
      DateTime date = start.add(Duration(days: i));
      output.add(charts.TickSpec(date, label: DateFormat('d').format(date)));
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: background,
        ),
        margin: const EdgeInsets.all(13.0),
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  Row(
                    children: [
                      const Text(
                        "Moodlet levels",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      const Spacer(),
                      Text(
                        singleDay
                            ? DateFormat('EEE MMMM d').format(start).toString()
                            : "${DateFormat('EEE MMMM d').format(start)} - ${DateFormat('EEE MMMM d').format(end)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 10),
                      ),
                    ],
                  ),
                  if (data.isEmpty)
                    Row(children: const [
                      Text(
                        "No data found",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.red),
                      )
                    ]),
                ])),
            SizedBox(
              height: 180,
              width: 400,
              child: charts.TimeSeriesChart(
                _getData(),
                animate: true,
                animationDuration: const Duration(milliseconds: 750),
                primaryMeasureAxis: charts.NumericAxisSpec(
                    tickProviderSpec: charts.StaticNumericTickProviderSpec(
                        _createPrimaryTickSpec())),
                domainAxis: charts.DateTimeAxisSpec(
                    tickProviderSpec: charts.StaticDateTimeTickProviderSpec(
                        singleDay
                            ? _createSingleDayDomainTickSpec()
                            : _createMultidayDomainTickSpec())),
                defaultRenderer: charts.BarRendererConfig<DateTime>(
                  maxBarWidthPx: 8,
                  groupingType: charts.BarGroupingType.grouped,
                  cornerStrategy: const charts.ConstCornerStrategy(50),
                ),
              ),
            )
          ],
        ));
  }
}
