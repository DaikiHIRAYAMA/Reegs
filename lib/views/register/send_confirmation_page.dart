import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reegs/views/profiles/profile_page.dart';

class SendConfirmationPage extends StatefulWidget {
  final String eiResult;
  final String nsResult;
  final String ftResult;
  final String jpResult;

  SendConfirmationPage(
      this.eiResult, this.nsResult, this.ftResult, this.jpResult);

  @override
  _SendConfirmationPageState createState() => _SendConfirmationPageState();
}

class _SendConfirmationPageState extends State<SendConfirmationPage> {
  bool _isLoading = false; // Add a loading state

  @override
  void initState() {
    super.initState();
    sendData();
  }

  Future<void> sendData() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    // Create a Firestore instance
    final firestore = FirebaseFirestore.instance;

    try {
      // Add a new document to your collection
      await firestore.collection('your-collection-name').add({
        'ei_result': widget.eiResult,
        'ns_result': widget.nsResult,
        'ft_result': widget.ftResult,
        'jp_result': widget.jpResult,
        // add more fields as needed
      });

      setState(() {
        _isLoading = false; // Stop loading
      });

      // Then navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyProfilePage(),
        ),
      );
    } catch (error) {
      print('An error occurred while saving the data: $error');

      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator() // Show a loading spinner
            : Text('Error occurred, please try again'), // Show error message
      ),
    );
  }
}
