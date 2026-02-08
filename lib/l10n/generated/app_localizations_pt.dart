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
      'Isso excluirá suas pontuações e temas desbloqueados. Não pode ser desfeito.';

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
  String get emptyLeaderboard => 'Sem pontuações ainda!';

  @override
  String get tutorialTitle => 'Como jogar';

  @override
  String get tutorialStep1 => 'Arraste os blocos para a grade';

  @override
  String get tutorialStep2 => 'Preencha linhas ou colunas para limpar';

  @override
  String get tutorialStep3 => 'Use o martelo para quebrar blocos';

  @override
  String get tutorialStep4 => 'Não fique sem espaço!';

  @override
  String get clear => 'Limpo!';

  @override
  String get doubleClear => 'Duplo Limpo!';

  @override
  String get tripleClear => 'TRIPLO LIMPO!';

  @override
  String megaClear(int count) {
    return 'MEGA LIMPO! x$count';
  }

  @override
  String get memoryReveal => '👁️ Revelação!';

  @override
  String get zenClear => '🧘 Zen Limpo!';

  @override
  String autoHammer(int count) {
    return '🔨 Martelo Auto! ($count células)';
  }

  @override
  String get risingRow => '⬆️ Linha subindo!';

  @override
  String get autoDrop => '⏰ Queda Auto!';

  @override
  String get endSession => 'Encerrar';

  @override
  String get findingRival => 'PROCURANDO RIVAL...';

  @override
  String matchmakingError(String error) {
    return 'Erro na busca: $error';
  }

  @override
  String get zenSummaryTitle => 'Sessão Zen';

  @override
  String get totalLines => 'Linhas limpas';

  @override
  String get maxCombo => 'Combo Máx';

  @override
  String get blocksPlaced => 'Blocos colocados';

  @override
  String get playTime => 'Tempo de jogo';

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
  String get pvpMode => 'PvP';

  @override
  String get practiceMode => 'Prática';

  @override
  String get skip => 'Pular';

  @override
  String get next => 'Próximo';

  @override
  String get start => 'JOGAR!';
}
