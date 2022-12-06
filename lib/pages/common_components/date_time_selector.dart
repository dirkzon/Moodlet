import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeSelector extends StatefulWidget {
  final bool useTime;
  final ValueChanged<DateTime?>? onChanged;
  final DateTime initialValue;

  const DateTimeSelector(
      {super.key,
      required this.useTime,
      this.onChanged,
      required this.initialValue});

  @override
  _DateTimeSelectorState createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  late DateTime _selectedDateTime = widget.initialValue ?? DateTime.now();

  final TextStyle textStyle =
      const TextStyle(fontSize: 22, fontWeight: FontWeight.w400);

  final BoxDecoration boxDecoration = BoxDecoration(
      color: const Color.fromARGB(31, 118, 118, 128),
      borderRadius: BorderRadius.circular(6.0));

  void _updateDate(DateTime newdate) {
    DateTime date = widget.useTime
        ? newdate
        : DateTime(newdate.year, newdate.month, newdate.day);
    setState(() {
      _selectedDateTime = date;
    });
    widget.onChanged!(_selectedDateTime);
  }

  void _updateTime(TimeOfDay time) {
    setState(() {
      _selectedDateTime = DateTime(
          _selectedDateTime.year,
          _selectedDateTime.month,
          _selectedDateTime.day,
          time.hour,
          time.minute);
    });
    widget.onChanged!(_selectedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          InkWell(
              onTap: () async {
                var date = (await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100)))!;
                _updateDate(date);
              },
              child: Container(
                width: widget.useTime ? 160 : 230,
                decoration: boxDecoration,
                padding: const EdgeInsets.only(
                    left: 11.0, right: 11.0, top: 4.0, bottom: 4.0),
                child: Row(
                  children: [
                    Text(
                      _selectedDateTime.day.toString(),
                      style: textStyle,
                    ),
                    const Spacer(),
                    Text(DateFormat('MMM').format(_selectedDateTime),
                        style: textStyle),
                    const Spacer(),
                    Text(_selectedDateTime.year.toString(), style: textStyle),
                  ],
                ),
              )),
          const SizedBox(width: 8),
          if (widget.useTime)
            InkWell(
                onTap: () async {
                  TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                          hour: _selectedDateTime.hour,
                          minute: _selectedDateTime.minute),
                      initialEntryMode: TimePickerEntryMode.input);
                  if (time == null) return;
                  _updateTime(time);
                },
                child: Container(
                    width: 100,
                    decoration: boxDecoration,
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                          "${_selectedDateTime.hour} : ${_selectedDateTime.minute.toString().padLeft(2, '0')}",
                          style: textStyle),
                    )))
        ],
      ),
    );
  }
}
