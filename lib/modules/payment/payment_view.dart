import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_sizes.dart';
import '../../app/widgets/custom_appbar.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/payment_tile.dart';

import 'payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Payment",
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Select Payment Method",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.paymentMethods.length,
                  itemBuilder: (_, index) {

                    final payment =
                    controller.paymentMethods[index];

                    return Card(
                      child: RadioListTile<int>(
                        value: index,
                        groupValue:
                        controller.selectedIndex.value,
                        onChanged: (value) {
                          controller.selectPayment(
                            value!,
                          );
                        },
                        title: Text(payment.title),
                        secondary: Image.asset(
                          payment.icon,
                          width: 35,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            CustomButton(
              text: "Confirm Booking",
              onPressed: controller.confirmPayment,
            ),
          ],
        ),
      ),
    );
  }
}