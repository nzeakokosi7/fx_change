

import 'package:first_ally_demo/app/data/models/bank_list.dart';
import 'package:first_ally_demo/app/data/models/resolved_bank.dart';
import 'package:first_ally_demo/app/data/providers/api_provider.dart';

class AccountRepository {
  static final ApiProvider _provider = ApiProvider();

  static Future<BankList> getBankList() async {
    final response = await _provider.getListOfBanks();
    return BankList.fromJson(response);
  }

  static Future<ResolvedBank> resolveAccount(String accountNumber, String bankCode) async {
    final response = await _provider.resolveAccountNumber(accountNumber, bankCode);
    return ResolvedBank.fromJson(response);
  }

}
