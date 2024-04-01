import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plat_app/app/page/home/page/index/controller/index_controller.dart';
import 'package:plat_app/app/page/home/page/index/model/trending_event_reponse.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarEventWidget extends StatefulWidget {
  final List<EventData> eventData;
  final dynamic kEvents;
  const CalendarEventWidget({
    super.key,
    required this.eventData,
    this.kEvents,
  });

  @override
  State<CalendarEventWidget> createState() => _CalendarEventWidgetState();
}

class _CalendarEventWidgetState extends State<CalendarEventWidget> {
  late final ValueNotifier<List<EventData>> _selectedEvents;
  CalendarFormat calendarFormat = CalendarFormat.week;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  // late final kEventSource;
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<EventData> _getEventsForDay(DateTime day) {
    // return [];
    return widget.kEvents[day] ?? [];
  }

  List<EventData> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color8A8E9C.withOpacity(0.2),
            blurRadius: dimen5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        left: dimen10,
        right: dimen10,
        bottom: dimen10,
      ),
      child: TableCalendar<EventData>(
        daysOfWeekHeight: 20,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: GoogleFonts.quicksand(
            color: color878998,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          weekendStyle: GoogleFonts.quicksand(
            color: color878998,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        headerStyle: HeaderStyle(
          leftChevronVisible: false,
          rightChevronVisible: false,
          headerPadding: const EdgeInsets.only(
            left: 0,
            right: 0,
            top: dimen10,
            bottom: dimen20,
          ),
          titleTextStyle: GoogleFonts.quicksand(
            color: colorBlack,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          formatButtonVisible: true,
          formatButtonDecoration: BoxDecoration(
            border: Border.all(color: colorPrimary),
            borderRadius: BorderRadius.circular(dimen20),
          ),
          formatButtonTextStyle: GoogleFonts.quicksand(
            color: colorPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        firstDay: DateTime(2022, 01, 01),
        lastDay: DateTime(kToday.year, kToday.month + 3, kToday.day),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        rangeStartDay: _rangeStart,
        rangeEndDay: _rangeEnd,
        calendarFormat: calendarFormat,
        rangeSelectionMode: _rangeSelectionMode,
        eventLoader: _getEventsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          markersAlignment: Alignment.center,
          isTodayHighlighted: true,
          todayTextStyle: GoogleFonts.quicksand(
            color: colorWhite,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          weekendTextStyle: GoogleFonts.quicksand(
            color: colorDA656A,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          outsideTextStyle: GoogleFonts.quicksand(
            color: colorB7BBCB,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          defaultTextStyle: GoogleFonts.quicksand(
            color: colorBlack,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          disabledTextStyle: GoogleFonts.quicksand(
            color: colorB7BBCB,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, day, events) => events.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      Routes.socialTaskDetail,
                      arguments: {
                        'task_id': events[0].id,
                        'is_done': false,
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: color30A1DB,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            events[0].bannerUrl ?? ''),
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3),
                          BlendMode.darken,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Text(
                      '${day.day}',
                      style: GoogleFonts.quicksand(
                        color: colorWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              : null,
        ),
        onDaySelected: _onDaySelected,
        onRangeSelected: _onRangeSelected,
        onFormatChanged: (format) {
          if (calendarFormat != format) {
            setState(() {
              calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}

// class EventDataDemo {
//   String? id;
//   String? name;
//   String? date;
//   String? bannerUrl;
//   String? address;
//   EventDataDemo({
//     this.id,
//     this.name,
//     this.date,
//     this.bannerUrl,
//     this.address,
//   });
// }

// final kEvents = LinkedHashMap<DateTime, List<EventDataDemo>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(_kEventSource);

// final _kEventSource = {
//   for (var e in dataEvent)
//     DateTime(
//       int.parse(e['date'].toString().split(" ")[0].split("-")[2]),
//       int.parse(e['date'].toString().split(" ")[0].split("-")[1]),
//       int.parse(e['date'].toString().split(" ")[0].split("-")[0]),
//     ): List.generate(1, (index) => EventDataDemo(id: '1'))
// };

final IndexController indexController = Get.find();

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
// final kFirstDay = DateTime(2022, 01, 01);
// final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
