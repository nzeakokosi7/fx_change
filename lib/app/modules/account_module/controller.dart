import 'package:first_ally_demo/app/core/p.dart';
import 'package:first_ally_demo/app/data/models/bank_account.dart';
import 'package:first_ally_demo/app/core/utils/firebase_response.dart';
import 'package:first_ally_demo/app/data/models/bank_list.dart';
import 'package:first_ally_demo/app/data/models/resolved_bank.dart';
import 'package:first_ally_demo/app/data/models/user.dart';
import 'package:first_ally_demo/app/modules/account_module/repository.dart';
import 'package:first_ally_demo/app/routes/pages.dart';
import 'package:first_ally_demo/app/services/_auth.dart';
import 'package:first_ally_demo/app/services/_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_ally_demo/app/core/utils/utils.dart';

class AccountController extends GetxController {
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();

  TextEditingController financialInstitution = TextEditingController();
  TextEditingController accountNo = TextEditingController();

  RxBool loading = false.obs;
  RxList<BankAccount>? accounts = RxList<BankAccount>();
  RxBool incompleteUserData = false.obs;
  Rx<User>? user;
  RxString accName = "".obs;
  BankList bankListResponse = BankList();
  ResolvedBank resolvedBankResponse = ResolvedBank();
  final _selectedBank =  "Abbey Mortgage Bank".obs;

  get selectedBank => _selectedBank.value;
  set selectedBank(value) => _selectedBank.value = value;

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
      resolveAccountNumber(accountNo.text, getBankWithName(selectedBank).code!);
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

  void setUserInfo() {
    fullName.text = user!.value.fullName!;
    email.text = user!.value.email!;
    phone.text = user!.value.phone!;
  }

  void checkAndRetrieveUser() async {
    NetworkResponse<User> res =
    await DatabaseService.getUser(AuthService.user!.uid);

    if(res.data!=null) {
      user = res.data!.obs;
      print("logged in as ${user!.value.email}");
    } else {
      incompleteUserData.value = true;
      // Get.offAllNamed(Routes.ACCOUNT_INFO);
      Get.snackbar('Error', "Please provide your account information",
          backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void addUserData() async {
    await DatabaseService.storeUser(User()
      ..id = AuthService.user!.uid
      ..fullName = fullName.text
      ..email = email.text
      ..phone = phone.text
    );
  }

   void getAccounts() {
    accounts!.bindStream(DatabaseService.getAccountsStream());
  }

  Future<void> changePassword() async {
    loading.value = true;
    NetworkResponse<bool> r = await AuthService.changePassword(oldPassword.text, newPassword.text);
    loading.value = false;
    if(r.verify()) {
      Get.snackbar('Success', "Your password was changed successfully",
          backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);

      await Future.delayed(const Duration(milliseconds: 1500));
      await AuthService.signOut();
    }
    // Get.toNamed(Routes.ACCOUNT_SETTING);
  }

  Future<void> addAccount() async {
    loading.value = true;
    await DatabaseService.addBank(BankAccount()
      ..financialInstitution= selectedBank
      ..accountNumber= accountNo.text
      ..accountName= resolvedBankResponse.data!.accountName!
      ..currencySymbol = P.conversion.selectedCurrency
      ..currency = P.conversion.getCurrencyWithAbbr(P.conversion.selectedCurrency).fullName
    );
    loading.value = false;
    Get.snackbar('Success', "Your bank information has been added successfully",
        backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
    accountNo.text = "";
    accName = "".obs;
    P.conversion.checkAccounts();
    await Future.delayed(const Duration(milliseconds: 1500));
    Navigator.pop(context);
  }

  Future<void> removeBank(BankAccount bankAccount) async {
    await DatabaseService.removeBank(bankAccount);
    Get.snackbar('Success', "Your bank information has been removed",
        backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> updateUser() async {
    if(incompleteUserData.isTrue) {
      addUserData();
      incompleteUserData.value = false;
    } else {
      loading.value = true;
      await DatabaseService.updateUser(User()
        ..id = AuthService.user!.uid
        ..fullName = fullName.text
        ..email = email.text
        ..phone = phone.text
      );

      loading.value = false;
      checkAndRetrieveUser();
      Get.snackbar('Success', "Your account information has been updated successfully",
          backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
      await Future.delayed(const Duration(milliseconds: 1500));
      Get.offAllNamed(Routes.ACCOUNT_SETTING);
    }

  }

  @override
  void onInit() {
    super.onInit();
    if(AuthService.isLoggedIn()) {
      checkAndRetrieveUser();
      getAccounts();
    }
  }


}