import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDateTime extends StatefulWidget {
  const SelectDateTime({Key? key}) : super(key: key);

  @override
  State<SelectDateTime> createState() => _SelectDateTimeState();
}

class BookingDate {
  DateTime date;
  bool enabled;
  List<TimeSlots> timeSlots;

  BookingDate(this.date, this.enabled, this.timeSlots);
}

class TimeSlots {
  String slot;
  bool enabled;

  TimeSlots(this.slot, this.enabled);
}

class _SelectDateTimeState extends State<SelectDateTime> {
  List<BookingDate> dateAndSlots = [];
  int dateSelectedIndex = 0;
  int timeSlotSelectedIndex = 0;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    formatDateTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE4E4E4),
        centerTitle: true,
        title: Text(
          'Select date & time',
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select Date',
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 80,
            child: RawScrollbar(
              controller: scrollController,
              radius: const Radius.circular(4),
              isAlwaysShown: true,
              thumbColor: const Color(0xffC4C4C4),
              child: ListView.builder(
                controller: scrollController,
                itemCount: dateAndSlots.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => setState(() {
                      dateSelectedIndex = index;
                    }),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 80,
                        decoration: BoxDecoration(
                            color: dateSelectedIndex == index
                                ? const Color(0xff025B5D)
                                : Colors.white,
                            border: Border.all(
                              color: const Color(0xff757575).withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                DateFormat('d')
                                    .format(dateAndSlots[index].date),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: dateSelectedIndex == index
                                            ? Colors.white
                                            : Colors.black),
                              ),
                              Text(
                                index == 0
                                    ? 'Today'
                                    : DateFormat('E')
                                        .format(dateAndSlots[index].date),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: dateSelectedIndex == index
                                            ? Colors.white
                                            : Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const Divider(
            color: Color(0xffC4C4C4),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select Time',
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            // height: 500,
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: dateAndSlots[dateSelectedIndex].timeSlots.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 70),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => setState(() {
                        timeSlotSelectedIndex = index;
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                            color: dateAndSlots[dateSelectedIndex]
                                    .timeSlots[index]
                                    .enabled
                                ? timeSlotSelectedIndex == index
                                    ? const Color(0xff025B5D)
                                    : Colors.white
                                : const Color(0xffCBCBCB).withOpacity(0.5),
                            border: Border.all(
                              color: const Color(0xff757575).withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                              dateAndSlots[dateSelectedIndex]
                                  .timeSlots[index]
                                  .slot,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: dateAndSlots[dateSelectedIndex]
                                              .timeSlots[index]
                                              .enabled
                                          ? timeSlotSelectedIndex == index
                                              ? Colors.white
                                              : Colors.black
                                          : const Color(0xff9F9F9F))),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffE8625D),
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                ),
                onPressed: () => Navigator.pushNamed(context, '/selectAddress'),
                child: Text(
                  'Continue',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                )),
          )
        ],
      ),
    );
  }

  formatDateTime() {
    DateTime now = DateTime.now();
    DateTime startTime = DateTime(now.year, now.month, now.day, 8);
    DateTime endTime = DateTime(now.year, now.month, now.day, 20, 0, 0);
    Duration step = const Duration(minutes: 30);

    List<DateTime> timeSlots = [];

    while (startTime.isBefore(endTime)) {
      DateTime timeIncrement = startTime.add(step);
      timeSlots.add(timeIncrement);
      startTime = timeIncrement;
    }

    for (int i = 0; i < 7; i++) {
      List<TimeSlots> todaysSlots = [];

      for (var element in timeSlots) {
        if (element.day == now.day) {
          if (element.hour > now.hour && element.minute > now.minute) {
            todaysSlots.add(TimeSlots(DateFormat.jm().format(element), true));
          } else {
            todaysSlots.add(TimeSlots(DateFormat.jm().format(element), false));
          }
        } else {
          todaysSlots.add(TimeSlots(DateFormat.jm().format(element), true));
        }
      }

      dateAndSlots.add(BookingDate(now, true, todaysSlots));
      now = DateTime(now.year, now.month, now.day + 1);
    }
  }
}
