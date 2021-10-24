import 'package:first_ally_demo/app/core/p.dart';
import 'package:first_ally_demo/app/core/utils/firebase_response.dart';
import 'package:first_ally_demo/app/data/models/bank_account.dart';
import 'package:first_ally_demo/app/data/models/bank_list.dart';
import 'package:first_ally_demo/app/data/models/resolved_bank.dart';
import 'package:first_ally_demo/app/data/models/supported_currencies.dart';
import 'package:first_ally_demo/app/data/models/transaction_history.dart';
import 'package:first_ally_demo/app/modules/account_module/repository.dart';
import 'package:first_ally_demo/app/routes/pages.dart';
import 'package:first_ally_demo/app/services/_auth.dart';
import 'package:first_ally_demo/app/services/_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ConversionController extends GetxController {
  var publicKey = dotenv.env['PAYSTACK_KEY'];
  final plugin = PaystackPlugin();

  RxString nairaValue = "".obs;
  RxBool loading = false.obs;
  RxList<BankAccount>? accounts = RxList<BankAccount>();
  RxList<TransactionHistory>? transactions = RxList<TransactionHistory>();
  RxString currentDate = "".obs;
  RxString currentTime = "".obs;

  final TextEditingController inAppTextController = TextEditingController();
  TextEditingController accountNo = TextEditingController();

  final _selectedIndex = 0.obs;

  get selectedIndex => _selectedIndex.value;
  set selectedIndex(index) => _selectedIndex.value = index;


  final RxString _selectedBank =  "1".obs;
  final _selectedBankFromPaystack =  "Abbey Mortgage Bank".obs;
  final _selectedCurrency =  "\$".obs;

  get selectedBank => _selectedBank.value;
  set selectedBank(value) => _selectedBank.value = value;

  get selectedBankFromPaystack => _selectedBankFromPaystack.value;
  set selectedBankFromPaystack(value) => _selectedBankFromPaystack.value = value;

  get selectedCurrency => _selectedCurrency.value;
  set selectedCurrency(value) => _selectedCurrency.value = value;
  var formatter = NumberFormat('#,##,###');

  RxString accName = "".obs;
  BankList bankListResponse = BankList();
  ResolvedBank resolvedBankResponse = ResolvedBank();


  List<SupportedCurrencies> getSupportedCurrencies() {
    var _currencies = <SupportedCurrencies>[];

    SupportedCurrencies sp = SupportedCurrencies()
        ..abbr = "USD"
        ..fullName = "United States Dollar"
        ..rate = 500
        ..symbol = "\$";


    SupportedCurrencies sp1 = SupportedCurrencies()
        ..abbr = "GBP"
        ..fullName = "Great Britain Pounds"
        ..rate = 600
        ..symbol = "£";


    SupportedCurrencies sp2 = SupportedCurrencies()
        ..abbr = "EUR"
        ..fullName = "Euros"
        ..rate = 700
        ..symbol = "€";


    _currencies.add(sp);
    _currencies.add(sp1);
    _currencies.add(sp2);

    return _currencies;

  }

  SupportedCurrencies getCurrencyWithAbbr(String symbol) {
    return getSupportedCurrencies().where((element) => element.symbol == symbol).single;
  }

  void checkAccounts() async {
    P.account.getAccounts();
    NetworkResponse<List<BankAccount>> res =
        await DatabaseService.getBankAccounts();
    if (res.verify()) {
      if(res.data!.isNotEmpty) {
        _selectedBank.value = res.data![0].id!;
        accounts!.bindStream(DatabaseService.getAccountsStream());
      }
    }
  }
  
  BankAccount getAccountWithId(String id) {
    return accounts!.where((element) => element.id == id).single;
  }
  // void insertText(String myText) {
  //   final text = inAppTextController.text;
  //   var textSelection = inAppTextController.selection;
  //   var newText = text.replaceAll(selectedCurrency, "").replaceAll(",", "").replaceRange(
  //     textSelection.start,
  //     textSelection.end,
  //     myText,
  //   );
  //   var formatter = NumberFormat('#,##,###');
  //   newText = selectedCurrency+formatter.format(int.parse(newText));
  //   textSelection = inAppTextController.selection;
  //
  //   final myTextLength = myText.length;
  //   inAppTextController.text = newText;
  //   inAppTextController.selection = textSelection.copyWith(
  //     baseOffset: textSelection.start + myTextLength,
  //     extentOffset: textSelection.start + myTextLength,
  //   );
  // }
  void getNairaValue() {
    var formatter = NumberFormat('#,###,###');
    String txt = inAppTextController.text;
    if(txt == "") txt = "0";
    nairaValue.value = formatter.format(int.parse(txt)
        * getCurrencyWithAbbr(selectedCurrency).rate!).toString();
  }

  int getAmountToBePaid() {
    String txt = inAppTextController.text;
    return int.parse(txt)
        * getCurrencyWithAbbr(selectedCurrency).rate!;
  }

  void insertText(String myText) {
    final text = inAppTextController.text;
    var textSelection = inAppTextController.selection;
    var newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );

    final myTextLength = myText.length;
    inAppTextController.text = newText;
    inAppTextController.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
    getNairaValue();
  }
  void backspace() {
    final text = inAppTextController.text;
    final textSelection = inAppTextController.selection;
    final selectionLength = textSelection.end - textSelection.start;
    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      inAppTextController.text = newText;
      inAppTextController.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    inAppTextController.text = newText;
    inAppTextController.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
    getNairaValue();
  }
  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }

  Future<void> fetchBankList() async {
    loading.value = true;
    bankListResponse = await AccountRepository.getBankList();
    accountNo.addListener(accountNumberListener);
    loading.value = false;
    if(!bankListResponse.status!) {
      Get.snackbar('Error', bankListResponse.message!,
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }

  BankData getBankWithName(String bankName) {
    return bankListResponse.data!.where((element) => element.name == bankName).single;
  }

  void accountNumberListener() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (accountNo.text.length == 10) {
      resolveAccountNumber(accountNo.text, getBankWithName(selectedBankFromPaystack).code!);
    }
  }

  void resolveAccountNumber(String accountNumber, String bankCode) async {
    loading.value = true;
    resolvedBankResponse = await AccountRepository.resolveAccount(accountNumber, bankCode);
    if(!resolvedBankResponse.status!) {
      Get.snackbar('Error', resolvedBankResponse.message!,
          backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
      accName = "".obs;
      loading.value = false;
    } else {
      accName = resolvedBankResponse.data!.accountName!.obs;
      loading.value = false;
    }
  }

  Future<bool> charge(context) async {
    Charge charge = Charge()
      ..reference = "kdkd"
      ..amount = (getAmountToBePaid() * 100).toInt()
      ..reference = "${DateTime.now().millisecondsSinceEpoch}"
      ..email = P.account.user!.value.email;

    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );

    print(charge.reference);
    print(charge.additionalParameters);

    Get.snackbar(response.status ? 'Success' : 'Error',
        response.status ? "Payment successfully made" : "Payment Failed",
        backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);

    if(response.status) {
      addTransaction();
    }

    return response.status;
  }

  void addTransaction() async {
    RxString currentDate = DateFormat('d  MMMM, ' 'yyyy').format(DateTime.now()).obs;
    RxString currentTime = DateFormat('HH:mm').format(DateTime.now()).obs;
    if(transactions!.isNotEmpty && transactions!.any((element) => element.date == currentDate.value)) {
      loading.value = true;

      TransactionHistory transactionHistory = transactions!.firstWhere((element) => element.date == currentDate.value);

      if(selectedIndex == 0) {
        transactionHistory.transactions!.add(Transactions()
          ..currencySymbol = getAccountWithId(selectedBank).currencySymbol
          ..accountName = getAccountWithId(selectedBank).accountName
          ..accountNumber = getAccountWithId(selectedBank).accountNumber
          ..financialInstitution = getAccountWithId(selectedBank).financialInstitution
          ..amount = (int.parse(inAppTextController.text)*100).toString()
          ..time = currentTime.value
          ..rate = getCurrencyWithAbbr(getAccountWithId(selectedBank).currencySymbol!).rate.toString()
          ..status = "Pending"
        );

      } else {
        transactionHistory.transactions!.add(Transactions()
          ..currencySymbol = selectedCurrency
          ..accountName = accName.value
          ..accountNumber = accountNo.text
          ..financialInstitution = selectedBankFromPaystack
          ..amount = (int.parse(inAppTextController.text)*100).toString()
          ..time = currentTime.value
          ..rate = getCurrencyWithAbbr(selectedCurrency).rate.toString()
          ..status = "Pending"
        );
      }

      await DatabaseService.updateTransaction(transactionHistory);
      Get.snackbar('Success', "Your transaction has been logged successfully",
          backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
      await Future.delayed(const Duration(milliseconds: 1500));
      loading.value = false;
      clearMem();

    } else {
      loading.value = true;

      if(selectedIndex == 0) {
        Transactions transaction = Transactions()
          ..currencySymbol = getAccountWithId(selectedBank).currencySymbol
          ..accountName = getAccountWithId(selectedBank).accountName
          ..accountNumber = getAccountWithId(selectedBank).accountNumber
          ..financialInstitution = getAccountWithId(selectedBank).financialInstitution
          ..amount = (int.parse(inAppTextController.text)*100).toString()
          ..time = currentTime.value
          ..rate = getCurrencyWithAbbr(selectedCurrency).rate.toString()
          ..status = "Pending";

        List<Transactions> trx = [];
        trx.add(transaction);

        TransactionHistory transactionHistory = TransactionHistory()
          ..date = currentDate.value
          ..transactions = trx;

        await DatabaseService.addTransaction(transactionHistory);
        Get.snackbar('Success', "Your transaction has been logged successfully",
            backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
        await Future.delayed(const Duration(milliseconds: 1500));
        loading.value = false;
        clearMem();

      } else {

        Transactions transaction = Transactions()
          ..currencySymbol = selectedCurrency
          ..accountName = accName.value
          ..accountNumber = accountNo.text
          ..financialInstitution = selectedBankFromPaystack
          ..amount = (int.parse(inAppTextController.text)*100).toString()
          ..time = currentTime.value
          ..rate = getCurrencyWithAbbr(selectedCurrency).rate.toString()
          ..status = "Pending";

        List<Transactions> trx = [];
        trx.add(transaction);

        TransactionHistory transactionHistory = TransactionHistory()
          ..date = currentDate.value
          ..transactions = trx;

        await DatabaseService.addTransaction(transactionHistory);
        Get.snackbar('Success', "Your transaction has been logged successfully",
            backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
        await Future.delayed(const Duration(milliseconds: 1500));
        loading.value = false;
        clearMem();
      }
    }

  }

  void clearMem() {
    accName.value = "";
    selectedCurrency = "\$";
    accountNo.text = "";
    selectedBankFromPaystack = "Abbey Mortgage Bank";
    P.home.selectedIndex = 1;
    Get.offNamed(Routes.HOME);
  }

  @override
  void onInit() {
    super.onInit();
    if(AuthService.isLoggedIn()) {
      checkAccounts();
      plugin.initialize(publicKey: publicKey!);
      transactions!.bindStream(DatabaseService.getTransactionStream());
    }
  }
}