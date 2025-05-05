import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ActivityCalendar extends StatefulWidget {
  const ActivityCalendar({super.key});

  @override
  State<ActivityCalendar> createState() => _ActivityCalendarState();
}

class _ActivityCalendarState extends State<ActivityCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<String>> _events = {
    DateTime.utc(2021, 9, 2): ['Math Quiz', 'Submit Science Report'],
    DateTime.utc(2021, 9, 8): ['PE Day', 'Meeting with Counselor'],
    DateTime.utc(2021, 9, 16): ['Art Workshop'],
  };

  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }
  @override
  Widget build(BuildContext context) {
    final selectedEvents = _getEventsForDay(_selectedDay!);
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getEventsForDay,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),
              ),
              selectedDecoration: BoxDecoration(
                color: Color(0xFF0F1C44),
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Color(0xFF0F1C44),
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F1C44),
              ),
              leftChevronIcon:
              Icon(Icons.chevron_left, color: Color(0xFF0F1C44)),
              rightChevronIcon:
              Icon(Icons.chevron_right, color: Color(0xFF0F1C44)),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Color(0xFFB0B0B0)),
              weekdayStyle: TextStyle(color: Color(0xFFB0B0B0)),
            ),
          ),
          SizedBox(height: 16),
          if (selectedEvents.isNotEmpty)
            ...selectedEvents.map(
                  (event) => Card(
                margin: EdgeInsets.symmetric(vertical: 4),
                elevation: 2,
                child: ListTile(
                  title: Text(event),
                  leading: Icon(Icons.event_note),
                ),
              ),
            )
          else
            Text("No activities for this day."),
        ],
      ),
    );
  }
}
