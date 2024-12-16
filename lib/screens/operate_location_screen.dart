import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/providers/providers.dart';
import 'package:shoplocalclubcard/screens/screens.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class OperateLocationScreen extends StatelessWidget {
  const OperateLocationScreen({super.key});

  static final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<StampCardNumberProvider>(context);

    // Update the text field whenever the provider's data changes
    _controller.text = provider.cardNumber;

    return Scaffold(
      appBar: CustomAppBar(
        title: "Operate Location",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            _buildCardNumberArea(context, width: width),
          ],
        ),
      ),
    );
  }

  _buildCardNumberArea(BuildContext context, {required double width}) {
    final provider = Provider.of<StampCardNumberProvider>(context);
    return SizedBox(
      width: width,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: CustomTextField(
              hintText: "Membership number",
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.characters.length < 10) {
                  return "minimum 10 digits";
                }
                return null;
              },
            ),
          ),
          const Gap(5),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primary,
              ),
              child: IconButton(
                color: Colors.white,
                onPressed: () {
                  _showBottomSheet(context);
                },
                icon: const Icon(
                  Icons.qr_code_scanner_rounded,
                ),
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            flex: 2,
            child: CustomBtn(
              btnTitle: "   Create \nMemberShip",
              fontSize: AppFontSize.xsmall,
              onPressed: () {
                // Route user to the next screen
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    final provider =
        Provider.of<StampCardNumberProvider>(context, listen: false);
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Scan using Camera'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const QrcodeScanCameraScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Scan from Gallery'),
              onTap: () async {
                Navigator.pop(context); // Close the bottom sheet
                await provider.scanQrCodeFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }
}
