import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superstore/apis/models/listOfProductItem.dart';
import 'package:superstore/apis/timbu_api.dart';
import 'package:superstore/model/messageRes.dart';
import 'package:superstore/screens/viewProduct.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen(
      {super.key,
      required List<Item> cart,
      required void Function(Item product) addToCart});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProduct();
  }

  void addTocart(Item productModel) async {
    cart.add(productModel);
  }

  List<Item> _list = [];

  void getAllProduct() {
    final get = Provider.of<ApiProvider>(context, listen: false);
    get.getProduct().then((value) => {_list = value.items});
  }

  @override
  Widget build(BuildContext context) {
    final get = context.watch<ApiProvider>();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 235, 235),
      appBar: AppBar(
        title: Text('product'),
        backgroundColor: Color.fromARGB(255, 243, 235, 235),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: get.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        mainAxisExtent: 350),
                    itemCount: _list.length,
                    itemBuilder: (BuildContext context, int index) {
                      var product = _list[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewProductPage(
                                        id: product.id,
                                        itemPrice: product
                                            .currentPrice![index = 0]
                                            .ngn[index = 0]
                                            .toString(),
                                      )));
                        },
                        onHover: (value) {},
                        child: Card(
                          color: Colors.white.withOpacity(1),
                          child: Container(
                            // height: 400,
                            width: 240,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, bottom: 5, left: 10, right: 10),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 300,
                                        height: 250,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Center(
                                              child: Image.network(
                                                "https://api.timbu.cloud/images/${product.photos[index = 0].url}",
                                                height: 230,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          left: 0,
                                          top: 10,
                                          child: Container(
                                              width: 40,
                                              height: 30,
                                              child: Center(
                                                  child: Text(
                                                "-20%",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Colors.black))),
                                      Positioned(
                                          right: 0,
                                          top: 10,
                                          child: InkWell(
                                            onTap: () {},
                                            child: Container(
                                                width: 40,
                                                height: 40,
                                                child: Center(
                                                  child: Icon(
                                                    CupertinoIcons.heart,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    color: Colors.black
                                                        .withOpacity(0.9))),
                                          ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\N${product.currentPrice![index = 0].ngn[index = 0].toString()}',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star_border_sharp,
                                            color: Colors.orange,
                                            size: 25,
                                          ),
                                          Text(
                                            "3.5",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "${product.name}",
                                          // overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: TextStyle(
                                              fontSize: 15,
                                              // overflow: TextOverflow.ellipsis,
                                              color:
                                                  Colors.black.withOpacity(.5)),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          addTocart(product);
                                          success(
                                              context: context,
                                              message:
                                                  '${product.name} added to cart');
                                        },
                                        child: Container(
                                            width: 60,
                                            height: 35,
                                            child: Center(
                                              child: Icon(
                                                Icons.shopping_cart_outlined,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Colors.black)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
      )),
    );
  }
}
