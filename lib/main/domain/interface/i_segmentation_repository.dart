import '../model/segmentation.dart';

abstract class ISegmentationRepository {
  Future<Segmentation> getSegmentation(String codeParam);
  Future<String> getSegment(String typeSurvey, int weighting);
  Future<String> getNameSegment(String segment);
}
