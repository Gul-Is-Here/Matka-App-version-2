import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../controller/Menu/AppSettingsController/appSettingsController.dart'
    show SettingsController;

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1A237E),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: controller.saveSettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUpiPaymentSection(),
            const SizedBox(height: 24),
            _buildTimeSettingsSection(context),
            const SizedBox(height: 24),
            _buildAmountSettingsSection(context),
            const SizedBox(height: 24),
            _buildWithdrawalSettingsSection(),
            const SizedBox(height: 24),
            _buildAppDetailsSection(),
            const SizedBox(height: 24),
            _buildMessagesSection(),
            const SizedBox(height: 24),
            _buildAppLinksSection(),
            const SizedBox(height: 24),
            _buildAppMessagesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildUpiPaymentSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'UPI Payment Settings',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildTextFieldWithLabel(
              label: 'UPI Payment ID',
              controller: controller.upiIdController,
            ),
            const SizedBox(height: 12),
            _buildTextFieldWithLabel(
              label: 'UPI Name',
              controller: controller.upiNameController,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSettingsSection(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Time Settings',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTimePickerField(
                    context: context,
                    label: 'Market Open Time',
                    time: controller.marketOpenTime.value,
                    onTap: () =>
                        _selectTime(context, controller.marketOpenTime),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTimePickerField(
                    context: context,
                    label: 'Play Open Time',
                    time: controller.playOpenTime.value,
                    onTap: () => _selectTime(context, controller.playOpenTime),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountSettingsSection(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount Settings',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildAmountRangeRow(
              label: 'Deposit Amount',
              minValue: controller.minDeposit.value,
              maxValue: controller.maxDeposit.value,
              onMinChanged: (value) => controller.minDeposit.value = value,
              onMaxChanged: (value) => controller.maxDeposit.value = value,
            ),
            const SizedBox(height: 12),
            _buildAmountRangeRow(
              label: 'Withdraw Amount',
              minValue: controller.minWithdraw.value,
              maxValue: controller.maxWithdraw.value,
              onMinChanged: (value) => controller.minWithdraw.value = value,
              onMaxChanged: (value) => controller.maxWithdraw.value = value,
            ),
            const SizedBox(height: 12),
            _buildAmountRangeRow(
              label: 'Bid Amount',
              minValue: controller.minBidAmount.value,
              maxValue: controller.maxBidAmount.value,
              onMinChanged: (value) => controller.minBidAmount.value = value,
              onMaxChanged: (value) => controller.maxBidAmount.value = value,
            ),
            const SizedBox(height: 12),
            _buildTimePickerField(
              context: context,
              label: 'Bid Close Time',
              time: controller.bidCloseTime.value,
              onTap: () => _selectTime(context, controller.bidCloseTime),
            ),
            const SizedBox(height: 12),
            _buildAmountRangeRow(
              label: 'Transfer Amount',
              minValue: controller.minTransfer.value,
              maxValue: controller.maxTransfer.value,
              onMinChanged: (value) => controller.minTransfer.value = value,
              onMaxChanged: (value) => controller.maxTransfer.value = value,
            ),
            const SizedBox(height: 12),
            _buildTextFieldWithLabel(
              label: 'Joining Bonus',
              controller: TextEditingController(
                  text: controller.joiningBonus.value.toString()),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.joiningBonus.value = int.parse(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWithdrawalSettingsSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Withdrawal Settings',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => _buildCheckbox(
                  label: 'Allow Sunday Withdraw Request',
                  value: controller.allowSundayWithdraw.value,
                  onChanged: (value) =>
                      controller.allowSundayWithdraw.value = value!,
                )),
            const SizedBox(height: 8),
            Obx(() => _buildCheckbox(
                  label: 'Allow Saturday Withdraw Request',
                  value: controller.allowSaturdayWithdraw.value,
                  onChanged: (value) =>
                      controller.allowSaturdayWithdraw.value = value!,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildAppDetailsSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Details',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildTextFieldWithLabel(
              label: 'App Link',
              controller: controller.appLinkController,
            ),
            const SizedBox(height: 12),
            _buildTextFieldWithLabel(
              label: 'Sponsor Link',
              controller: controller.sponsorLinkController,
            ),
            const SizedBox(height: 16),
            Text(
              'Share Message',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            _buildMultilineTextField(
              controller: controller.shareMessageController,
              hintText: 'Enter share message',
            ),
            const SizedBox(height: 16),
            Text(
              'Admin Message',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            _buildMultilineTextField(
              controller: controller.adminMessageController,
              hintText: 'Enter admin message',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Messages',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Add Fund Message',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            _buildMultilineTextField(
              controller: controller.addFundMessageController,
              hintText: 'Enter fund message',
            ),
            const SizedBox(height: 16),
            Text(
              'Withdraw Message',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            _buildMultilineTextField(
              controller: controller.withdrawMessageController,
              hintText: 'Enter withdraw message',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppLinksSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Links',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextFieldWithLabel(
                    label: 'App Link 1',
                    controller: controller.appLink1Controller,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextFieldWithLabel(
                    label: 'App Link 2',
                    controller: controller.appLink2Controller,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextFieldWithLabel(
                    label: 'Status',
                    controller: controller.appLink3Controller,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppMessagesSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Messages',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'App Notice Message',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            _buildMultilineTextField(
              controller: controller.appNoticeMessageController,
              hintText: 'Enter app notice message',
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome Message',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            _buildMultilineTextField(
              controller: controller.welcomeMessageController,
              hintText: 'Enter welcome message',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldWithLabel({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMultilineTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),
    );
  }

  Widget _buildAmountRangeRow({
    required String label,
    required int minValue,
    required int maxValue,
    required void Function(int) onMinChanged,
    required void Function(int) onMaxChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: TextEditingController(text: minValue.toString()),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    onMinChanged(int.parse(value));
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Min',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: TextEditingController(text: maxValue.toString()),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    onMaxChanged(int.parse(value));
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Max',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimePickerField({
    required BuildContext context,
    required String label,
    required String time,
    required void Function() onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  time,
                  style: GoogleFonts.poppins(),
                ),
                const Spacer(),
                const Icon(Icons.access_time, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckbox({
    required String label,
    required bool value,
    required void Function(bool?) onChanged,
  }) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.poppins(),
        ),
      ],
    );
  }

  Future<void> _selectTime(BuildContext context, RxString time) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _parseTime(time.value),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1A237E),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      time.value = picked.format(context);
    }
  }

  TimeOfDay _parseTime(String timeString) {
    final format = DateFormat('hh:mm a');
    final dateTime = format.parse(timeString);
    return TimeOfDay.fromDateTime(dateTime);
  }
}
