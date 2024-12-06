import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/models/models.dart';
import 'package:shoplocalclubcard/utils/utils.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class UpdateUserProfile extends StatefulWidget {
  const UpdateUserProfile({super.key});

  @override
  State<UpdateUserProfile> createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {
  late TextEditingController _nameController,
      _emailController,
      _countryIdController,
      _zipCodeController;

  late FocusNode _nameFocusNode,
      _emailFocusNode,
      _countryIdFocusNode,
      _zipCodeFocusNode;
  final ValueNotifier<File?> profileImageNotifier = ValueNotifier<File?>(null);
  final _formKey = GlobalKey<FormState>();
  late ValueNotifier<bool> _buttonLoadingNotifier;
  UserProfileModel userProfile = UserProfileModel.instance;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: userProfile.name);
    _emailController = TextEditingController(text: userProfile.email);
    _countryIdController =
        TextEditingController(text: userProfile.country!.name);
    _zipCodeController = TextEditingController(text: userProfile.zipcode);
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _countryIdFocusNode = FocusNode();
    _zipCodeFocusNode = FocusNode();
    _buttonLoadingNotifier = ValueNotifier(false);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _countryIdController.dispose();
    _zipCodeController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _countryIdFocusNode.dispose();
    _zipCodeFocusNode.dispose();
    _buttonLoadingNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('country is : ${userProfile.country!.name!}');
    return Scaffold(
      appBar: const CustomAppBar(
        isIconNeeded: false,
        title: 'Update Profile',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                _buildProfileAvatar(userProfile.avatar),
                const Gap(20),
                const Gap(10),
                const CustomText(
                  title: 'Name',
                ),
                const Gap(3),
                CustomTextField(
                  controller: _nameController,
                  hintText: 'your name',
                  keyboardType: TextInputType.name,
                  focusNode: _nameFocusNode,
                  autofillHints: const [AutofillHints.name],
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (p0) =>
                      FocusScope.of(context).requestFocus(_emailFocusNode),
                  validator: (value) => nameValidator(value),
                  prefixIcon: const Icon(
                    Icons.person_outline_sharp,
                  ),
                ),
                const Gap(10),
                const CustomText(
                  title: 'Email',
                ),
                const Gap(3),
                CustomTextField(
                  controller: _emailController,
                  readOnly: true,
                  hintText: 'your email',
                  keyboardType: TextInputType.emailAddress,
                  focusNode: _emailFocusNode,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  onFieldSubmitted: (p0) =>
                      FocusScope.of(context).requestFocus(_emailFocusNode),
                  validator: (value) => emailValidator(value),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                  ),
                ),
                const Gap(20),
                const CustomText(
                  title: 'Country Id',
                ),
                const Gap(3),
                DropdownButtonFormField(
                  items: getDropdownCountries(),
                  value: userProfile.country!.name!,
                  onChanged: (value) {
                    _countryIdController.text = value as String;
                    FocusScope.of(context).requestFocus(_zipCodeFocusNode);
                  },
                  focusNode: _countryIdFocusNode,
                  validator: (value) =>
                      valueNotSelectedValidator(value as String),
                  hint: const CustomText(
                    title: '    Select country',
                    fontWeight: FontWeight.w400,
                    fontSize: AppFontSize.small,
                  ),
                  decoration: InputDecoration(
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    constraints: const BoxConstraints(maxHeight: 50),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.grey),
                    ),
                  ),
                ),
                const Gap(10),
                const CustomText(
                  title: 'Post/Zip Code',
                ),
                const Gap(3),
                CustomTextField(
                  controller: _zipCodeController,
                  hintText: 'Postal/Zip code',
                  keyboardType: TextInputType.number,
                  focusNode: _zipCodeFocusNode,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.postalCode],
                  validator: (value) => valueNotSelectedValidator(value),
                  onFieldSubmitted: (p0) => _zipCodeFocusNode.unfocus(),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                  ),
                ),
                const Gap(5),
                const Gap(20),
                ValueListenableBuilder<bool>(
                  valueListenable: _buttonLoadingNotifier,
                  builder: (context, isLoading, child) => CustomBtn(
                    btnTitle: isLoading ? 'Updating...' : 'Update Profile',
                    isLoading: isLoading,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _buttonLoadingNotifier.value = true;
                        await ProfileApi.updateUserProfile(
                          zipCode: _zipCodeController.text,
                          name: _nameController.text,
                          avatar: profileImageNotifier.value,
                          countryId: AllCountries.getCounrtyId(
                              _countryIdController.text),
                        );
                        _buttonLoadingNotifier.value = false;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to build profile avatar
  Widget _buildProfileAvatar(String? profileUrl) {
    final ImagePicker picker = ImagePicker();

    Future<void> pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        profileImageNotifier.value = File(pickedFile.path);
      }
    }

    return ValueListenableBuilder<File?>(
      valueListenable: profileImageNotifier,
      builder: (context, file, child) {
        return Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: file != null
                    ? FileImage(file)
                    : profileUrl != null && profileUrl.isNotEmpty
                        ? CachedNetworkImageProvider(
                            profileUrl,
                          )
                        : const AssetImage('assets/images/profile_icon.png')
                            as ImageProvider,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: pickImage,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  List<DropdownMenuItem<Object>>? getDropdownCountries() {
    return AllCountries.list
        .map(
          (country) => DropdownMenuItem<Object>(
            value: country,
            alignment: Alignment.center,
            child: CustomText(title: country),
          ),
        )
        .toList();
  }
}
