import 'bank_account.dart';

class CheckingAccount extends BankAccount {
  static const double OVERDRAFT_FEE = 35.0;

  CheckingAccount(String accountNumber, String accountHolderName, double initialBalance)
      : super(accountNumber, accountHolderName, initialBalance);

  @override
  bool withdraw(double amount) {
    if (amount <= 0) {
      print('❌ Invalid withdrawal amount');
      return false;
    }

    balance -= amount;

    if (balance < 0) {
      balance -= OVERDRAFT_FEE;
      print('⚠️  Withdrew \$${amount.toStringAsFixed(2)}');
      print('⚠️  Overdraft fee of \$${OVERDRAFT_FEE} applied');
      print('  New balance: \$${balance.toStringAsFixed(2)}');
    } else {
      print('✓ Withdrew \$${amount.toStringAsFixed(2)}. New balance: \$${balance.toStringAsFixed(2)}');
    }

    return true;
  }

  @override
  bool deposit(double amount) {
    if (amount <= 0) {
      print('❌ Invalid deposit amount');
      return false;
    }

    balance += amount;
    print('✓ Deposited \$${amount.toStringAsFixed(2)}. New balance: \$${balance.toStringAsFixed(2)}');
    return true;
  }

  @override
  String getAccountType() => 'Checking Account';
}