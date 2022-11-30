import 'package:bletest/comms/hive/models/hiveEntry.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import "package:collection/collection.dart";

var data = [];

var testData = [
  HiveEntry(date: DateTime.parse("2022-11-30T06:30"), mm: 20),
  HiveEntry(date: DateTime.parse("2022-11-30T08:08"), mm: 50),
  HiveEntry(date: DateTime.parse("2022-11-30T08:50"), mm: 10),
  HiveEntry(date: DateTime.parse("2022-11-30T12:12"), mm: 45),
  HiveEntry(date: DateTime.parse("2022-11-30T14:12"), mm: 67),
  HiveEntry(date: DateTime.parse("2022-11-30T19:17"), mm: 10),
  HiveEntry(date: DateTime.parse("2022-11-30T19:18"), mm: 80),
  HiveEntry(date: DateTime.parse("2022-11-30T21:23"), mm: 96),
  HiveEntry(date: DateTime.parse("2022-11-30T07:08"), mm: 54),
  HiveEntry(date: DateTime.parse("2022-11-30T09:50"), mm: 34),
  HiveEntry(date: DateTime.parse("2022-11-30T14:12"), mm: 58),
  HiveEntry(date: DateTime.parse("2022-11-30T14:12"), mm: 52),
  HiveEntry(date: DateTime.parse("2022-11-30T18:17"), mm: 70),
  HiveEntry(date: DateTime.parse("2022-11-30T20:18"), mm: 13),
  HiveEntry(date: DateTime.parse("2022-11-30T20:23"), mm: 100),
];

class MoodChart extends StatefulWidget {
  const MoodChart({super.key});

  @override
  _MoodChartState createState() => _MoodChartState();
}

// do not use moodchart in SingleChildScrollView
class _MoodChartState extends State<MoodChart> {
  DateTime date = DateTime.now();

  List<HiveEntry> _changeDataResulution(Iterable<HiveEntry> data) {
    var grouped = groupBy(data, (HiveEntry entry) {
      return entry.date.hour;
    });

    return grouped.entries.map((MapEntry<int, List<HiveEntry>> item) {
      return HiveEntry(
          date: DateTime(date.year, date.month, date.day, item.key),
          mm: item.value.map((entry) => entry.mm).reduce((a, b) => a + b) ~/
              item.value.length);
    }).toList();
  }

  List<charts.Series<HiveEntry, DateTime>> _getData() {
    return [
      charts.Series<HiveEntry, DateTime>(
          id: 'moodData',
          measureFn: (entry, index) => entry.mm,
          domainFn: (entry, index) => entry.date,
          data: _changeDataResulution(testData),
          fillColorFn: (entry, index) =>
              const charts.Color(r: 243, g: 139, b: 76)),
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

  List<charts.TickSpec<DateTime>> _createDomainTickSpec() {
    const styleSpec = charts.TextStyleSpec(fontSize: 12);
    DateTime startOfDay = DateTime(date.year, date.month, date.day);
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

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(25, 244, 119, 24),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.transparent,
            ),
            margin: const EdgeInsets.all(13.0),
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        const Text(
                          "Moodl levels",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        const Spacer(),
                        Text(
                          DateFormat('EEE MMMM d').format(date).toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 10),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 180,
                  child: charts.TimeSeriesChart(
                    _getData(),
                    animate: true,
                    animationDuration: const Duration(milliseconds: 750),
                    behaviors: [
                      charts.PanAndZoomBehavior(),
                      charts.SlidingViewport(
                        charts.SelectionModelType.action,
                      ),
                    ],
                    primaryMeasureAxis: charts.NumericAxisSpec(
                        tickProviderSpec: charts.StaticNumericTickProviderSpec(
                            _createPrimaryTickSpec())),
                    domainAxis: charts.DateTimeAxisSpec(
                        tickFormatterSpec:
                            const charts.AutoDateTimeTickFormatterSpec(
                          day: charts.TimeFormatterSpec(
                              format: 'hh',
                              transitionFormat: 'hh',
                              noonFormat: 'hh'),
                        ),
                        tickProviderSpec: charts.StaticDateTimeTickProviderSpec(
                            _createDomainTickSpec())),
                    defaultRenderer: charts.BarRendererConfig<DateTime>(
                      maxBarWidthPx: 8,
                      groupingType: charts.BarGroupingType.grouped,
                      cornerStrategy: const charts.ConstCornerStrategy(50),
                    ),
                  ),
                )
              ],
            )));
  }
}
