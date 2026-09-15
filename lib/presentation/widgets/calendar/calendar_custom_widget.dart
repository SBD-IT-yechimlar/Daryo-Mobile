import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../core/gen/localization/strings.dart';

class CalendarCustomWidget extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  const CalendarCustomWidget({super.key, this.onDateSelected});

  @override
  State<CalendarCustomWidget> createState() => _CalendarCustomWidgetState();
}

class _CalendarCustomWidgetState extends State<CalendarCustomWidget> {
  DateTime _currentDate = DateTime.now();
  DateTime _targetDateTime = DateTime.now();
  int _selectedYear = DateTime.now().year;

  // Oy nomlarini olish
  String _getMonthName(int month) {
    List<String> months = [
      Strings.january,
      Strings.february,
      Strings.march,
      Strings.april,
      Strings.may,
      Strings.june,
      Strings.july,
      Strings.august,
      Strings.september,
      Strings.october,
      Strings.november,
      Strings.december
    ];
    return months[month - 1];
  }

  // Yil tanlash dialogi
  void _showYearPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.backgroundColor,
          title: Strings.selectYear.s(14).w(500).c(Color(0xFF1A1C1E)),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) {
                int year = DateTime.now().year - 25 + index;
                return ListTile(
                  title: Text(
                    '$year',
                    style: TextStyle(
                      fontWeight: year == _selectedYear ? FontWeight.bold : FontWeight.normal,
                      color: year == _selectedYear ? Colors.blueAccent : Colors.black,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedYear = year;
                      _targetDateTime = DateTime(year, _targetDateTime.month, 1);
                      _currentDate = DateTime(year, _currentDate.month, _currentDate.day);
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            "${Strings.year}  -".s(14).w(500).c(context.textPrimary),
            SizedBox(width: 10),
            GestureDetector(
              onTap: _showYearPicker,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: StaticColors.lightBorder, width: 1),
                ),
                child: Row(
                  children: [
                    Assets.imagesDaryo.icCalendar.svg(),
                    SizedBox(width: 12),
                    "$_selectedYear".s(14).w(500).c(context.textPrimary),
                    SizedBox(width: 27),
                    Assets.imagesDaryo.icArrowDown.svg(colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
                  ],
                ),
              ),
            )
          ],
        ),

        // 🔸 Kalendar qismi
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: context.containerBackground,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                // 🔸 Custom header (oy va navigatsiya)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Chap tomonga o'tish
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _targetDateTime = DateTime(
                              _targetDateTime.year,
                              _targetDateTime.month - 1,
                            );
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: context.backgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child:
                              Center(child: Assets.imagesDaryo.icArrowLeft.svg(colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn))),
                        ),
                      ),

                      // Oy nomi
                      _getMonthName(_targetDateTime.month).s(20).w(500).c(context.textPrimary),

                      // O'ng tomonga o'tish
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _targetDateTime = DateTime(
                              _targetDateTime.year,
                              _targetDateTime.month + 1,
                            );
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: context.backgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(child: Assets.imagesDaryo.icArrowRight.svg(colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn))),
                        ),
                      ),
                    ],
                  ),
                ),

                // 🔸 CalendarCarousel
                CalendarCarousel<Event>(
                  targetDateTime: _targetDateTime,
                  selectedDateTime: _currentDate,
                  onDayPressed: (date, events) {
                    if (date.isAfter(DateTime.now())) return;

                    setState(() {
                      _currentDate = date;
                    });
                    widget.onDateSelected?.call(date);
                  },
                  pageScrollPhysics: NeverScrollableScrollPhysics(),
                  weekFormat: false,
                  showHeader: false,
                  showWeekDays: false,
                  height: 230,
                  showOnlyCurrentMonthDate: false,
                  daysHaveCircularBorder: true,
                  todayButtonColor: Colors.transparent,
                  todayBorderColor:  Colors.transparent,
                  selectedDayBorderColor: context.primary,

                  customDayBuilder: (
                      bool isSelectable,
                      int index,
                      bool isSelectedDay,
                      bool isToday,
                      bool isPrevMonthDay,
                      TextStyle textStyle,
                      bool isNextMonthDay,
                      bool isThisMonthDay,
                      DateTime day,
                      ) {
                    // 🔹 Kelajakdagi kunlarni disable qilish
                    bool isFutureDay = day.isAfter(DateTime.now());

                    if (isPrevMonthDay || isNextMonthDay) {
                      return DottedBorder(
                        options: CustomPathDottedBorderOptions(
                          dashPattern: [3, 3],
                          color: context.textPrimary,
                          strokeWidth: 1,
                          customPath: (size) {
                            final path = Path();
                            path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));
                            return path;
                          },
                        ),
                        child: Center(
                          child: "${day.day}".s(14).w(400).c(context.containerBackground),
                        ),
                      );
                    }

                    if (isFutureDay) {
                      // 🔹 Kelajakdagi kunlar gray rangda disable qilinadi
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.backgroundColor.withOpacity(0.3),
                        ),
                        child: Center(
                          child: "${day.day}".s(14).w(400).c(context.textPrimary.withOpacity(0.3)),
                        ),
                      );
                    }

                    if (isSelectedDay && !isToday) {
                      return Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: context.primary, border: Border.all(width: 0, color: context.primary)),
                        child: Center(
                          child: "${day.day}".s(14).w(400).c(context.textPrimary),
                        ),
                      );
                    }

                    if (isSelectedDay && isToday) {
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.primary,
                        ),
                        child: Center(
                          child: "${day.day}".s(14).w(400).c(context.textPrimary),
                        ),
                      );
                    }

                    if (isToday) {
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.primary,
                        ),
                        child: Center(
                          child: "${day.day}".s(14).w(400).c(context.textPrimary),
                        ),
                      );
                    }

                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.backgroundColor,
                      ),
                      child: Center(
                        child: "${day.day}".s(14).w(400).c(context.textPrimary),
                      ),
                    );
                  },
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}
