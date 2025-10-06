import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'cart.dart';
import 'create_plan.dart';
import 'details.dart';

class Date extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  const Date({super.key, required this.items});

  @override
  State<Date> createState() => _DateState();
}

class _DateState extends State<Date> {
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime _focusedDay = DateTime.now();

  bool _isBeforeToday(DateTime day) {
    final today = DateTime.now();
    return day.isBefore(DateTime(today.year, today.month, today.day));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      if (_startDate == null || (_startDate != null && _endDate != null)) {
        _startDate = selectedDay;
        _endDate = null;
      } else if (_startDate != null && _endDate == null) {
        if (selectedDay.isBefore(_startDate!)) {
          _startDate = selectedDay;
        } else {
          _endDate = selectedDay;
        }
      }
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return "${date.day.toString().padLeft(2,'0')}/${date.month.toString().padLeft(2,'0')}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16014A),
      appBar: AppBar(
        title: const Text("Select Trip Dates"),
        backgroundColor: const Color(0xFF16014A),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ---------- From & To Fields ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    child: Text(
                      _startDate != null ? _formatDate(_startDate) : 'From',
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    child: Text(
                      _endDate != null ? _formatDate(_endDate) : 'To',
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // ---------- Calendar ----------
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime(DateTime.now().year + 1),
                focusedDay: _focusedDay,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarStyle: CalendarStyle(
                  defaultTextStyle: const TextStyle(color: Colors.black87),
                  weekendTextStyle: const TextStyle(color: Colors.black87),
                  todayDecoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                selectedDayPredicate: (day) =>
                    (_startDate != null && isSameDay(day, _startDate!)) ||
                    (_endDate != null && isSameDay(day, _endDate!)),
                onDaySelected: (selectedDay, focusedDay) {
                  if (!_isBeforeToday(selectedDay)) {
                    _onDaySelected(selectedDay, focusedDay);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Cannot select past date")),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            // ---------- Confirm Button ----------
            ElevatedButton(
              onPressed: (_startDate != null && _endDate != null)
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectDis(
                            cartItems: CartPage.cartItems,
                          ),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    (_startDate != null && _endDate != null) ? Colors.white : Colors.grey,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              ),
              child: Text(
                "Apply Dates",
                style: TextStyle(
                  color: (_startDate != null && _endDate != null)
                      ? const Color(0xFF16014A)
                      : Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
