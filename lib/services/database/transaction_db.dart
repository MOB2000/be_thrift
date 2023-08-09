import 'package:be_thrift/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class TransactionDatabaseService {
  final CustomUser? user;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference _transactionCollection;

  TransactionDatabaseService(this.user) {
    _transactionCollection =
        _db.collection('users').doc(user?.uid).collection('transactions');
  }

  Stream<List<Transaction>> get transactions => _transactionCollection
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((x) {
        return x.docs.map((y) {
          return Transaction.fromJson(y.data() as Map<String, dynamic>);
        }).toList();
      });

  Stream<double> get balance => _transactionCollection.snapshots().map((x) {
        var transactions = x.docs.map((y) {
          return Transaction.fromJson(y.data() as Map<String, dynamic>);
        }).toList();

        return transactions.fold(
            0, (value, element) => (value + element.amount));
      });

  Stream<List<Transaction>> expensesByMonth(DateTime date) {
    var firstDay = DateTime(date.year, date.month, 1);
    var lastDay = DateTime(date.year, date.month + 1, 0);

    return _transactionCollection
        .where('category.type', isEqualTo: 'expense')
        .where('timestamp', isGreaterThanOrEqualTo: firstDay)
        .where('timestamp', isLessThanOrEqualTo: lastDay)
        .snapshots()
        .map((x) {
      return x.docs.map((y) {
        return Transaction.fromJson(y.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  addTransaction(Transaction transaction) async {
    var doc = await _transactionCollection.add(transaction.toJson());
    return doc.update({'id': doc.id});
  }

  updateTransaction(Transaction transaction) {
    return _transactionCollection
        .doc(transaction.id)
        .update(transaction.toJson());
  }

  deleteTransaction(Transaction transaction) async {
    await _transactionCollection.doc(transaction.id).delete();
  }

  Map<String, List<Transaction>> groupTransactionsByDate(
    List<Transaction> transactions,
  ) {
    return groupBy<Transaction, String>(transactions, (txn) {
      return DateFormat('dd MMMM y').format(txn.timestamp);
    });
  }
}
