import 'dart:convert';
import 'package:fasionxt/models/produk.dart';
import 'package:fasionxt/views/colors.dart';
import 'package:flutter/material.dart';

class ItemCart extends StatefulWidget {
  final Produk product;
  final String jumlah;
  final String ukuran;
  final VoidCallback onDelete;
  final void Function(String) onUpdate;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  ItemCart({
    required this.product,
    required this.jumlah,
    required this.ukuran,
    required this.onDelete,
    required this.onUpdate,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  _ItemCartState createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  late int quantity;
  late String size;

  @override
  void initState() {
    super.initState();
    quantity = int.parse(widget.jumlah);
    size = widget.ukuran;
  }

  List<String> _convertStringToList(String sizeString) {
    List<dynamic> sizeList = json.decode(sizeString);
    return sizeList.map((size) => size.toString()).toList();
  }

  void showChangeCartItemDialog(BuildContext context) {
    late List<String> availableSizes =
        _convertStringToList(widget.product.ukuran);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Ganti Pesanan!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Pilih Jumlah Produk"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: quantity > 0
                            ? () {
                                setState(() {
                                  quantity -= 1;
                                });
                                widget.onDecrease();
                              }
                            : null,
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: quantity < int.parse(widget.product.stok)
                            ? () {
                                setState(() {
                                  quantity += 1;
                                });
                                widget.onIncrease();
                              }
                            : null,
                      ),
                    ],
                  ),
                  Text("Pilih Ukuran Produk"),
                  DropdownButton<String>(
                    value: size,
                    items: availableSizes.map((String size) {
                      return DropdownMenuItem<String>(
                        value: size,
                        child: Text(size),
                      );
                    }).toList(),
                    onChanged: (String? newSize) {
                      setState(() {
                        size = newSize!;
                      });
                      widget.onUpdate(size);
                    },
                  ),
                ],
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Tutup",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purplePrimary,
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showChangeCartItemDialog(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: AspectRatio(
                  aspectRatio: 5 / 6,
                  child: Image.network(
                    widget.product.gambar,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.nama,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Rp ' +
                        widget.product.harga.replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]}.'),
                    style: TextStyle(
                      color: greyPrimary,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            widget.jumlah,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            widget.ukuran,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => widget.onDelete(),
                  icon: Icon(
                    Icons.delete_outlined,
                    size: 30,
                    color: purplePrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
