import 'bank_account.dart';

class StudentAccount extends BankAccount {
  static const double maxBalance = 5000.0;

  StudentAccount(String accountNumber, String holderName)
      : super(accountNumber, holderName, 0.0);

  @override
  String getAccountType() => 'Student Account';

  @override
  bool deposit(double amount) {
    if (amount <= 0) {
      print('Error: Deposit amount must be positive');
      return false;
    }
    if (balance + amount > maxBalance) {
      print('Error: Deposit would exceed maximum balance of \$5000.00');
      return false;
    }
    balance += amount;
    print('Deposited \$${amount.toStringAsFixed(2)}');
    return true;
  }

  @override
  bool withdraw(double amount) {
    if (amount <= 0) {
      print('Error: Withdrawal amount must be positive');
      return false;
    }
    if (amount > balance) {
      print('Error: Insufficient funds');
      return false;
    }
    balance -= amount;
    print('Withdrew \$${amount.toStringAsFixed(2)}');
    return true;
  }
}