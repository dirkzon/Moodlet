import 'package:flutter/material.dart';

class HorizontalNumberPicker extends StatefulWidget {
  final ValueChanged<int?>? onChanged;
  final int count;
  final int selected;

  const HorizontalNumberPicker(
      {super.key, this.onChanged, required this.count, required this.selected});

  @override
  _HorizontalNumberPickerState createState() => _HorizontalNumberPickerState();
}

class _HorizontalNumberPickerState extends State<HorizontalNumberPicker> {
  late int scrollSelected;
  double itemWidth = 60.0;

  @override
  void initState() {
    super.initState();
    _updateScroll(widget.selected);
  }

  _updateScroll(int x) {
    setState(() {
      scrollSelected = x;
    });
  }

  _updateSelected(int x) {
    if (x == scrollSelected) {
      widget.onChanged!(x + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(0),
      child: RotatedBox(
          quarterTurns: -1,
          child: ListWheelScrollView(
            diameterRatio: 10,
            onSelectedItemChanged: (x) => _updateScroll(x),
            controller:
                FixedExtentScrollController(initialItem: scrollSelected),
            itemExtent: itemWidth,
            children: List.generate(
                widget.count,
                (x) => RotatedBox(
                    quarterTurns: 1,
                    child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: AnimatedContainer(
                            onEnd: () => _updateSelected(x),
                            padding: const EdgeInsets.only(top: 11),
                            duration: const Duration(milliseconds: 500),
                            height: 72,
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: x == scrollSelected
                                  ? const Color(0xffF47918)
                                  : Colors.transparent,
                            ),
                            child: Text(
                              '${x + 1}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: x == scrollSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: x == scrollSelected
                                      ? Colors.white
                                      : Colors.black),
                            ))))),
          )),
    );
  }
}
