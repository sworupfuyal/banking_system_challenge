import 'bank_account.dart';

class PremiumAccount extends BankAccount implements InterestBearing {
  static const double MINIMUM_BALANCE = 10000.0;
  static const double INTEREST_RATE = 0.05;

  PremiumAccount(String accountNumber, String accountHolderName, double initialBalance)
      : super(accountNumber, accountHolderName, initialBalance);

  @override
  bool withdraw(double amount) {
    if (amount <= 0) {
      print('❌ Invalid withdrawal amount');
      return false;
    }

    if (balance - amount < MINIMUM_BALANCE) {
      print('❌ Cannot withdraw. Minimum balance of \$${MINIMUM_BALANCE} required');
      return false;
    }

    balance -= amount;
    print('✓ Withdrew \$${amount.toStringAsFixed(2)}. New balance: \$${balance.toStringAsFixed(2)}');
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
  double calculateInterest() {
    return balance * INTEREST_RATE;
  }

  @override
  void applyInterest() {
    double interest = calculateInterest();
    balance += interest;
    print('✓ Applied premium interest of \$${interest.toStringAsFixed(2)}');
  }

  @override
  String getAccountType() => 'Premium Account';
}