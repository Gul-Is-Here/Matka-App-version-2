// screens/payment_config_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/Menu/PaymentController/paymentSettingsController.dart'
    show PaymentConfigController;

class PaymentConfigScreen extends StatelessWidget {
  final PaymentConfigController _controller =
      Get.put(PaymentConfigController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Configuration'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => Get.find<PaymentConfigController>().onInit(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Gateway Normal Section
            _buildSectionHeader('Payment Configuration'),
            _buildSubHeader('Details Method'),
            _buildKeyValueRow(
              'Amount Configuration',
              'UP1 Lower Amount Limit',
              onEdit: () => _showAmountLimitDialog(),
            ),
            _buildKeyValueRow(
              '${_controller.upiLowerAmountLimit.value}',
              'UP1 Status',
            ),
            _buildStatusRow(
              _controller.upiStatus.value,
              onToggle: _controller.toggleUPIStatus,
            ),
            const Divider(thickness: 1.5),

            // Bank Account Details Section
            _buildSubHeader('Bank Account Details'),
            _buildKeyValueRow(
              'Bank Name',
              'Account holder name',
              onEdit: () => _showBankDetailsDialog(),
            ),
            _buildKeyValueRow(
              _controller.bankName.value,
              _controller.accountHolderName.value,
            ),
            _buildKeyValueRow(
              'Account number',
              'IFSC Code',
              onEdit: () => _showBankDetailsDialog(),
            ),
            _buildKeyValueRow(
              _controller.accountNumber.value,
              _controller.ifscCode.value,
            ),
            _buildStatusRow(
              _controller.bankStatus.value,
              onToggle: _controller.toggleBankStatus,
            ),
            const Divider(thickness: 1.5),

            // QR Code Section
            _buildSubHeader('QR Code'),
            _buildKeyValueRow(
              'Image Selection',
              'UP1 ID',
              onEdit: () => _showUPIIdDialog(),
            ),
            _buildKeyValueRow(
              'Choose Image',
              _controller.upiId.value,
            ),
            Row(
              children: [
                Expanded(
                  child: _buildButton(
                    'Browse',
                    onPressed: _controller.pickQRImage,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildButton(
                    'Name',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            _buildStatusRow(
              _controller.qrStatus.value,
              onToggle: _controller.toggleQRStatus,
            ),
            const SizedBox(height: 8),
            Obx(() => Text(_controller.qrImageUrl.value)),
            const Divider(thickness: 1.5),

            // Admin & Result Section
            _buildSubHeader('Admin & Rises Molders'),
            _buildKeyValueRow('Declare Result', ''),
            const Divider(thickness: 1.5),

            // Starline Section
            _buildSubHeader('Starline'),
            _buildKeyValueRow('GallDesswear', ''),
            const Divider(thickness: 1.5),

            // Payment Gateway List
            _buildSectionHeader('Payment Gateway List'),
            _buildSubHeader('Ads Payment Gateway'),
            _buildPaymentGatewayTable(),
            const Divider(thickness: 1.5),

            // UPI List
            _buildSectionHeader('UPI List'),
            _buildSubHeader('Add to'),
            _buildUpiTable(),
            const Divider(thickness: 1.5),

            // Payment Method Videos
            _buildSectionHeader('Payment Method Video & Notice List'),
            _buildSubHeader('Show'),
            _buildVideoTable(),
          ],
        ),
      ),
    );
  }

  // Dialog Methods
  void _showBankDetailsDialog() {
    Get.defaultDialog(
      title: 'Edit Bank Details',
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller.bankNameController,
              decoration: const InputDecoration(labelText: 'Bank Name'),
            ),
            TextField(
              controller: _controller.accountHolderController,
              decoration: const InputDecoration(labelText: 'Account Holder'),
            ),
            TextField(
              controller: _controller.accountNumberController,
              decoration: const InputDecoration(labelText: 'Account Number'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _controller.ifscCodeController,
              decoration: const InputDecoration(labelText: 'IFSC Code'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _controller.updateBankDetails,
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _showUPIIdDialog() {
    Get.defaultDialog(
      title: 'Edit UPI ID',
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _controller.upiIdController,
          decoration: const InputDecoration(labelText: 'UPI ID'),
        ),
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _controller.updateUPIDetails,
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _showAmountLimitDialog() {
    Get.defaultDialog(
      title: 'Edit Amount Limit',
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _controller.amountLimitController,
          decoration: const InputDecoration(labelText: 'Amount Limit'),
          keyboardType: TextInputType.number,
        ),
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _controller.updateAmountLimit,
          child: const Text('Save'),
        ),
      ],
    );
  }

  // UI Component Methods
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSubHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildKeyValueRow(String left, String right, {VoidCallback? onEdit}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              left,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(right)),
          if (onEdit != null)
            IconButton(
              icon: const Icon(Icons.edit, size: 18),
              onPressed: onEdit,
            ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String status, {VoidCallback? onToggle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Expanded(child: Text('Status')),
          Expanded(
            child: InkWell(
              onTap: onToggle,
              child: Text(
                status,
                style: TextStyle(
                  color: status == 'Active' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Text('Gate'),
          if (onToggle != null)
            IconButton(
              icon: Icon(
                status == 'Active' ? Icons.toggle_on : Icons.toggle_off,
                color: status == 'Active' ? Colors.green : Colors.red,
                size: 30,
              ),
              onPressed: onToggle,
            ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, {required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(text),
    );
  }

  Widget _buildPaymentGatewayTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Show')),
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Settings')),
      ],
      rows: [
        DataRow(cells: [
          const DataCell(Text('#')),
          const DataCell(Text('Pay_date')),
          const DataCell(Text('2.taofieadPREVJ74aADEC0Mx6kamurTvafbtrlW')),
        ]),
        DataRow(cells: [
          const DataCell(Text('#')),
          const DataCell(Text('Indcpay')),
          const DataCell(Text('41087441DBbaa06b3f8d7fcdc62')),
        ]),
      ],
    );
  }

  Widget _buildUpiTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Show')),
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Settings')),
          DataColumn(label: Text('RESEARCH')),
          DataColumn(label: Text('TYPE')),
          DataColumn(label: Text('COUNT')),
          DataColumn(label: Text('STATUS')),
          DataColumn(label: Text('EDIT')),
        ],
        rows: [
          DataRow(cells: [
            const DataCell(Text('#')),
            const DataCell(Text('Grappati hardware')),
            const DataCell(Text('htdmmpaaj x0017296x02x01009040588@uh')),
            const DataCell(Text('SIPP')),
            const DataCell(Text('Small Amount')),
            const DataCell(Text('20')),
            const DataCell(
                Text('Active', style: TextStyle(color: Colors.green))),
            DataCell(IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {},
            )),
          ]),
          // Add more rows as needed
        ],
      ),
    );
  }

  Widget _buildVideoTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('#')),
          DataColumn(label: Text('PAYMENT METHOD')),
          DataColumn(label: Text('VIDEO')),
          DataColumn(label: Text('NOTICE')),
          DataColumn(label: Text('CREATED AT')),
          DataColumn(label: Text('EDIT')),
        ],
        rows: [
          DataRow(cells: [
            const DataCell(Text('1')),
            const DataCell(Text('Bank Account')),
            const DataCell(Text('http://commendatastorage.googleapis.com...')),
            const DataCell(Text('Hello by...')),
            const DataCell(Text('2024-04-26 09:59:54')),
            DataCell(IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {},
            )),
          ]),
          // Add more rows as needed
        ],
      ),
    );
  }
}
