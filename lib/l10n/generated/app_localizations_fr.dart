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
  String get gameOver => 'PARTIE TERMINÉE';

  @override
  String get newHighScore => 'NOUVEAU RECORD !';

  @override
  String get playAgain => 'REJOUER';

  @override
  String get home => 'ACCUEIL';

  @override
  String get share => 'PARTAGER';

  @override
  String get restart => 'RESTART';

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
  String get emptyLeaderboard => 'Aucun score !';

  @override
  String get tutorialTitle => 'Comment jouer';

  @override
  String get tutorialStep1 => 'Glissez les blocs sur la grille';

  @override
  String get tutorialStep2 => 'Remplissez des lignes ou colonnes';

  @override
  String get tutorialStep3 => 'Utilisez le marteau pour casser';

  @override
  String get tutorialStep4 => 'Ne manquez pas de place !';

  @override
  String get clear => 'Bravo !';

  @override
  String get doubleClear => 'Double !';

  @override
  String get tripleClear => 'TRIPLE !';

  @override
  String megaClear(int count) {
    return 'MÉGA ! x$count';
  }

  @override
  String get memoryReveal => 'Memory Reveal!';

  @override
  String get zenClear => 'Zen Clear!';

  @override
  String autoHammer(int count) {
    return 'Auto Hammer! ($count cells)';
  }

  @override
  String get risingRow => 'Rising Row!';

  @override
  String get autoDrop => 'Auto Drop!';

  @override
  String get endSession => 'Terminer';

  @override
  String get findingRival => 'RECHERCHE D\'UN RIVAL...';

  @override
  String matchmakingError(String error) {
    return 'Erreur de matchmaking : $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'Lignes effacées';

  @override
  String get maxCombo => 'Combo max';

  @override
  String get blocksPlaced => 'Blocs placés';

  @override
  String get playTime => 'Temps de jeu';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

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
  String get pvpMode => 'Combat PvP';

  @override
  String get practiceMode => 'Entraînement';

  @override
  String get skip => 'Passer';

  @override
  String get next => 'Suivant';

  @override
  String get start => 'JOUER !';

  @override
  String get stats => 'Statistiques';

  @override
  String get achievements => 'Succès';

  @override
  String get music => 'Musique';

  @override
  String get themes => 'Thèmes';

  @override
  String get language => 'Langue';

  @override
  String get chooseLanguage => 'Choisir la langue';

  @override
  String get autoDevice => 'Auto (Appareil)';

  @override
  String get data => 'Données';

  @override
  String best(int score) {
    return 'Meilleur : $score';
  }

  @override
  String get easyDesc => 'Petite grille, petits blocs';

  @override
  String get classicDesc => 'Lignes montantes, vite !';

  @override
  String get masterDesc => 'Chute auto, vitesse !';

  @override
  String get memoryDesc => 'Blocs invisibles, mémorisez !';

  @override
  String get zenDesc => 'Détente, pas de défaite';

  @override
  String get pvpDesc => 'Duel 1v1 en 2 minutes';

  @override
  String get pvpRankedSubtitle => 'Match aléatoire avec de vrais joueurs';

  @override
  String get pvpPracticeSubtitle => 'Jouer seul contre un BOT • Non classé';

  @override
  String get soloPvp => 'Solo PvP';

  @override
  String gridInfo(int size) {
    return 'Grille $size×$size • 2 min';
  }

  @override
  String get dailyChallenge => 'Défi quotidien';

  @override
  String get dailyChallengeSubtitle => 'Nouveau défi chaque jour !';

  @override
  String get streak => 'Série';

  @override
  String get completed => 'Terminé';

  @override
  String get play => 'JOUER';

  @override
  String get noConnection => 'Pas de connexion';

  @override
  String get tetEffects => 'Effets du Nouvel An';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'REPRENDRE';

  @override
  String get quit => 'QUITTER';

  @override
  String get paused => 'EN PAUSE';

  @override
  String get newFeatures => 'Nouveautés';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get pvpWin => 'YOU WIN!';

  @override
  String get pvpLose => 'YOU LOSE';

  @override
  String get pvpDraw => 'DRAW';

  @override
  String get uploading => 'Uploading...';

  @override
  String get uploadToLeaderboard => 'Upload to Leaderboard';

  @override
  String get scoreUploaded => 'Score uploaded!';

  @override
  String get uploadFailed => 'Upload failed. Check connection.';

  @override
  String get tutorialReset => 'Tutorial will show on next game';

  @override
  String get highScoresCleared => 'All high scores cleared';

  @override
  String get botBeginner => 'Beginner';

  @override
  String get botPro => 'Professional';

  @override
  String get botDestroyer => 'Destroyer';

  @override
  String get botGodlike => 'Godlike';

  @override
  String get version => 'Version';

  @override
  String get engine => 'Engine';

  @override
  String get timer => 'TIMER';

  @override
  String get soundSubtitle => 'Game sound effects';

  @override
  String get hapticsSubtitle => 'Vibration feedback';

  @override
  String get musicSubtitle => 'Background music';

  @override
  String get tetSubtitle => 'Tet visual effects';

  @override
  String get tutorialSubtitle => 'Show tutorial again';

  @override
  String get resetSubtitle => 'Clear all high scores';

  @override
  String get shareScore => 'SHARE SCORE';

  @override
  String get you => 'YOU';

  @override
  String get rival => 'RIVAL';
}
