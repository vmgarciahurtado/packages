import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../lang/messages.dart';
import '../../../../../../shared/assets/assets.dart';
import '../../../../../../shared/colors/colors.dart';
import '../../../../../../shared/styles/text_styles.dart';
import '../../../../../../shared/widgets/custom_button.dart';
import '../../../../../../shared/widgets/custom_card.dart';
import '../../../../../../shared/widgets/separator.dart';
import '../../../../util/dynamic_form_globals.dart' as globals;

import 'package:image_picker/image_picker.dart';

import '../view_model/photo_answer_vm.dart';
import '../widgets/photo_answer_model.dart';

class ViewPhotoAnswerComponent extends StatelessWidget {
  ViewPhotoAnswerComponent({Key? key, required this.title}) : super(key: key);

  final PhotoAnswerViewModel viewModel = Get.find(tag: globals.tag);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyles.subHeadLineStyle(isBold: true, color: Colors.black),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Row(
          children: [
            Obx(() => Text(
                  "${viewModel.minPhotoText.value} - ${viewModel.maxPhotoText.value}",
                  style: TextStyles.caption2Style(
                      isBold: true, color: Colors.black),
                ))
          ],
        ),
        SizedBox(
          height: Get.height * 0.4,
          child: CustomCard(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Obx(() {
                    return viewModel.largeImage.value;
                  }),
                ),
              ),
            ),
            color: Colors.grey.shade200,
          ),
        ),
        Obx(() {
          return SizedBox(
            width: Get.width * 0.8,
            child: Center(
              child: Text(
                viewModel.photoName.value,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.captionStyle(),
              ),
            ),
          );
        }),
        const Separator(size: 2),
        Obx(() {
          return Visibility(
            visible: viewModel.isButtonVisible.value,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: Get.width * 0.4,
                child: CustomButton(
                    leftIcon: AssetImage(Res.icons.cameraIcon),
                    backgroundColor: Colores.primaryGray,
                    onPressed: () =>
                        viewModel.getImage(source: ImageSource.camera),
                    text: Messages.appText.capture),
              ),
              const SizedBox(
                height: 10,
                width: 10,
              ),
              SizedBox(
                width: Get.width * 0.4,
                child: CustomButton(
                    backgroundColor: Colores.primaryGray,
                    leftIcon: AssetImage(Res.icons.galleryIcon),
                    onPressed: () =>
                        viewModel.getImage(source: ImageSource.gallery),
                    text: Messages.appText.select),
              ),
            ]),
          );
        }),
        Obx(() {
          return Visibility(
            visible: !viewModel.isButtonVisible.value,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: Get.width * 0.4,
                height: Get.height * 0.07,
                child: CustomButton(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    leftIcon: AssetImage(Res.icons.equisIcon),
                    onPressed: () => viewModel.cancelAddImage(),
                    text: Messages.appText.cancel),
              ),
              const SizedBox(
                height: 10,
                width: 10,
              ),
              SizedBox(
                width: Get.width * 0.4,
                height: Get.height * 0.07,
                child: CustomButton(
                    leftIcon: AssetImage(Res.icons.clipIcon),
                    onPressed: () => viewModel.addImageToList(),
                    text: Messages.appText.add),
              ),
            ]),
          );
        }),
        const Separator(size: 1),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Divider(
            color: Colores.primaryGray,
            height: 1,
            thickness: 1,
          ),
        ),
        Obx(() {
          return SizedBox(
            height: Get.height * 0.2,
            width: Get.width * 0.8,
            child: ListView.builder(
              controller: viewModel.scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.listPhotos.length,
              itemBuilder: (BuildContext context, int index) {
                return PhotoAnswerModel(
                  position: index,
                  viewModel: viewModel,
                );
              },
            ),
          );
        })
      ],
    );
  }
}
