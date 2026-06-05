import 'package:flutter/material.dart';
import 'cart_data.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CartData.items.isEmpty

          ? const Center(
              child: Text(
                "Keranjang Masih Kosong",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )

          : ListView.builder(
              itemCount: CartData.items.length,

              itemBuilder: (context, index) {

                var item = CartData.items[index];

                return Card(
                  margin: const EdgeInsets.all(10),

                  child: ListTile(
                    leading: const Icon(
                      Icons.shopping_cart,
                      color: Colors.deepOrange,
                    ),

                    title: Text(item["name"]),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(item["price"]),

                        Text(
                          "Qty : ${item["qty"]}",
                        ),
                      ],
                    ),

                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),

                      onPressed: () {

                        setState(() {
                          CartData.items.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}