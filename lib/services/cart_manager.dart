import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fasionxt/models/produk.dart';

class CartManager {
  static const String _cartKey = 'cart';

  static Future<void> addToCart(
      Produk product, int quantity, String size) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];

    bool itemExists = false;
    for (int i = 0; i < cart.length; i++) {
      Map<String, dynamic> cartItem = jsonDecode(cart[i]);
      if (cartItem['product']['id'] == product.id && cartItem['size'] == size) {
        cartItem['quantity'] += quantity;
        cart[i] = jsonEncode(cartItem);
        itemExists = true;
        break;
      }
    }

    if (!itemExists) {
      Map<String, dynamic> cartItem = {
        'product': product.toJson(),
        'quantity': quantity,
        'size': size,
      };
      cart.add(jsonEncode(cartItem));
    }

    await prefs.setStringList(_cartKey, cart);
  }

  static Future<List<Map<String, dynamic>>> getCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    return List<Map<String, dynamic>>.from(
        cart.map((item) => jsonDecode(item)));
  }

  static Future<void> updateSizeCart(int index, String size) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    Map<String, dynamic> cartItem = jsonDecode(cart[index]);
    cartItem['size'] = size;
    cart[index] = jsonEncode(cartItem);
    await prefs.setStringList(_cartKey, cart);
  }

  static Future<void> removeFromCart(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    if (index < 0 || index >= cart.length) return;
    cart.removeAt(index);
    await prefs.setStringList(_cartKey, cart);
  }

  static Future<void> clearCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }

  static Future<void> increaseQuantity(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    if (index < 0 || index >= cart.length) return;
    Map<String, dynamic> cartItem = jsonDecode(cart[index]);
    cartItem['quantity'] += 1;
    cart[index] = jsonEncode(cartItem);
    await prefs.setStringList(_cartKey, cart);
  }

  static Future<void> decreaseQuantity(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    if (index < 0 || index >= cart.length) return;
    Map<String, dynamic> cartItem = jsonDecode(cart[index]);
    if (cartItem['quantity'] > 1) {
      cartItem['quantity'] -= 1;
      cart[index] = jsonEncode(cartItem);
    } else {
      cart.removeAt(index);
    }
    await prefs.setStringList(_cartKey, cart);
  }

  static Future<void> removeByProductId(String productId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    cart.removeWhere((item) => jsonDecode(item)['product']['id'] == productId);
    await prefs.setStringList(_cartKey, cart);
  }

  static Future<int> getQuantityByProductId(String productId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    for (String item in cart) {
      Map<String, dynamic> cartItem = jsonDecode(item);
      if (cartItem['product']['id'] == productId) {
        return cartItem['quantity'];
      }
    }
    return 0;
  }

  static Future<int> getQuantityAllProduct() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    num totalQuantity = 0;
    for (String item in cart) {
      Map<String, dynamic> cartItem = jsonDecode(item);
      int quantity = int.parse(cartItem['quantity'].toString());
      totalQuantity += quantity;
    }
    return totalQuantity.toInt();
  }

  static Future<int> getTotalPrice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    num totalPrice = 0;
    for (String item in cart) {
      Map<String, dynamic> cartItem = jsonDecode(item);
      int quantity = int.parse(cartItem['quantity'].toString());
      double harga = double.parse(cartItem['product']['harga'].toString());
      totalPrice += quantity * harga;
    }
    return totalPrice.toInt();
  }
}
