// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickshop_ecommerce/providers/product_bloc.dart';
import 'package:quickshop_ecommerce/models/products_model.dart';
import 'package:quickshop_ecommerce/screens/order_confiremed.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  TextEditingController street = TextEditingController(text: '1');
  TextEditingController house = TextEditingController(text: '1');
  TextEditingController area = TextEditingController(text: 'Khilkhet');
  TextEditingController district = TextEditingController(text: 'Dhaka');
  TextEditingController mobile = TextEditingController(text: '01900000000');
  TextEditingController payment = TextEditingController(text: 'Cash');
  String selectedOption = 'Cash';

  @override
  Widget build(BuildContext context) {
    final pb = context.watch<ProductBloc>();
    List<ProductsModel> productListInCart = pb.productListOfCart;
    double deliveryFee = 40;
    double totalPrice = deliveryFee;
    List<ProductsModel> sortedProductList = productListInCart.toSet().toList();
    for (ProductsModel product in productListInCart) {
      totalPrice += product.price;
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 255),
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          'Your Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 24,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Delivary address',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.edit_outlined,
                            size: 24,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title:
                                        Center(child: Text('Update Address')),
                                    actions: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 120,
                                                  child: TextFormField(
                                                    controller: street,
                                                    // onEditingComplete: _submitForm,
                                                    decoration: InputDecoration(
                                                        hintText: 'street'),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                SizedBox(
                                                  width: 120,
                                                  child: TextFormField(
                                                    controller: house,
                                                    // onEditingComplete: _submitForm,
                                                    decoration: InputDecoration(
                                                        hintText: 'house no'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            TextFormField(
                                              controller: area,
                                              // onEditingComplete: _submitForm,
                                              decoration: InputDecoration(
                                                  hintText: 'area'),
                                            ),
                                            SizedBox(height: 10),
                                            TextFormField(
                                              controller: district,
                                              // onEditingComplete: _submitForm,
                                              decoration: InputDecoration(
                                                  hintText: 'district'),
                                            ),
                                            SizedBox(height: 10),
                                            TextFormField(
                                              controller: mobile,
                                              // onEditingComplete: _submitForm,
                                              decoration: InputDecoration(
                                                  hintText: 'mobile no'),
                                            ),
                                            SizedBox(height: 10),
                                            SizedBox(
                                              width: 100,
                                              height: 35,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    street.text = street.text;
                                                    house.text = house.text;
                                                    area.text = area.text;
                                                    district.text =
                                                        district.text;
                                                    mobile.text = mobile.text;
                                                  });
                                                },
                                                child: Text('Submit'),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                        '${street.text}/${house.text}, ${area.text}, ${district.text}'),
                    SizedBox(height: 12),
                    RichText(
                      text: TextSpan(
                          // text: 'Mobile: 01907072158,',
                          children: [
                            TextSpan(
                              text: 'Mobile: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: mobile.text,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wallet,
                          size: 24,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Payment Method',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            size: 24,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.money_dollar,
                          size: 24,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        DropdownButton<String>(
                          value: selectedOption,
                          items: <DropdownMenuItem<String>>[
                            DropdownMenuItem(
                              value: 'Cash',
                              child: Text('Cash'),
                            ),
                            DropdownMenuItem(
                              value: 'Bkash',
                              child: Text('BKash'),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedOption = newValue!;
                            });
                          },
                        ),
                        Spacer(),
                        Text('\u{09F3}${totalPrice.toString()}'),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.summarize,
                          size: 24,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Order Summery',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 27 * sortedProductList.length.toDouble(),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: sortedProductList.length,
                          itemBuilder: (ctx, index) {
                            ProductsModel singleProduct =
                                sortedProductList[index];
                            List<ProductsModel> thisProductList =
                                productListInCart
                                    .where((product) =>
                                        product.id == singleProduct.id)
                                    .toList();

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              child: Row(
                                children: [
                                  Text(singleProduct.name.length > 18
                                      ? '${thisProductList.length.toString()}x ${singleProduct.name.substring(0, 18)}....'
                                      : '${thisProductList.length.toString()}x ${singleProduct.name}...'),
                                  Spacer(),
                                  Text(
                                      '\u{09F3}${thisProductList.length * singleProduct.price}')
                                ],
                              ),
                            );
                          }),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text('Subtotal'),
                        Spacer(),
                        Text('\u{09F3}${totalPrice - deliveryFee}'),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Delivery fee'),
                        Spacer(),
                        Text('\u{09F3}$deliveryFee'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              SizedBox(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Total'),
                        Text('(incl. VAT)'),
                        Spacer(),
                        Text('Tk \u{09F3}$totalPrice')
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          productListInCart.clear();
                          nextScreen(context, OrderConfirmedPage());
                        },
                        child: Text(
                          'Place Order',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
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
