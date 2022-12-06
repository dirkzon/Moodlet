import 'package:flutter/material.dart';

class MonthSelector extends StatefulWidget {
  int currentMonth;
  final ValueChanged<int?>? onChanged;

  MonthSelector(this.currentMonth, this.onChanged, {super.key});

  @override
  _MonthSelectorState createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  late int selectedMonth;

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.currentMonth - 1;
  }

  _updateMonth(int x) {
    setState(() {
      selectedMonth = x;
      widget.onChanged!(selectedMonth + 1);
    });
  }

  final List months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: months[selectedMonth],
      items: List.generate(
          widget.currentMonth,
          (x) => DropdownMenuItem(
              value: months[x],
              child: Text(
                months[x],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ))),
      onChanged: (value) => _updateMonth(months.indexOf(value)),
    );
  }
}
