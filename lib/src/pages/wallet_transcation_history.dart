
import 'package:flutter/material.dart';
import '../components/recentTransactions.dart';

class WalletTransactionHistory extends StatefulWidget {
  @override
  _WalletTransactionHistoryState createState() => _WalletTransactionHistoryState();
}

class _WalletTransactionHistoryState extends State<WalletTransactionHistory> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              RecentTransactions(PageType: 'full'),
            ],
          ),
        ),
      )
    );
  }
}
