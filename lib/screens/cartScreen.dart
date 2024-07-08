import 'package:flutter/material.dart';
import 'package:superstore/apis/models/listOfProductItem.dart';
import 'package:superstore/model/messageRes.dart';
import 'package:superstore/screens/checkoutScreen.dart';

class CartPage extends StatefulWidget {
  const CartPage(
      {super.key,
      required List<Item> cart,
      required void Function(Item product) removeFromCart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void removeFromCart(Item product) {
    cart.remove(product);
    print('${product.name} removed from cart');
  }

  void checkout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CheckoutSuccessPage()),
    );
    setState(() {
      cart.clear();
    });

    success(context: context, message: 'Cart cleared.');
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    String totalPrice = cart.fold('0', (previousValue, product) {
      return (double.parse(previousValue) + product.currentPrice![0].ngn[0])
          .toString();
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          backgroundColor: Color.fromARGB(255, 243, 235, 235),
        ),
        backgroundColor: Color.fromARGB(255, 243, 235, 235),
        body: SingleChildScrollView(
          child: cart.isNotEmpty
              ? Column(
                  children: [
                    Text(
                      "Products in Your cart",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: cart.length,
                      physics: NeverScrollableScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network(
                              'https://api.timbu.cloud/images/${cart[index].photos[index = 0].url}'),
                          title: Text('${cart[index].name}'),
                          subtitle: Text(
                              '\N${cart[index].currentPrice![index = 0].ngn[index = 0].toString()}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              success(
                                  context: context,
                                  message:
                                      '${cart[index].name} removed from cart');
                              setState(() {
                                removeFromCart(cart[index]);
                              });
                            },
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Total Price: \₦$totalPrice',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          checkout();
                        },
                        child: Container(
                          width: 220,
                          height: 45,
                          child: Center(
                            child: Text("checkout".toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800)),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                        ),
                      ),
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    Center(
                      child: Text('Your Cart is Empty'),
                    ),
                  ],
                ),
        ));
  }
}
