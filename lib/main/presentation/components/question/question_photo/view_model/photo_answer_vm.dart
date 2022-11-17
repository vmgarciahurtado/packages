import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../lang/messages.dart';
import '../../../../../../shared/assets/assets.dart';
import '../../../../../../shared/colors/colors.dart';
import '../../../../../../shared/util/util.dart';
import '../../../../../domain/model/dynamic_form_content.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../config/verify_answer_vm.dart';

class PhotoAnswerViewModel extends GetxController {
  DynamicFormContent dynamicFormContent;
  PhotoAnswerViewModel({required this.dynamicFormContent}) {
    configureMinAndMaxPhoto();
  }

  final VerifyAnswerViewModel verifyViewModel = Get.find(tag: globals.tag);
  RxString minPhotoText = ''.obs;
  RxString maxPhotoText = ''.obs;

  RxBool widgetVisibility = false.obs;

  Image defaultImage = Image(
      color: Colores.secondaryGray,
      image: AssetImage(Res.icons.addImageIconSmall));

  Rx<Image> largeImage =
      Image(image: AssetImage(Res.icons.addImageIconSmall)).obs;

  int minPhotos = 1;
  int maxPhotos = 20;

  //'Subir imagenes'
  String tittleModule = Messages.appText.uploadImages;
  RxString photoName = ''.obs;

  RxList<Image> listPhotos = <Image>[].obs;
  RxList<String> listPhotosName = <String>[].obs;
  RxList<String> listPhotosCache = <String>[].obs;
  RxList<String> listPhotosFormFolder = <String>[].obs;

  ScrollController scrollController = ScrollController();

  RxBool isButtonVisible = true.obs;
  RxBool addMorePhotos = true.obs;
  RxBool removeFirstPhoto = true.obs;
  RxBool equisItemVisibility = true.obs;

  void getImage({required ImageSource source}) async {
    if (listPhotos.length < maxPhotos) {
      final file = await ImagePicker().pickImage(
          source: source,
          maxWidth: 640,
          maxHeight: 480,
          imageQuality: 70 //0 - 100
          );

      if (file?.path != null) {
        largeImage.value = Image(
          image: FileImage(File(file!.path)),
          fit: BoxFit.cover,
        );
        isButtonVisible.value = false;
        photoName.value =
            file.name + ' - ' + await Util.device.getFileSize(file.path, 2);

        copyFileInOtherLocation(file.path);
        listPhotosCache.add(file.path);
      }
    } else {
      Get.snackbar(
          Messages.appText.alert,
          //"la cantidad maxima de fotos es $maxPhotos "
          "${Messages.appText.maximumPhotos}$maxPhotos ");
    }
  }

  void configureMinAndMaxPhoto() {
    if (dynamicFormContent.config != null &&
        dynamicFormContent.config!.maxPhotos != null) {
      maxPhotos = Util.data.getInt(dynamicFormContent.config!.maxPhotos!);
      maxPhotoText.value = 'Max: $maxPhotos';
    } else {
      maxPhotoText.value = 'Max: $maxPhotos';
    }

    if (dynamicFormContent.config != null &&
        dynamicFormContent.config!.minPhotos != null) {
      minPhotos = Util.data.getInt(dynamicFormContent.config!.minPhotos!);
      minPhotoText.value = 'Min: $minPhotos';
    } else {
      if (verifyViewModel.isRequired.isTrue) {
        minPhotoText.value = 'Min: 1';
      } else {
        minPhotoText.value = 'Min: 0';
      }
    }
  }

  addImageToList() {
    listPhotos.add(largeImage.value);

    photoName.value = '';
    largeImage.value = defaultImage;

    if ((maxPhotos) >= listPhotos.length) {
      addMorePhotos.value = false;
    } else {
      addMorePhotos.value = true;
    }

    isButtonVisible.value = true;
    verifyResponse();

    Future.delayed(const Duration(milliseconds: 200), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    });
  }

  cancelAddImage() {
    photoName.value = '';
    largeImage.value = defaultImage;
    isButtonVisible.value = true;
    listPhotosCache.removeLast();
    listPhotosFormFolder.removeLast();

    verifyResponse();
  }

  uploadImages() {
    if (listPhotos.length < minPhotos) {
      Get.snackbar(
          Messages.appText.alert,
          //"la cantidad minima de fotos es $minPhotos "
          "${Messages.appText.minimumPhotos}$minPhotos ");
    } else {}
  }

  void deleteFileFromDevice(int position) async {
    var documentDirectory = await getApplicationDocumentsDirectory();
    var directoryPath = documentDirectory.path + "/formimages/";

    final fileCacheFolder = File(listPhotosCache[position]);
    await fileCacheFolder.delete();

    final fileFormFolder = File(directoryPath + listPhotosFormFolder[position]);
    await fileFormFolder.delete();

    listPhotosCache.removeAt(position);
    listPhotosFormFolder.removeAt(position);
    verifyResponse();
  }

  void copyFileInOtherLocation(String pathFile) async {
    var fileName = path.basename(pathFile);

    var documentDirectory = await getApplicationDocumentsDirectory();
    var directoryPath = documentDirectory.path + "/formimages/";
    await Directory(directoryPath).create(recursive: true);

    File newFile = await File(pathFile).copy(directoryPath + fileName);
    listPhotosFormFolder.add(path.basename(newFile.path));
  }

  void verifyResponse() {
    if (listPhotosFormFolder.length >= minPhotos) {
      verifyViewModel.isResponse.value = true;
      verifyViewModel.answer.value =
          '{"value":${jsonEncode(listPhotosFormFolder)}}';
    } else {
      verifyViewModel.isResponse.value = false;
      verifyViewModel.answer.value = '';
    }
  }
}
