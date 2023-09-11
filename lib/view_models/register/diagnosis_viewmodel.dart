import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reegs/models/register/diagnosis_results.dart';
import 'package:reegs/view_models/register/enneagram_result_viewmodel.dart';
import 'package:reegs/view_models/register/hsp_result_viewmodel.dart';
import 'package:reegs/view_models/register/mbti_result_viewmodel.dart';
import 'package:reegs/view_models/register/psy_result_viewmodel.dart';
import 'package:reegs/view_models/register/soc_result_viewmodel.dart';

class DiagnosisViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<DiagnosisResults> fetchAllResults(WidgetRef ref) async {
    //mbtiの結果取得
    final mbtiResultViewModel = MbtiResultViewModel(ref);
    final mbtiResult = mbtiResultViewModel.result;

    //HSPの結果取得
    final hspResultViewModel = HspResultViewModel(ref);
    final hspResult = hspResultViewModel.result;

    //サイコパスの診断結果
    final psyResultViewModel = PsyResultViewModel(ref);
    final psyResult = psyResultViewModel.result;

    //ソシオパスの診断結果
    final socResultViewModel = SocResultViewModel(ref);
    final socResult = socResultViewModel.result;

    //エニアグラムの診断結果
    final enneagramResultViewModel = EnneagramResultViewModel(ref);
    final enResult = enneagramResultViewModel.result;

    return DiagnosisResults(
      mbtiResult: mbtiResult,
      hspResult: hspResult,
      psyResult: psyResult,
      socResult: socResult,
      enResult: enResult,
    );
  }

  Future<void> saveResultsAndCompleteDiagnosis(WidgetRef ref) async {
    final results = await fetchAllResults(ref);
    final userId = _auth.currentUser!.uid;

    await _firestore.collection('diagnosis-results').doc(userId).set({
      'mbti_result': results.mbtiResult,
      'hsp_result': results.hspResult,
      'psy_result': results.psyResult,
      'soc_result': results.socResult,
      'en_result': results.enResult,
    });
  }
}
