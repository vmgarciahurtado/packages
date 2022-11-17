import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../shared/assets/assets.dart';
import '../../../../../../shared/colors/colors.dart';
import '../../../../../../shared/widgets/custom_card.dart';
import '../view_model/photo_answer_vm.dart';

class PhotoAnswerModel extends StatelessWidget {
  const PhotoAnswerModel(
      {Key? key, required this.position, required this.viewModel})
      : super(key: key);

  final PhotoAnswerViewModel viewModel;
  final int position;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              SizedBox(
                height: Get.height * 0.2,
                width: Get.width * 0.25,
                child: CustomCard(
                  body: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: viewModel.listPhotos[position])),
                  color: Colors.grey.shade200,
                ),
              ),
              Visibility(
                visible: viewModel.equisItemVisibility.value,
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    child: Image(
                      image: AssetImage(Res.icons.equisIcon),
                      width: 30,
                      height: 30,
                      color: Colores.primaryGray,
                    ),
                    onTap: () {
                      viewModel.listPhotos.removeAt(position);
                      viewModel.deleteFileFromDevice(position);
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
