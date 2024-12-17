import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/providers/providers.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class MembershipCardScreen extends StatefulWidget {
  const MembershipCardScreen({
    super.key,
    required this.shopLocationId,
  });
  final int shopLocationId;

  @override
  State<MembershipCardScreen> createState() => _MembershipCardScreenState();
}

class _MembershipCardScreenState extends State<MembershipCardScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<QrCodeScanningProvider>(context, listen: false);
      provider.clearCardNumber();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<QrCodeScanningProvider>(context);

    // Sync the controller text with the provider's card number
    _controller.text = provider.cardNumber;

    return Scaffold(
      appBar: CustomAppBar(
        title: "Operate Location",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            Gap(30),
            customBodyText("Enter your card membership number"),
            Gap(50),
            CustomTextField(
              hintText: "Membership number",
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                provider.updateCardNumber(value);
              },
              validator: (value) {
                if (value == null || value.characters.length < 13) {
                  return "minimum 13 digits required";
                }
                return null;
              },
            ),
            Gap(30),
            Container(
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primary,
              ),
              child: provider.cardNumber.length >= 13
                  ? CustomBtn(
                      btnTitle: "Go",
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.operateShop,
                          arguments: [
                            widget.shopLocationId,
                            provider.cardNumber
                          ],
                        );
                      },
                    )
                  : IconButton(
                      color: Colors.white,
                      onPressed: () {
                        _showBottomSheet(context);
                      },
                      icon: const Icon(
                        Icons.qr_code_scanner_rounded,
                      ),
                    ),
            ),
            Gap(50),
            CustomBtn(
              btnTitle: "Create MemberShip",
              fontSize: AppFontSize.xsmall,
              onPressed: () {
                // Route user to the next screen
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    final provider =
        Provider.of<QrCodeScanningProvider>(context, listen: false);
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
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.qrCodeScanCamera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Scan from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                await provider.scanQrCodeFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }
}
