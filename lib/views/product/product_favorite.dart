import 'package:fasionxt/models/produk.dart';
import 'package:fasionxt/services/apis/produk.dart';
import 'package:fasionxt/views/colors.dart';
import 'package:fasionxt/views/product/product_item.dart';
import 'package:flutter/material.dart';

class ProdukFavoritPage extends StatefulWidget {
  @override
  _ProdukFavoritPageState createState() => _ProdukFavoritPageState();
}

class _ProdukFavoritPageState extends State<ProdukFavoritPage> {
  late Future<List<ProdukHome>> _dataProduk;

  Future<List<ProdukHome>> fetchProduk() async {
    List<ProdukHome> dataProduk = await APIProdukService().getFavoritProduct();
    return dataProduk;
  }

  @override
  void initState() {
    super.initState();
    _dataProduk = fetchProduk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLightRed,
      appBar: AppBar(
        backgroundColor: bgLightRed,
        title: Text("Produk Favorit"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: FutureBuilder<List<ProdukHome>>(
            future: _dataProduk,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 20,
                  runSpacing: 10,
                  children: snapshot.data!.map((produk) {
                    return Container(
                      width: (MediaQuery.of(context).size.width / 2) - 30,
                      child: ItemProduk(
                        product: produk.produk,
                        isFavorite: produk.isFavorit,
                      ),
                    );
                  }).toList(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error fetching products ${snapshot.error}'),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
