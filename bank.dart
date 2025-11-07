import 'dart:math';
import 'bank_account.dart';
import 'savings_account.dart';
import 'checking_account.dart';
import 'premium_account.dart';

class Bank {
  final String _bankName;
  final List<BankAccount> _accounts = [];

  Bank(this._bankName);

  String get bankName => _bankName;

  BankAccount createAccount(String type, String accountHolderName, double initialBalance) {
    String accountNumber = _generateAccountNumber();
    BankAccount? account;

    switch (type.toLowerCase()) {
      case 'savings':
        if (initialBalance < SavingsAccount.MINIMUM_BALANCE) {
          print('❌ Minimum initial balance for Savings Account is \$${SavingsAccount.MINIMUM_BALANCE}');
          throw Exception('Insufficient initial balance');
        }
        account = SavingsAccount(accountNumber, accountHolderName, initialBalance);
        break;
      case 'checking':
        account = CheckingAccount(accountNumber, accountHolderName, initialBalance);
        break;
      case 'premium':
        if (initialBalance < PremiumAccount.MINIMUM_BALANCE) {
          print('❌ Minimum initial balance for Premium Account is \$${PremiumAccount.MINIMUM_BALANCE}');
          throw Exception('Insufficient initial balance');
        }
        account = PremiumAccount(accountNumber, accountHolderName, initialBalance);
        break;
      default:
        print('❌ Invalid account type');
        throw Exception('Invalid account type');
    }

    _accounts.add(account);
    print('✓ Account created successfully!');
    account.displayAccountInfo();
    return account;
  }

  BankAccount? findAccount(String accountNumber) {
    try {
      return _accounts.firstWhere((account) => account.accountNumber == accountNumber);
    } catch (e) {
      return null;
    }
  }

  bool transferMoney(String fromAccountNumber, String toAccountNumber, double amount) {
    BankAccount? fromAccount = findAccount(fromAccountNumber);
    BankAccount? toAccount = findAccount(toAccountNumber);

    if (fromAccount == null) {
      print('❌ Source account not found');
      return false;
    }

    if (toAccount == null) {
      print('❌ Destination account not found');
      return false;
    }

    print('\n🔄 Initiating transfer...');
    print('From: ${fromAccount.accountHolderName} (${fromAccount.accountNumber})');
    print('To: ${toAccount.accountHolderName} (${toAccount.accountNumber})');
    print('Amount: \$${amount.toStringAsFixed(2)}');
    print('');

    if (fromAccount.withdraw(amount)) {
      if (toAccount.deposit(amount)) {
        print('✓ Transfer completed successfully!');
        return true;
      } else {
        fromAccount.deposit(amount);
        print('❌ Transfer failed. Amount returned to source account.');
        return false;
      }
    } else {
      print('❌ Transfer failed. Unable to withdraw from source account.');
      return false;
    }
  }

  void generateReport() {
    print('\n');
    print('═' * 50);
    print('${_bankName.toUpperCase()} - ACCOUNTS REPORT');
    print('═' * 50);
    print('Total Accounts: ${_accounts.length}');
    print('');

    double totalBalance = 0;
    Map<String, int> accountTypeCounts = {};

    for (var account in _accounts) {
      account.displayAccountInfo();
      totalBalance += account.balance;

      String type = account.getAccountType();
      accountTypeCounts[type] = (accountTypeCounts[type] ?? 0) + 1;
    }

    print('═' * 50);
    print('SUMMARY');
    print('─' * 50);
    accountTypeCounts.forEach((type, count) {
      print('$type: $count');
    });
    print('─' * 50);
    print('Total Balance Across All Accounts: \$${totalBalance.toStringAsFixed(2)}');
    print('═' * 50);
  }

  String _generateAccountNumber() {
    Random random = Random();
    return '${random.nextInt(9000) + 1000}${random.nextInt(9000) + 1000}';
  }

  List<BankAccount> getAllAccounts() => _accounts;
}