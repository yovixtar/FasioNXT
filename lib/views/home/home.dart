import 'package:flutter/material.dart';
import 'package:fasionxt/models/kategori.dart';
import 'package:fasionxt/models/produk.dart';
import 'package:fasionxt/services/apis/kategori.dart';
import 'package:fasionxt/services/apis/produk.dart';
import 'package:fasionxt/views/colors.dart';
import 'package:fasionxt/views/product/product_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Kategori>> _dataKategori;
  late Future<List<ProdukHome>> _dataProduk;
  String activeCategory = 'All';
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _dataKategori = fetchKategori();
    _dataProduk = fetchProduk();
  }

  Future<List<Kategori>> fetchKategori() async {
    List<Kategori> dataKategori = await APIKategoriService().getAllCategory();
    return dataKategori;
  }

  Future<List<ProdukHome>> fetchProduk() async {
    List<ProdukHome> dataProduk = await APIProdukService().getAllProductHome();
    return dataProduk;
  }

  List<ProdukHome> filterProducts(List<ProdukHome> products) {
    if (activeCategory != 'All') {
      products = products
          .where((product) => product.produk.idKategori == activeCategory)
          .toList();
    }
    if (searchText.isNotEmpty) {
      products = products
          .where((product) => product.produk.nama
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLightRed,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Image.asset(
                        'assets/images/icon-app.png',
                        width: 40,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/icon-profile.jpeg',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Match Your Style',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 40,
                      child: FutureBuilder<List<Kategori>>(
                        future: _dataKategori,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Kategori> kategoriList = [
                                  Kategori(id: 'All', nama: 'Semua')
                                ] +
                                snapshot.data!;

                            return ListView(
                              scrollDirection: Axis.horizontal,
                              children: kategoriList.map((kategori) {
                                bool isActive = kategori.id == activeCategory;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        activeCategory = kategori.id;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          isActive ? purplePrimary : bgGrey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 5),
                                    ),
                                    child: Text(
                                      kategori.nama,
                                      style: TextStyle(
                                        color: isActive
                                            ? Colors.white
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error fetching categories');
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    FutureBuilder<List<ProdukHome>>(
                      future: _dataProduk,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<ProdukHome> filteredProducts =
                              filterProducts(snapshot.data!);
                          return Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 20,
                            runSpacing: 10,
                            children: filteredProducts.map((produk) {
                              return Container(
                                width: (MediaQuery.of(context).size.width / 2) -
                                    30,
                                child: ItemProduk(
                                  product: produk.produk,
                                  isFavorite: produk.isFavorit,
                                ),
                              );
                            }).toList(),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error fetching products ${snapshot.error}');
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
