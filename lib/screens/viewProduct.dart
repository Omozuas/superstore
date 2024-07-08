import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:provider/provider.dart';
import 'package:superstore/apis/models/listOfProductItem.dart';
import 'package:superstore/apis/timbu_api.dart';
import 'package:superstore/model/messageRes.dart';

class ViewProductPage extends StatefulWidget {
  const ViewProductPage({super.key, this.id, this.itemPrice});
  final id;
  final itemPrice;
  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  @override
  void initState() {
    super.initState();

    getAproduct();
  }

  var name = '';
  Item2? item2;
  void getAproduct() {
    var get = Provider.of<ApiProvider>(context, listen: false);
    get.getAProduct(widget.id).then((onValue) => {
          setState(() {
            name = onValue.name;
            item2 = onValue;
          })
        });
  }

  void addTocart(Item2 productModel) async {
    cart2.add(productModel);
    print('${productModel.name} added to cart');
    success(context: context, message: "${productModel.name} added to cart");
  }

  String text = lorem(paragraphs: 1, words: 15);
  String text2 = lorem(paragraphs: 1, words: 10);

  @override
  Widget build(BuildContext context) {
    var get = context.watch<ApiProvider>();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 235, 235),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 243, 235, 235),
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          get.loading
              ? CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${item2!.name}',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Row(
                            children: [
                              Text(
                                "in Stock:",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black.withOpacity(.7)),
                              ),
                              Text(
                                '${item2!.availableQuantity}',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: get.loading
            ? CircularProgressIndicator()
            : Column(
                children: [
                  CarouselSlider(
                    items: item2!.photos
                        .map(
                          (e) => Center(
                              child: Image.network(
                            "https://api.timbu.cloud/images/${e.url}",
                            height: 300,
                          )),
                        )
                        .toList(),
                    options: CarouselOptions(
                        initialPage: 0,
                        viewportFraction: 1,
                        autoPlay: true,
                        height: 250,
                        // aspectRatio: 16 / 2,
                        scrollDirection: Axis.horizontal,
                        autoPlayInterval: Duration(seconds: 7),
                        enlargeCenterPage: true,
                        enlargeFactor: 0.8,
                        autoPlayCurve: Curves.easeIn,
                        disableCenter: true),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item2!.name}'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                'N ${widget.itemPrice}',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('isAvailable: ${item2!.isAvailable}'),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                    width: 50,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Colors.black.withOpacity(0.9))),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orangeAccent,
                                    size: 40,
                                  ),
                                  Text(
                                    "3.5",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    "Ratings and reviews",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                    width: 100,
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                      'see all',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    )),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      color: Color.fromARGB(255, 243, 235, 235),
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Description:",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      item2!.description == null
                                          ? Text(
                                              text2,
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            )
                                          : Text(
                                              item2!.description,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            )
                                    ]),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10, top: 10, bottom: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          "https://api.timbu.cloud/images/${item2!.photos[0].url}")),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(100)),
                                                )),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Omozua Judah",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  "7 July 2024",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black
                                                          .withOpacity(.4)),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amberAccent,
                                              size: 30,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.amberAccent,
                                              size: 30,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.amberAccent,
                                              size: 30,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.amberAccent,
                                              size: 30,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.amberAccent,
                                              size: 30,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      text,
                                      softWrap: true,
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color.fromARGB(255, 243, 235, 235),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
      bottomNavigationBar: Container(
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20, bottom: 5, top: 5),
            child: Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    'Add To Cart',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100))),
            ),
          ),
        ),
        decoration: BoxDecoration(color: Colors.white),
      ),
    );
  }
}
