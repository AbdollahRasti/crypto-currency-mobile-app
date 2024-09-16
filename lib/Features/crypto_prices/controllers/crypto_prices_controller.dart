import 'dart:convert';

import '../models/crypto_prices_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CryptoPricesController extends GetxController {
  var cryptoPrices = <CryptoPricesModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCryptoPrices();
  }

  void fetchCryptoPrices() async {
    try {
      isLoading.value = true;
      var url = Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        print('response 200');
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;

        List<CryptoPricesModel> data = jsonResponse
            .map((json) => CryptoPricesModel.fromJson(json))
            .toList();
        cryptoPrices.value = data;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
