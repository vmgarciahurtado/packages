import '../interface/i_segmentation_repository.dart';
import '../model/segmentation.dart';

class SegmentationService {
  final ISegmentationRepository iSegmentationRepository;

  SegmentationService({required this.iSegmentationRepository});

  Future<Segmentation> getSegmentation(String codeParam) async {
    return await iSegmentationRepository.getSegmentation(codeParam);
  }

  Future<String> getSegment(String typeSurvey, int weighting) async {
    return await iSegmentationRepository.getSegment(typeSurvey, weighting);
  }

  Future<String> getNameSegment(String segment) async {
    return await iSegmentationRepository.getNameSegment(segment);
  }


}
