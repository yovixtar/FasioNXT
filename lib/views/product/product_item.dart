import 'package:fasionxt/models/produk.dart';
import 'package:fasionxt/services/apis/produk.dart';
import 'package:fasionxt/views/colors.dart';
import 'package:fasionxt/views/product/product_detail.dart';
import 'package:fasionxt/views/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';

class ItemProduk extends StatefulWidget {
  final Produk product;
  final bool isFavorite;

  ItemProduk({required this.product, required this.isFavorite});

  @override
  _ItemProdukState createState() => _ItemProdukState();
}

class _ItemProdukState extends State<ItemProduk> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  handleFavorite() async {
    final result =
        await APIProdukService().favoritProduct(produk_id: widget.product.id);
    if (result.containsKey('success')) {
      SnackbarUtils.showSuccessSnackbar(context, result['success']);
    } else {
      SnackbarUtils.showErrorSnackbar(context, result['error']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: AspectRatio(
                        aspectRatio: 3 / 4,
                        child: Image.network(
                          widget.product.gambar,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                          handleFavorite();
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: heartRed,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  widget.product.nama,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 4),
                Text(
                  'Rp ' +
                      widget.product.harga.replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (Match m) => '${m[1]}.'),
                  style: TextStyle(
                    color: greyPrimary,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                product: widget.product,
                                isFavorite: isFavorite,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bluePrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(
                          'Detail',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
