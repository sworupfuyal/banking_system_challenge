import 'bank.dart';
import 'bank_account.dart';

void main() {
  print('🏦 WELCOME TO DART BANKING SYSTEM\n');

  Bank bank = Bank('Dart National Bank');

  print('\n📋 CREATING ACCOUNTS');
  print('═' * 50);

  var savings = bank.createAccount('savings', 'Alice Johnson', 1000);
  print('');
  var checking = bank.createAccount('checking', 'Bob Smith', 500);
  print('');
  var premium = bank.createAccount('premium', 'Charlie Davis', 15000);

  print('\n\n💰 TESTING DEPOSITS');
  print('═' * 50);
  savings.deposit(200);
  checking.deposit(300);
  premium.deposit(5000);

  print('\n\n💸 TESTING WITHDRAWALS');
  print('═' * 50);
  savings.withdraw(100);
  print('');
  savings.withdraw(200);
  print('');
  savings.withdraw(300);
  print('');
  savings.withdraw(50);

  print('\n');
  checking.withdraw(900);

  print('\n');
  premium.withdraw(2000);

  print('\n\n📈 APPLYING INTEREST');
  print('═' * 50);
  if (savings is InterestBearing) {
    InterestBearing savingsInterest = savings as InterestBearing;
    print('${savings.accountHolderName}\'s Savings Account:');
    print('Interest: \${savingsInterest.calculateInterest().toStringAsFixed(2)}');
    savingsInterest.applyInterest();
  }

  print('');
  if (premium is InterestBearing) {
    InterestBearing premiumInterest = premium as InterestBearing;
    print('${premium.accountHolderName}\'s Premium Account:');
    print('Interest: \${premiumInterest.calculateInterest().toStringAsFixed(2)}');
    premiumInterest.applyInterest();
  }

  print('\n\n🔄 TESTING TRANSFERS');
  print('═' * 50);
  bank.transferMoney(savings.accountNumber, checking.accountNumber, 150);

  print('\n');
  bank.generateReport();
}