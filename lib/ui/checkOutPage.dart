import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Order Summary', // You can display the order summary here
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _simulatePayment(context); // Call the simulatePayment function when the button is pressed
              },
              child: Text('Proceed to Pay'),
            ),
          ],
        ),
      ),
    );
  }

  void _simulatePayment(BuildContext context) {
    // Simulate payment process
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Thank you for your purchase!'), // Confirmation message
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Navigate back to the previous page (CartPage)
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
