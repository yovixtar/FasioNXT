import 'package:fasionxt/views/orders/order_detail.dart';
import 'package:fasionxt/views/orders/order_recipt.dart';
import 'package:flutter/material.dart';

class OrderItemCard extends StatelessWidget {
  final String status;

  OrderItemCard({required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #12345',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('3 items - \$75.00', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16),
                SizedBox(width: 4),
                Text('July 15, 2024'),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to detail page
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => (status != "Selesai")
                            ? OrderDetailPage(status: status)
                            : EReceiptPage(),
                      ),
                    );
                  },
                  child: Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
