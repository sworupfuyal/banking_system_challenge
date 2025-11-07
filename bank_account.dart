abstract class InterestBearing {
  double calculateInterest();
  void applyInterest();
}

abstract class BankAccount {
  final String _accountNumber;
  final String _accountHolderName;
  double _balance;

  BankAccount(this._accountNumber, this._accountHolderName, this._balance);

  String get accountNumber => _accountNumber;
  String get accountHolderName => _accountHolderName;
  double get balance => _balance;

  set balance(double value) => _balance = value;

  bool withdraw(double amount);
  bool deposit(double amount);

  void displayAccountInfo() {
    print('─' * 50);
    print('Account Number: $_accountNumber');
    print('Account Holder: $_accountHolderName');
    print('Account Type: ${getAccountType()}');
    print('Current Balance: \$${_balance.toStringAsFixed(2)}');
  }

  String getAccountType() => 'Generic Account';
}