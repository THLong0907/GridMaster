// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Grid Master';

  @override
  String get score => 'PONTOS';

  @override
  String get highScore => 'RECORDE';

  @override
  String get gameOver => 'FIM DE JOGO';

  @override
  String get newHighScore => 'NOVO RECORDE!';

  @override
  String get playAgain => 'JOGAR NOVAMENTE';

  @override
  String get home => 'INÍCIO';

  @override
  String get share => 'COMPARTILHAR';

  @override
  String get restart => 'RESTART';

  @override
  String get settings => 'Configurações';

  @override
  String get sound => 'Som';

  @override
  String get haptics => 'Vibração';

  @override
  String get resetProgress => 'Redefinir progresso';

  @override
  String get resetConfirmTitle => 'Redefinir?';

  @override
  String get resetConfirmContent =>
      'Isso apagará suas pontuações e temas desbloqueados. Não pode ser desfeito.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get save => 'Salvar';

  @override
  String get changeName => 'Alterar nome';

  @override
  String get enterName => 'Digite seu nome';

  @override
  String get leaderboard => 'Classificação';

  @override
  String get loading => 'Carregando...';

  @override
  String get error => 'Erro';

  @override
  String get emptyLeaderboard => 'Sem pontuações!';

  @override
  String get tutorialTitle => 'Como jogar';

  @override
  String get tutorialStep1 => 'Arraste blocos para a grade';

  @override
  String get tutorialStep2 => 'Preencha linhas ou colunas';

  @override
  String get tutorialStep3 => 'Use o martelo para quebrar';

  @override
  String get tutorialStep4 => 'Não fique sem espaço!';

  @override
  String get clear => 'Ótimo!';

  @override
  String get doubleClear => 'Duplo!';

  @override
  String get tripleClear => 'TRIPLO!';

  @override
  String megaClear(int count) {
    return 'MEGA! x$count';
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
  String get endSession => 'Encerrar';

  @override
  String get findingRival => 'PROCURANDO RIVAL...';

  @override
  String matchmakingError(String error) {
    return 'Erro de matchmaking: $error';
  }

  @override
  String get zenSummaryTitle => 'ZEN SESSION ENDED';

  @override
  String get totalLines => 'Linhas eliminadas';

  @override
  String get maxCombo => 'Combo máximo';

  @override
  String get blocksPlaced => 'Blocos colocados';

  @override
  String get playTime => 'Tempo de jogo';

  @override
  String get continueBtn => 'Continue';

  @override
  String get backToLobby => 'Back to Lobby';

  @override
  String get easyMode => 'Fácil';

  @override
  String get memoryMode => 'Memória';

  @override
  String get classicMode => 'Clássico';

  @override
  String get masterMode => 'Mestre';

  @override
  String get zenMode => 'Zen';

  @override
  String get survivalMode => 'Sobrevivência';

  @override
  String get pvpMode => 'Batalha PvP';

  @override
  String get practiceMode => 'Praticar';

  @override
  String get skip => 'Pular';

  @override
  String get next => 'Próximo';

  @override
  String get start => 'JOGAR!';

  @override
  String get stats => 'Estatísticas';

  @override
  String get achievements => 'Conquistas';

  @override
  String get music => 'Música';

  @override
  String get themes => 'Temas';

  @override
  String get language => 'Idioma';

  @override
  String get chooseLanguage => 'Escolher idioma';

  @override
  String get autoDevice => 'Auto (Dispositivo)';

  @override
  String get data => 'Dados';

  @override
  String best(int score) {
    return 'Melhor: $score';
  }

  @override
  String get easyDesc => 'Grade pequena, blocos pequenos';

  @override
  String get classicDesc => 'Linhas subindo, elimine rápido!';

  @override
  String get masterDesc => 'Queda automática, velocidade!';

  @override
  String get memoryDesc => 'Blocos desaparecem, lembre as posições';

  @override
  String get zenDesc => 'Relaxe, sem perder';

  @override
  String get pvpDesc => 'Duelo 1v1 em 2 minutos';

  @override
  String get pvpRankedSubtitle => 'Partida aleatória com jogadores reais';

  @override
  String get pvpPracticeSubtitle => 'Jogar solo contra BOT • Sem ranking';

  @override
  String get soloPvp => 'Solo PvP';

  @override
  String gridInfo(int size) {
    return 'Grade $size×$size • 2 min';
  }

  @override
  String get dailyChallenge => 'Desafio diário';

  @override
  String get dailyChallengeSubtitle => 'Novo desafio todos os dias!';

  @override
  String get streak => 'Sequência';

  @override
  String get completed => 'Concluído';

  @override
  String get play => 'JOGAR';

  @override
  String get noConnection => 'Sem conexão';

  @override
  String get tetEffects => 'Efeitos de Ano Novo';

  @override
  String get pause => 'Pausa';

  @override
  String get resume => 'CONTINUAR';

  @override
  String get quit => 'SAIR';

  @override
  String get paused => 'PAUSADO';

  @override
  String get newFeatures => 'Novidades';

  @override
  String get privacyPolicy => 'Política de privacidade';

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
