import 'package:crypto_price_tracker/Theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/crypto_prices_controller.dart';

class CryptoPricesView extends StatelessWidget {
  CryptoPricesView({super.key});
  final cryptoPricesController = Get.put(CryptoPricesController());
  final ThemeController themeController = Get.find();

  Future<void> handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    cryptoPricesController.fetchCryptoPrices();
    cryptoPricesController.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crypto Prices Traker',
        ),
        actions: [
          Obx(() {
            return IconButton(
              icon: Icon(
                themeController.isDarkMode.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
                color: themeController.isDarkMode.value
                    ? Colors.white
                    : Colors.black,
              ),
              onPressed: () {
                themeController.toggleTheme();
              },
            );
          }),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await handleRefresh();
        },
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () {
                  if (cryptoPricesController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemCount: cryptoPricesController.cryptoPrices.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Image.network(
                                      cryptoPricesController
                                          .cryptoPrices[index].image,
                                      width: 42,
                                      height: 42,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(Icons.error);
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(cryptoPricesController
                                          .cryptoPrices[index].name),
                                      Row(
                                        children: [
                                          Icon(
                                            cryptoPricesController
                                                        .cryptoPrices[index]
                                                        .priceChangePercentage24H >=
                                                    0
                                                ? Icons.arrow_drop_up_rounded
                                                : Icons.arrow_drop_down_rounded,
                                            color: cryptoPricesController
                                                        .cryptoPrices[index]
                                                        .priceChangePercentage24H >=
                                                    0
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                          Text(
                                            '${cryptoPricesController.cryptoPrices[index].priceChangePercentage24H.toStringAsFixed(2)}%',
                                            style: TextStyle(
                                                color: cryptoPricesController
                                                            .cryptoPrices[index]
                                                            .priceChangePercentage24H >=
                                                        0
                                                    ? Colors.green
                                                    : Colors.red),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$ ${cryptoPricesController.cryptoPrices[index].currentPrice}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    cryptoPricesController
                                        .cryptoPrices[index].symbol,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
