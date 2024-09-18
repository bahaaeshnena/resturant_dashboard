import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/features/home/presentation/views/drawer/widgets/stream_builder_card_invoice_true_paid.dart';
import 'package:task/src/features/home/view_models/calender_view_model.dart';

class AllPaidBills extends StatelessWidget {
  const AllPaidBills({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalendarViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Paid Bills'),
        ),
        body: Consumer<CalendarViewModel>(
          builder: (context, calendarViewModel, child) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            calendarViewModel.isCalendarVisible
                                ? Icons.calendar_today
                                : Icons.calendar_today_outlined,
                            size: 50,
                          ),
                          onPressed: () {
                            calendarViewModel.toggleCalendarVisibility();
                          },
                        ),
                        Text(
                          calendarViewModel.getFormattedDate(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                if (calendarViewModel.isCalendarVisible)
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: CalendarDatePicker(
                        initialDate: calendarViewModel.selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        onDateChanged: (date) {
                          calendarViewModel.selectDate(date);
                        },
                      ),
                    ),
                  ),
                const StreamBuilderCardInvoiceTruePaid(),
              ],
            );
          },
        ),
      ),
    );
  }
}
