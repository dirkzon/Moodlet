import 'package:flutter/material.dart';

class YearSelector extends StatefulWidget {
  int currentYear;
  final ValueChanged<int?>? onChanged;

  YearSelector(this.currentYear, this.onChanged, {super.key});

  @override
  _YearSelectorState createState() => _YearSelectorState();
}

class _YearSelectorState extends State<YearSelector> {
  late int selectedYear;
  late List years;

  @override
  void initState() {
    super.initState();
    selectedYear = widget.currentYear;
    years = [for (var i = 2020; i < widget.currentYear + 1; i += 1) i];
  }

  _updateYear(int y) {
    setState(() {
      selectedYear = y;
      widget.onChanged!(selectedYear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
        value: selectedYear,
        items: List.generate(
            years.length,
            (x) => DropdownMenuItem(
                value: years[x],
                child: Text(
                  "${years[x]}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ))),
        onChanged: (value) {
          _updateYear(value!);
        });
  }
}
