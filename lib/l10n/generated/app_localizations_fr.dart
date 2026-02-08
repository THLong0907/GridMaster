// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Grid Master';

  @override
  String get score => 'SCORE';

  @override
  String get highScore => 'MEILLEUR SCORE';

  @override
  String get gameOver => 'FIN DE PARTIE';

  @override
  String get newHighScore => 'NOUVEAU RECORD !';

  @override
  String get playAgain => 'REJOUER';

  @override
  String get home => 'ACCUEIL';

  @override
  String get share => 'PARTAGER';

  @override
  String get settings => 'Paramètres';

  @override
  String get sound => 'Son';

  @override
  String get haptics => 'Vibrations';

  @override
  String get resetProgress => 'Réinitialiser';

  @override
  String get resetConfirmTitle => 'Réinitialiser ?';

  @override
  String get resetConfirmContent =>
      'Cela supprimera vos meilleurs scores et thèmes débloqués. Cette action est irréversible.';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get save => 'Enregistrer';

  @override
  String get changeName => 'Changer le nom';

  @override
  String get enterName => 'Entrez votre nom';

  @override
  String get leaderboard => 'Classement';

  @override
  String get loading => 'Chargement...';

  @override
  String get error => 'Erreur';

  @override
  String get emptyLeaderboard => 'Pas encore de scores !';

  @override
  String get tutorialTitle => 'Comment jouer';

  @override
  String get tutorialStep1 => 'Glissez les blocs sur la grille';

  @override
  String get tutorialStep2 =>
      'Remplissez des lignes ou colonnes pour les effacer';

  @override
  String get tutorialStep3 => 'Utilisez le marteau pour casser des blocs';

  @override
  String get tutorialStep4 => 'Ne manquez pas d\'espace !';

  @override
  String get clear => 'Effacé !';

  @override
  String get doubleClear => 'Double Effacé !';

  @override
  String get tripleClear => 'TRIPLE EFFACÉ !';

  @override
  String megaClear(int count) {
    return 'MEGA EFFACÉ ! x$count';
  }

  @override
  String get memoryReveal => '👁️ Révélation !';

  @override
  String get zenClear => '🧘 Zen Effacé !';

  @override
  String autoHammer(int count) {
    return '🔨 Marteau Auto ! ($count cases)';
  }

  @override
  String get risingRow => '⬆️ Ligne montante !';

  @override
  String get autoDrop => '⏰ Chute Auto !';

  @override
  String get endSession => 'Terminer';

  @override
  String get findingRival => 'RECHERCHE D\'UN RIVAL...';

  @override
  String matchmakingError(String error) {
    return 'Erreur de recherche : $error';
  }

  @override
  String get zenSummaryTitle => 'Session Zen';

  @override
  String get totalLines => 'Lignes effacées';

  @override
  String get maxCombo => 'Combo Max';

  @override
  String get blocksPlaced => 'Blocs placés';

  @override
  String get playTime => 'Temps de jeu';

  @override
  String get easyMode => 'Facile';

  @override
  String get memoryMode => 'Mémoire';

  @override
  String get classicMode => 'Classique';

  @override
  String get masterMode => 'Maître';

  @override
  String get zenMode => 'Zen';

  @override
  String get survivalMode => 'Survie';

  @override
  String get pvpMode => 'PvP';

  @override
  String get practiceMode => 'Entraînement';

  @override
  String get skip => 'Passer';

  @override
  String get next => 'Suivant';

  @override
  String get start => 'JOUER !';
}
