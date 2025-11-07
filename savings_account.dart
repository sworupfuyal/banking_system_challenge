import 'bank_account.dart';

class SavingsAccount extends BankAccount implements InterestBearing {
  static const double MINIMUM_BALANCE = 500.0;
  static const double INTEREST_RATE = 0.02;
  static const int MAX_WITHDRAWALS = 3;

  int _withdrawalsThisMonth = 0;

  SavingsAccount(String accountNumber, String accountHolderName, double initialBalance)
      : super(accountNumber, accountHolderName, initialBalance);

  @override
  bool withdraw(double amount) {
    if (amount <= 0) {
      print('❌ Invalid withdrawal amount');
      return false;
    }

    if (_withdrawalsThisMonth >= MAX_WITHDRAWALS) {
      print('❌ Withdrawal limit reached for this month');
      return false;
    }

    if (balance - amount < MINIMUM_BALANCE) {
      print('❌ Cannot withdraw. Minimum balance of \$${MINIMUM_BALANCE} required');
      return false;
    }

    balance -= amount;
    _withdrawalsThisMonth++;
    print('✓ Withdrew \$${amount.toStringAsFixed(2)}. New balance: \$${balance.toStringAsFixed(2)}');
    print('  Withdrawals this month: $_withdrawalsThisMonth/$MAX_WITHDRAWALS');
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
    print('✓ Applied interest of \$${interest.toStringAsFixed(2)}');
  }

  @override
  String getAccountType() => 'Savings Account';

  void resetMonthlyWithdrawals() {
    _withdrawalsThisMonth = 0;
  }

  int get withdrawalsThisMonth => _withdrawalsThisMonth;
}