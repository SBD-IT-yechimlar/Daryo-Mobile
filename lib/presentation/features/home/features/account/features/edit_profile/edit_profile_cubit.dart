import 'dart:ui';

import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import 'package:daryo/presentation/support/extensions/compressing_exts.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../data/datasource/network/dto/auth/login/login_response.dart';
import '../../../../../../../data/datasource/preference/user_preferences.dart';
import '../../../../../../../data/repositories/account_repository.dart';
import '../../../../../../../domain/models/image/uploadable_file.dart';
import '../../../../../../stream_controllers/update_profile_stream_controller.dart';

part 'edit_profile_cubit.freezed.dart';
part 'edit_profile_state.dart';

@Injectable()
class EditProfileCubit extends BaseCubit<EditProfileState, EditProfileEvent> {
  EditProfileCubit(this._accountRepository, this._userPreferences, this._updateProfileStreamController) : super(const EditProfileState()) {
    getUserInfo();
  }

  final AccountRepository _accountRepository;
  final UserPreferences _userPreferences;
  final UpdateProfileStreamController _updateProfileStreamController;



  void getUserInfo() async {
    final fullName=_userPreferences.username??"";
    final email=_userPreferences.email;
    final avatarPhoto= await _userPreferences.getSavedXFile();
    updateState((state) => state.copyWith(
       name: fullName,
        email: email??"",
      avatar: avatarPhoto,

    ));
  }

  void setSurname(String name) {
    updateState((state) => state.copyWith(name: name));
  }

  void setName(String name) {
    updateState((state) => state.copyWith(name: name));
  }

  void setEmail(String email) {
    updateState((state) => state.copyWith(email: email));
  }

  void setPhone(String phone) {
    updateState((state) => state.copyWith(phone: phone));
  }

  void setPassword(String password) {
    updateState((state) => state.copyWith(password: password));
  }

  Future<void> updateUser() async {
    _userPreferences.setUserInfo(LoginUserRes(
        id: _userPreferences.id??0,
        email: states.email,
        phone: states.phone.clearPhoneNumber(),
        username:states.name
    ));
    _accountRepository
        .updateUser(
        username: states.name,
        phone: states.phone.clearPhoneNumber(),
        email: states.email,
        password: states.password)
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(loadingState: LoadingState.loading));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
              loadingState: LoadingState.success,
          ));
          _userPreferences.setUserInfo(LoginUserRes(
            id: _userPreferences.id??0,
            email: states.email,
            phone: states.phone.clearPhoneNumber(),
            username:states.name
          ));
          _updateProfileStreamController.add(true);
          emitEvent(EditProfileEvent(EditProfileEventType.updateProfile));

        })
        .onError((error) {
          updateState((state) => state.copyWith(loadingState: LoadingState.error));
        })
        .onFinished(() {})
        .executeFuture();
  }


  Future<void> pickHomeImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? newImages = await picker.pickImage(source: ImageSource.gallery);
      if (newImages!=null) {

        final compressed = await newImages.compressPhoto();
        final croppedImage=await _cropImage(compressed);
        if(croppedImage!=null){
          final uploadImage=croppedImage.xFile;
          if(uploadImage!=null){
            _userPreferences.saveXFile(uploadImage);
            updateState((state) => state.copyWith(avatar: uploadImage));
            _updateProfileStreamController.add(true);
          }
        }
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<UploadableFile?> _cropImage(XFile? pickedFile) async {
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "",
            toolbarColor: Color(0xFF0089DA),
            toolbarWidgetColor: Colors.transparent,
            activeControlsWidgetColor:Color(0xFF0089DA),
            initAspectRatio: CropAspectRatioPreset.square,
          //  lockAspectRatio: true,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],
          ),
          IOSUiSettings(
           // aspectRatioLockEnabled: true,
            title: "",
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],
          ),
        ],
      );
      return croppedFile?.toUploadableFileFromCroppedFile();
    }
    return null;
  }



}
