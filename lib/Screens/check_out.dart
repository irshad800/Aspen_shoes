import 'package:flutter/material.dart';
import 'package:shoes/Screens/payment_method.dart';

class CheckoutPage extends StatefulWidget {
  final num total;

  CheckoutPage({required this.total});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String contactName = ' ';
  String address = ' ';
  String paymentMethod = '--------';

  TextEditingController contactNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController paymentMethodController = TextEditingController();

  @override
  void initState() {
    super.initState();
    contactNameController.text = contactName;
    addressController.text = address;
    paymentMethodController.text = paymentMethod;
  }

  // Function to update contact info
  void updateContactInfo(String newName) {
    setState(() {
      contactName = newName;
      contactNameController.text = newName;
    });
  }

  // Function to update address
  void updateAddress(String newAddress) {
    setState(() {
      address = newAddress;
      addressController.text = newAddress;
    });
  }

  // Function to update payment method
  void updatePaymentMethod(String newMethod) {
    setState(() {
      paymentMethod = newMethod;
      paymentMethodController.text = newMethod;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Checkout')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Contact Information:'),
            ListTile(
              title: TextFormField(
                controller: contactNameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Edit Name'),
                          content: TextField(
                            controller: contactNameController,
                            decoration: InputDecoration(
                              hintText: 'Enter new name',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                updateContactInfo(contactNameController.text);
                                Navigator.pop(context);
                              },
                              child: Text('Save'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('Address:'),
            ListTile(
              title: TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Edit Address'),
                          content: TextField(
                            controller: addressController,
                            decoration: InputDecoration(
                              hintText: 'Enter new address',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                updateAddress(addressController.text);
                                Navigator.pop(context);
                              },
                              child: Text('Save'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('Payment Method:'),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentMethod(),
                          ));
                    },
                    child: Text("Payement Method"))
              ],
            ),
            SizedBox(height: 20),
            Text('Order Summary:'),
            ListTile(
              title: Text('Subtotal: \$${widget.total.toStringAsFixed(2)}'),
            ),
            ListTile(
              title: Text('Shipping Cost: 40'),
            ),
            Divider(),
            ListTile(
              title: Text('Total: \$${(widget.total + 40).toStringAsFixed(2)}'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Succesfull'),
                    content: Image.asset("assets/images/Frame 271.png"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
