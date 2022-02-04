
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../elements/CircularLoadingWidget.dart';
import '../models/wallet_transactions.dart';
import '../Widget/transactionCard.dart';
import '../controllers/wallet_controller.dart';
import '../helpers/helper.dart';

// ignore: must_be_immutable
class RecentTransactions extends StatefulWidget {
  // ignore: non_constant_identifier_names
  String PageType;
  // ignore: non_constant_identifier_names
  RecentTransactions({Key key, this.PageType}) : super(key: key);
  @override
  _RecentTransactionsState createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends StateMVC<RecentTransactions> {

  WalletController _con;

  _RecentTransactionsState() : super(WalletController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForWalletTransaction();

  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 16.0,
              top: 32.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                widget.PageType=='full'? IconButton(
                  icon: Icon(Icons.arrow_back_ios),

                  onPressed: () {
                    Navigator.pop(context);
                  },
                ):Text(''),
               widget.PageType=='full'? Text('Transaction History', style: Theme.of(context).textTheme.headline3):  Text('Recent Transactions', style: Theme.of(context).textTheme.headline3),

                GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/TransactionHistory');
              },child:  widget.PageType=='full'? Container() : Text('See All',style: Theme.of(context).textTheme.headline3.merge(TextStyle(fontWeight: FontWeight.w400))),
            ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: _con.walletTransactionList.isEmpty
                ? CircularLoadingWidget(height: 500)
                :ListView.builder(
              shrinkWrap: true,
              itemCount:  _con.walletTransactionList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index){
               WalletTransactions _walletData =  _con.walletTransactionList.elementAt(index);
                return
                  TransactionCard(
                  transactionId: _walletData.transactions_id,
                  date: _walletData.date,
                  color: _walletData.type=='credit'?Colors.green:Colors.red,
                  letter: _walletData.type=='credit'?'C':'D',
                  title: _walletData.type=='credit'?'Credit':'Debit',
                  subTitle: _walletData.type=='credit'?'Your amount is credited':'Your amount is debited',
                  price: Helper.pricePrint(_walletData.amount),
                );
    }

            ),
          )
        ],
      ),
    );
  }
}
