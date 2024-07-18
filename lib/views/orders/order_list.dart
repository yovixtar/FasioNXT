import 'package:fasionxt/views/orders/order_item.dart';
import 'package:flutter/material.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Dikemas'),
            Tab(text: 'Dikirim'),
            Tab(text: 'Selesai'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OrderItemList(status: 'Dikemas'),
          OrderItemList(status: 'Dikirim'),
          OrderItemList(status: 'Selesai'),
        ],
      ),
    );
  }
}

class OrderItemList extends StatelessWidget {
  final String status;

  OrderItemList({required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Sample item count
      itemBuilder: (context, index) {
        return OrderItemCard(status: status);
      },
    );
  }
}
