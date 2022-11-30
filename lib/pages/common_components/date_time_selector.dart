import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeSelector extends StatefulWidget {
  const DateTimeSelector({super.key});

  @override
  _DateTimeSelectorState createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  final TextStyle textStyle =
      const TextStyle(fontSize: 22, fontWeight: FontWeight.w400);

  final BoxDecoration boxDecoration = BoxDecoration(
      color: const Color.fromARGB(31, 118, 118, 128),
      borderRadius: BorderRadius.circular(6.0));

  DateTime _selectedDateTime = DateTime.now();

  void _updateDate(DateTime date) {
    setState(() {
      _selectedDateTime = DateTime(date.year, date.month, date.day,
          _selectedDateTime.hour, _selectedDateTime.minute);
    });
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.5),
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
                width: 210,
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
          const Spacer(),
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
