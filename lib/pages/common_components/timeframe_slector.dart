import 'package:flutter/material.dart';

class TimeFrameSelector extends StatefulWidget {
  final ValueChanged<String?>? onChanged;

  const TimeFrameSelector(this.onChanged, {super.key});

  @override
  _TimeFrameSelectorState createState() => _TimeFrameSelectorState();
}

class _TimeFrameSelectorState extends State<TimeFrameSelector> {
  List timeFrames = ['Day', 'Week', 'Month'];

  String selected = "Day";

  _setTimeFrame(String t) {
    setState(() {
      selected = t;
    });
    widget.onChanged!(t);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      height: 40,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: const Color(0xffF47918),
          width: 2,
        ),
      ),
      child: Row(
        children: List.generate(
            3,
            (i) => Expanded(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          timeFrames[i] == selected
                              ? const Color(0xffF47918)
                              : Colors.transparent),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                      minimumSize:
                          MaterialStateProperty.all(const Size(40, 100))),
                  onPressed: () => _setTimeFrame(timeFrames[i]),
                  child: Text(
                    '${timeFrames[i]}',
                    style: TextStyle(
                        color: timeFrames[i] == selected
                            ? Colors.white
                            : const Color(0xff707070)),
                  ),
                ))),
      ),
    );
  }
}
