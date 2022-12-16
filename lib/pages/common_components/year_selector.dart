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
    print(widget.currentYear);
    years = [for (var i = 2020; i < widget.currentYear + 1; i += 1) i];
    print(years);
  }

  _updateYear(int y) {
    print(y);
    setState(() {
      selectedYear = y;
      widget.onChanged!(selectedYear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: "$selectedYear",
        items: List.generate(
            years.length,
            (x) => DropdownMenuItem(
                value: "${years[x]}",
                child: Text(
                  "${years[x]}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ))),
        onChanged: (value) {
          _updateYear(int.parse(value as String));
        });
  }
}
