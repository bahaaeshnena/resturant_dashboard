// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:task/src/features/home/models/invoice_model.dart';
import 'package:task/src/features/home/presentation/views/home/widgets/card_invoice.dart';

class StreamBuilderCardInvoicePageView extends StatelessWidget {
  const StreamBuilderCardInvoicePageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('invoices').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No invoices found.'));
        }

        final invoices = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;

          return InvoiceModel.fromMap(data);
        }).toList();

        return ExpandablePageView(
          scrollDirection: Axis.horizontal,
          children: invoices.map((invoice) {
            return CardInvoice(
              tableName: invoice.table.name!,
              invoiceId: invoice.id ?? 'Unknown ID',
              date: invoice.date != null
                  ? '${invoice.date!.day} ${_getMonthName(invoice.date!.month)}, ${invoice.date!.year}'
                  : 'Unknown date',
              totalPrice: invoice.totalPrice,
              onPay: () async {},
            );
          }).toList(),
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
