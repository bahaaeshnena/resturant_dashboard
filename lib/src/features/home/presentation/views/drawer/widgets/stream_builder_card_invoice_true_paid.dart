import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/src/features/home/models/invoice_model.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/card_invoice.dart';
import 'package:task/src/features/home/view_models/calender_view_model.dart';
import 'package:task/src/features/home/view_models/invoice_view_model.dart';

class StreamBuilderCardInvoiceTruePaid extends StatelessWidget {
  const StreamBuilderCardInvoiceTruePaid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final calendarViewModel = Provider.of<CalendarViewModel>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('invoices').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return SliverFillRemaining(
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const SliverFillRemaining(
            child: Center(child: Text('No invoices found.')),
          );
        }

        final selectedDateString = calendarViewModel.getFormattedDate();

        final invoices = snapshot.data!.docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>?;

          final invoiceDateString = data?['date'] as String?;
          final invoiceDate = invoiceDateString != null
              ? DateTime.parse(invoiceDateString)
              : null;

          final selectedDate = DateTime.parse(selectedDateString);

          return data != null &&
              (data['paid'] as bool?) == true &&
              invoiceDate != null &&
              invoiceDate.year == selectedDate.year &&
              invoiceDate.month == selectedDate.month &&
              invoiceDate.day == selectedDate.day;
        }).map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return InvoiceModel.fromMap(data);
        }).toList();

        if (invoices.isEmpty) {
          return const SliverFillRemaining(
            child: Center(child: Text('No paid invoices available.')),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final invoice = invoices[index];
              return Consumer<InvoiceViewModel>(
                builder: (context, value, child) {
                  return CardInvoice(
                    tableName: invoice.table.name ?? 'Unknown Table',
                    invoiceId: invoice.id ?? 'Unknown ID',
                    date: invoice.date != null
                        ? '${invoice.date!.day} ${_getMonthName(invoice.date!.month)}, ${invoice.date!.year}'
                        : 'Unknown date',
                    totalPrice: invoice.totalPrice,
                    items: invoice.items,
                    onPay: () async {
                      await value.updateInvoicePaid(invoice.id ?? '', false);
                    },
                    text: 'UnPaid',
                  );
                },
              );
            },
            childCount: invoices.length,
          ),
        );
      },
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month - 1];
  }
}
