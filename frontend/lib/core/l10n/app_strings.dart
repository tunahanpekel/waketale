// lib/core/l10n/app_strings.dart
// Waketale v2 — lightweight localization (no codegen required).
//
// Usage:
//   S.of(context).someKey
//   ref.watch(localeProvider)  ← required in every ConsumerWidget that shows text
//
// Supported: en, tr, es, de, fr, pt
// Adding a new string: add to ALL 6 languages. Missing any = self-QA FAILED.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─── Locale Provider ──────────────────────────────────────────────────────────

const _kLangKey = 'app_language';
const _supportedLangs = ['en', 'tr', 'es', 'de', 'fr', 'pt'];

String deviceLang() {
  final code = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  return _supportedLangs.contains(code) ? code : 'en';
}

// Keep private alias for internal use
String _deviceLang() => deviceLang();

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    _load();
    return Locale(_deviceLang());
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_kLangKey);
    if (saved != null) state = Locale(saved);
  }

  Future<void> setLocale(String languageCode) async {
    state = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLangKey, languageCode);
  }

  bool get isTurkish    => state.languageCode == 'tr';
  bool get isSpanish    => state.languageCode == 'es';
  bool get isGerman     => state.languageCode == 'de';
  bool get isFrench     => state.languageCode == 'fr';
  bool get isPortuguese => state.languageCode == 'pt';
}

// ─── String lookup ────────────────────────────────────────────────────────────

class S {
  const S._(this._locale);
  final Locale _locale;
  String get _lang => _locale.languageCode;
  bool get _tr => _lang == 'tr';
  bool get _es => _lang == 'es';
  bool get _de => _lang == 'de';
  bool get _fr => _lang == 'fr';
  bool get _pt => _lang == 'pt';

  static S of(BuildContext context) => S._(Localizations.localeOf(context));
  static S fromLocale(Locale locale) => S._(locale);
  static S fromLangCode(String langCode) => S._(Locale(langCode));

  // ── Common ───────────────────────────────────────────────────────────────────
  String get commonOk          => _tr ? 'Tamam'        : _es ? 'Aceptar'    : _de ? 'OK'          : _fr ? 'OK'            : _pt ? 'OK'            : 'OK';
  String get commonCancel      => _tr ? 'İptal'        : _es ? 'Cancelar'   : _de ? 'Abbrechen'   : _fr ? 'Annuler'       : _pt ? 'Cancelar'      : 'Cancel';
  String get commonSave        => _tr ? 'Kaydet'       : _es ? 'Guardar'    : _de ? 'Speichern'   : _fr ? 'Enregistrer'   : _pt ? 'Salvar'        : 'Save';
  String get commonContinue    => _tr ? 'Devam Et'     : _es ? 'Continuar'  : _de ? 'Weiter'      : _fr ? 'Continuer'     : _pt ? 'Continuar'     : 'Continue';
  String get commonBack        => _tr ? 'Geri'         : _es ? 'Atrás'      : _de ? 'Zurück'      : _fr ? 'Retour'        : _pt ? 'Voltar'        : 'Back';
  String get commonLoading     => _tr ? 'Yükleniyor..': _es ? 'Cargando...' : _de ? 'Laden...'    : _fr ? 'Chargement...' : _pt ? 'Carregando...' : 'Loading...';
  String get commonError       => _tr ? 'Hata'         : _es ? 'Error'      : _de ? 'Fehler'      : _fr ? 'Erreur'        : _pt ? 'Erro'          : 'Error';
  String get commonRetry       => _tr ? 'Tekrar Dene'  : _es ? 'Reintentar' : _de ? 'Wiederholen' : _fr ? 'Réessayer'     : _pt ? 'Tentar novamente' : 'Try Again';
  String get commonDone        => _tr ? 'Tamamlandı'   : _es ? 'Listo'      : _de ? 'Fertig'      : _fr ? 'Terminé'       : _pt ? 'Concluído'     : 'Done';
  String get commonSkip        => _tr ? 'Atla'         : _es ? 'Omitir'     : _de ? 'Überspringen' : _fr ? 'Ignorer'      : _pt ? 'Pular'         : 'Skip';
  String get commonNext        => _tr ? 'İleri'        : _es ? 'Siguiente'  : _de ? 'Weiter'      : _fr ? 'Suivant'       : _pt ? 'Próximo'       : 'Next';
  String get commonSettings    => _tr ? 'Ayarlar'      : _es ? 'Configuración' : _de ? 'Einstellungen' : _fr ? 'Paramètres' : _pt ? 'Configurações' : 'Settings';
  String get commonGoHome      => _tr ? 'Ana Sayfaya Dön' : _es ? 'Ir al inicio' : _de ? 'Zur Startseite' : _fr ? 'Aller à l\'accueil' : _pt ? 'Ir para o início' : 'Go Home';
  String get commonPageNotFound => _tr ? 'Sayfa Bulunamadı' : _es ? 'Página no encontrada' : _de ? 'Seite nicht gefunden' : _fr ? 'Page introuvable' : _pt ? 'Página não encontrada' : 'Page Not Found';
  String get commonNoInternet  => _tr ? 'İnternet bağlantısı yok' : _es ? 'Sin conexión a internet' : _de ? 'Keine Internetverbindung' : _fr ? 'Pas de connexion internet' : _pt ? 'Sem conexão à internet' : 'No internet connection';

  // ── App name ─────────────────────────────────────────────────────────────────
  String get appName => 'Waketale';

  // ── Onboarding ───────────────────────────────────────────────────────────────
  String get onboardingSlide1Title  => _tr ? 'Uyku sorunun çözümü burada'     : _es ? 'La solución a tu sueño está aquí'  : _de ? 'Die Lösung für deinen Schlaf'     : _fr ? 'La solution pour ton sommeil'        : _pt ? 'A solução para o seu sono'            : 'Your sleep fix starts here';
  String get onboardingSlide1Body   => _tr ? 'Kişiselleştirilmiş CBT-I koçluğu — sadece sana özel.' : _es ? 'Coaching CBT-I personalizado, solo para ti.' : _de ? 'Personalisiertes CBT-I-Coaching – nur für dich.' : _fr ? 'Coaching CBT-I personnalisé, rien que pour toi.' : _pt ? 'Coaching CBT-I personalizado, só para você.' : 'Personalized CBT-I coaching — built just for you.';
  String get onboardingSlide2Title  => _tr ? 'Takip et. Anla. Düzelt.'         : _es ? 'Registra. Comprende. Mejora.'       : _de ? 'Tracken. Verstehen. Verbessern.'   : _fr ? 'Suis. Comprends. Améliore.'           : _pt ? 'Registre. Entenda. Melhore.'          : 'Track. Understand. Improve.';
  String get onboardingSlide2Body   => _tr ? 'Uyku verilerini yorumlayıp her sabah 3 adımlı eylem planın hazır.' : _es ? 'Interpretamos tus datos y tendrás un plan de acción de 3 pasos cada mañana.' : _de ? 'Wir interpretieren deine Daten und liefern jeden Morgen einen 3-Schritte-Plan.' : _fr ? 'On interprète tes données et te prépare un plan en 3 étapes chaque matin.' : _pt ? 'Interpretamos seus dados e preparamos um plano de 3 etapas toda manhã.' : 'We interpret your data and have a 3-step action plan ready every morning.';
  String get onboardingSlide3Title  => _tr ? '50.000+ kişi daha iyi uyuyor'    : _es ? 'Más de 50,000 personas duermen mejor' : _de ? 'Über 50.000 schlafen besser'       : _fr ? 'Plus de 50 000 personnes mieux endormies' : _pt ? 'Mais de 50.000 pessoas dormem melhor' : '50,000+ people sleeping better';
  String get onboardingSlide3Body   => _tr ? 'Sen de başla. Ücretsiz dene.'     : _es ? 'Únete tú también. Prueba gratis.'   : _de ? 'Mach mit. Kostenlos testen.'       : _fr ? 'Rejoins-les. Essaie gratuitement.'     : _pt ? 'Junte-se a eles. Experimente grátis.' : 'Join them. Try it free.';
  String get onboardingCta          => _tr ? 'Ücretsiz Başla'                   : _es ? 'Comenzar gratis'                    : _de ? 'Kostenlos starten'                  : _fr ? 'Commencer gratuitement'               : _pt ? 'Começar gratuitamente'               : 'Start Free';
  String get onboardingSignIn       => _tr ? 'Google ile devam et'              : _es ? 'Continuar con Google'               : _de ? 'Mit Google fortfahren'              : _fr ? 'Continuer avec Google'                : _pt ? 'Continuar com o Google'              : 'Continue with Google';
  String get onboardingSignInApple  => _tr ? 'Apple ile devam et'               : _es ? 'Continuar con Apple'                : _de ? 'Mit Apple fortfahren'               : _fr ? 'Continuer avec Apple'                 : _pt ? 'Continuar com a Apple'               : 'Continue with Apple';
  String get onboardingSignInError  => _tr ? 'Giriş yapılırken hata oluştu'    : _es ? 'Error al iniciar sesión'            : _de ? 'Fehler beim Anmelden'              : _fr ? 'Erreur lors de la connexion'           : _pt ? 'Erro ao fazer login'                 : 'Error signing in';

  // ── Home tab ──────────────────────────────────────────────────────────────────
  String get homeTitle              => _tr ? 'Bugün'                    : _es ? 'Hoy'                : _de ? 'Heute'             : _fr ? 'Aujourd\'hui'        : _pt ? 'Hoje'                : 'Today';
  String get homeGreetingMorning    => _tr ? 'Günaydın'                 : _es ? 'Buenos días'        : _de ? 'Guten Morgen'      : _fr ? 'Bonjour'             : _pt ? 'Bom dia'             : 'Good morning';
  String get homeGreetingAfternoon  => _tr ? 'İyi öğlenler'             : _es ? 'Buenas tardes'      : _de ? 'Guten Tag'         : _fr ? 'Bonjour'             : _pt ? 'Boa tarde'           : 'Good afternoon';
  String get homeGreetingEvening    => _tr ? 'İyi akşamlar'             : _es ? 'Buenas noches'      : _de ? 'Guten Abend'       : _fr ? 'Bonsoir'             : _pt ? 'Boa noite'           : 'Good evening';
  String get homeActionPlanTitle    => _tr ? 'Bugünün Planı'            : _es ? 'Plan de hoy'        : _de ? 'Heutiger Plan'     : _fr ? 'Plan du jour'         : _pt ? 'Plano de hoje'      : 'Today\'s Plan';
  String get homeSleepScoreTitle    => _tr ? 'Uyku Skoru'               : _es ? 'Puntuación de sueño': _de ? 'Schlaf-Score'      : _fr ? 'Score de sommeil'    : _pt ? 'Pontuação de sono'  : 'Sleep Score';
  String get homeBedtimeTitle       => _tr ? 'Bu Gece Yatış Penceresi'  : _es ? 'Ventana de acostarse esta noche' : _de ? 'Schlafzeitfenster heute Nacht' : _fr ? 'Fenêtre de coucher ce soir' : _pt ? 'Janela de sono esta noite' : 'Tonight\'s Bedtime Window';
  String get homeCheckInPrompt      => _tr ? 'Bu sabah nasıl uyudun?'   : _es ? '¿Cómo dormiste esta mañana?'  : _de ? 'Wie hast du heute Nacht geschlafen?' : _fr ? 'Comment as-tu dormi cette nuit ?' : _pt ? 'Como você dormiu hoje?' : 'How did you sleep last night?';
  String get homeCheckInCta         => _tr ? 'Check-in Yap'             : _es ? 'Hacer check-in'     : _de ? 'Einchecken'        : _fr ? 'Faire le check-in'   : _pt ? 'Fazer check-in'     : 'Check In';
  String get homeCoachInsight       => _tr ? 'Koç Görüşü'               : _es ? 'Perspectiva del coach' : _de ? 'Coach-Einblick' : _fr ? 'Aperçu du coach'     : _pt ? 'Visão do coach'     : 'Coach Insight';
  String get homeNoCheckIn          => _tr ? 'Henüz bugün check-in yapmadın' : _es ? 'Aún no hiciste check-in hoy' : _de ? 'Noch kein Check-in heute' : _fr ? 'Pas encore de check-in aujourd\'hui' : _pt ? 'Nenhum check-in hoje ainda' : 'No check-in yet today';
  String get homeSleepDebt         => _tr ? 'Uyku Borcu'                : _es ? 'Deuda de sueño'     : _de ? 'Schlafdefizit'     : _fr ? 'Dette de sommeil'    : _pt ? 'Dívida de sono'     : 'Sleep Debt';
  String get homeComingSoon        => _tr ? 'Yakında geliyor'            : _es ? 'Próximamente'        : _de ? 'Demnächst'          : _fr ? 'Bientôt disponible'  : _pt ? 'Em breve'           : 'Coming soon';
  String get homeTotalSleep        => _tr ? 'Toplam uyku'               : _es ? 'Sueño total'         : _de ? 'Gesamtschlaf'       : _fr ? 'Sommeil total'        : _pt ? 'Sono total'         : 'Total sleep';
  String get actionWhyThis         => _tr ? '▼ Neden bu?'               : _es ? '▼ ¿Por qué esto?'   : _de ? '▼ Warum das?'       : _fr ? '▼ Pourquoi ça ?'      : _pt ? '▼ Por que isso?'    : '▼ Why this?';
  String get actionHide            => _tr ? '▲ Gizle'                   : _es ? '▲ Ocultar'           : _de ? '▲ Ausblenden'       : _fr ? '▲ Masquer'            : _pt ? '▲ Ocultar'          : '▲ Hide';

  // ── Check-in ──────────────────────────────────────────────────────────────────
  String get checkInTitle           => _tr ? 'Sabah Check-in'           : _es ? 'Check-in matutino'  : _de ? 'Morgen-Check-in'   : _fr ? 'Check-in matinal'    : _pt ? 'Check-in matinal'   : 'Morning Check-In';
  String get checkInBedtime         => _tr ? 'Yatış saatin?'            : _es ? '¿A qué hora te acostaste?': _de ? 'Wann bist du ins Bett?' : _fr ? 'À quelle heure t\'es-tu couché(e) ?' : _pt ? 'Que horas você foi dormir?' : 'What time did you go to bed?';
  String get checkInWakeTime        => _tr ? 'Kalkış saatin?'           : _es ? '¿A qué hora te levantaste?' : _de ? 'Wann bist du aufgestanden?' : _fr ? 'À quelle heure t\'es-tu levé(e) ?' : _pt ? 'Que horas você acordou?' : 'What time did you wake up?';
  String get checkInSleepLatency    => _tr ? 'Uykuya dalmak ne kadar sürdü?' : _es ? '¿Cuánto tardaste en dormirte?' : _de ? 'Wie lange hat es gedauert, bis du eingeschlafen bist?' : _fr ? 'Combien de temps pour t\'endormir ?' : _pt ? 'Quanto tempo levou para adormecer?' : 'How long did it take to fall asleep?';
  String get checkInWakeEpisodes    => _tr ? 'Kaç kez uyandın?'         : _es ? '¿Cuántas veces te despertaste?': _de ? 'Wie oft bist du aufgewacht?' : _fr ? 'Combien de fois t\'es-tu réveillé(e) ?' : _pt ? 'Quantas vezes você acordou?' : 'How many times did you wake up?';
  String get checkInMood            => _tr ? 'Sabah ruh halin?'         : _es ? '¿Cómo te sientes esta mañana?': _de ? 'Wie ist deine Stimmung morgens?' : _fr ? 'Comment tu te sens ce matin ?' : _pt ? 'Como está seu humor esta manhã?' : 'How do you feel this morning?';
  String get checkInMinutes         => _tr ? 'dakika'                   : _es ? 'minutos'             : _de ? 'Minuten'           : _fr ? 'minutes'              : _pt ? 'minutos'            : 'minutes';
  String get checkInTimes           => _tr ? 'kez'                      : _es ? 'veces'               : _de ? 'Mal'               : _fr ? 'fois'                 : _pt ? 'vezes'              : 'times';
  String get checkInSubmit          => _tr ? 'Check-in\'i Kaydet'       : _es ? 'Guardar check-in'   : _de ? 'Check-in speichern' : _fr ? 'Enregistrer le check-in' : _pt ? 'Salvar check-in' : 'Save Check-In';
  String get checkInSuccess         => _tr ? 'Check-in kaydedildi!'     : _es ? '¡Check-in guardado!' : _de ? 'Check-in gespeichert!' : _fr ? 'Check-in enregistré !' : _pt ? 'Check-in salvo!' : 'Check-in saved!';

  // ── Mood labels ───────────────────────────────────────────────────────────────
  String get moodTerrible          => _tr ? 'Berbat'      : _es ? 'Terrible'   : _de ? 'Schrecklich' : _fr ? 'Terrible'    : _pt ? 'Terrível'    : 'Terrible';
  String get moodBad               => _tr ? 'Kötü'        : _es ? 'Malo'       : _de ? 'Schlecht'    : _fr ? 'Mauvais'     : _pt ? 'Ruim'        : 'Bad';
  String get moodOk                => _tr ? 'İdare eder'  : _es ? 'Regular'    : _de ? 'Okay'        : _fr ? 'Correct'     : _pt ? 'Ok'          : 'Ok';
  String get moodGood              => _tr ? 'İyi'         : _es ? 'Bien'       : _de ? 'Gut'         : _fr ? 'Bien'        : _pt ? 'Bem'         : 'Good';
  String get moodGreat             => _tr ? 'Harika'      : _es ? 'Genial'     : _de ? 'Super'       : _fr ? 'Super'       : _pt ? 'Ótimo'       : 'Great';

  // ── Sleep Score ────────────────────────────────────────────────────────────────
  String get scorePoor             => _tr ? 'Zayıf'    : _es ? 'Deficiente' : _de ? 'Schlecht' : _fr ? 'Médiocre' : _pt ? 'Fraco'     : 'Poor';
  String get scoreFair             => _tr ? 'Orta'     : _es ? 'Regular'    : _de ? 'Mittel'   : _fr ? 'Passable' : _pt ? 'Regular'   : 'Fair';
  String get scoreGood             => _tr ? 'İyi'      : _es ? 'Bueno'      : _de ? 'Gut'      : _fr ? 'Bon'      : _pt ? 'Bom'       : 'Good';
  String get scoreGreat            => _tr ? 'Harika'   : _es ? 'Muy bueno'  : _de ? 'Super'    : _fr ? 'Super'    : _pt ? 'Ótimo'     : 'Great';
  String get scoreExcellent        => _tr ? 'Mükemmel' : _es ? 'Excelente'  : _de ? 'Ausgezeichnet' : _fr ? 'Excellent' : _pt ? 'Excelente' : 'Excellent';
  String get scoreEfficiency       => _tr ? 'Verimlilik'  : _es ? 'Eficiencia' : _de ? 'Effizienz'   : _fr ? 'Efficacité'  : _pt ? 'Eficiência'  : 'Efficiency';
  String get scoreConsistency      => _tr ? 'Tutarlılık'  : _es ? 'Consistencia' : _de ? 'Konsistenz' : _fr ? 'Régularité'  : _pt ? 'Consistência': 'Consistency';
  String get scoreRecovery         => _tr ? 'Toparlanma'  : _es ? 'Recuperación' : _de ? 'Erholung'   : _fr ? 'Récupération' : _pt ? 'Recuperação' : 'Recovery';

  // ── Sleep phases (passive tracking) ──────────────────────────────────────────
  String get phaseAwake            => _tr ? 'Uyanık' : _es ? 'Despierto' : _de ? 'Wach'   : _fr ? 'Éveillé' : _pt ? 'Acordado' : 'Awake';
  String get phaseLight            => _tr ? 'Hafif'  : _es ? 'Ligero'    : _de ? 'Leicht' : _fr ? 'Léger'   : _pt ? 'Leve'     : 'Light';
  String get phaseDeep             => _tr ? 'Derin'  : _es ? 'Profundo'  : _de ? 'Tief'   : _fr ? 'Profond' : _pt ? 'Profundo' : 'Deep';
  String get phaseRem              => 'REM';

  // ── Coach tab ─────────────────────────────────────────────────────────────────
  String get coachTitle            => _tr ? 'Koçum'        : _es ? 'Mi coach'     : _de ? 'Mein Coach'  : _fr ? 'Mon coach'    : _pt ? 'Meu coach'    : 'My Coach';
  String get coachMessageHint      => _tr ? 'Koçuna bir şey sor...' : _es ? 'Pregúntale algo a tu coach...' : _de ? 'Frag deinen Coach etwas...' : _fr ? 'Pose une question à ton coach...' : _pt ? 'Pergunte algo ao seu coach...' : 'Ask your coach something...';
  String get coachSend             => _tr ? 'Gönder'       : _es ? 'Enviar'       : _de ? 'Senden'      : _fr ? 'Envoyer'      : _pt ? 'Enviar'       : 'Send';
  String get coachThinking         => _tr ? 'Koç düşünüyor...' : _es ? 'El coach está pensando...' : _de ? 'Der Coach denkt...' : _fr ? 'Le coach réfléchit...' : _pt ? 'O coach está pensando...' : 'Coach is thinking...';
  String get coachProgramStage     => _tr ? 'CBT-I Programı' : _es ? 'Programa CBT-I' : _de ? 'CBT-I-Programm' : _fr ? 'Programme CBT-I' : _pt ? 'Programa CBT-I' : 'CBT-I Program';
  String get coachEmptyHistory     => _tr ? 'İlk soruyu sen sor!'  : _es ? '¡Haz la primera pregunta!' : _de ? 'Stelle die erste Frage!' : _fr ? 'Pose la première question !' : _pt ? 'Faça a primeira pergunta!' : 'Ask your first question!';

  // ── Progress tab ──────────────────────────────────────────────────────────────
  String get progressTitle         => _tr ? 'İlerleme'      : _es ? 'Progreso'     : _de ? 'Fortschritt'  : _fr ? 'Progrès'       : _pt ? 'Progresso'    : 'Progress';
  String get progress7Day          => _tr ? '7 Gün'         : _es ? '7 días'       : _de ? '7 Tage'       : _fr ? '7 jours'       : _pt ? '7 dias'       : '7 Days';
  String get progress30Day         => _tr ? '30 Gün'        : _es ? '30 días'      : _de ? '30 Tage'      : _fr ? '30 jours'      : _pt ? '30 dias'      : '30 Days';
  String get progress90Day         => _tr ? '90 Gün'        : _es ? '90 días'      : _de ? '90 Tage'      : _fr ? '90 jours'      : _pt ? '90 dias'      : '90 Days';
  String get progressNoData        => _tr ? 'Henüz veri yok. İlk check-in\'ini yap!' : _es ? 'Aún no hay datos. ¡Haz tu primer check-in!' : _de ? 'Noch keine Daten. Mach deinen ersten Check-in!' : _fr ? 'Pas encore de données. Fais ton premier check-in !' : _pt ? 'Ainda sem dados. Faça seu primeiro check-in!' : 'No data yet. Do your first check-in!';
  String get progressStreak        => _tr ? 'Gün Serisi'    : _es ? 'Racha'        : _de ? 'Serie'        : _fr ? 'Série'         : _pt ? 'Sequência'    : 'Streak';
  String get progressMilestones    => _tr ? 'Başarılar'     : _es ? 'Logros'       : _de ? 'Meilensteine' : _fr ? 'Jalons'        : _pt ? 'Conquistas'   : 'Milestones';
  String get progressWeekCompare   => _tr ? 'Hafta Karşılaştırması' : _es ? 'Comparación semanal' : _de ? 'Wochenvergleich' : _fr ? 'Comparaison hebdomadaire' : _pt ? 'Comparação semanal' : 'Week Comparison';

  // ── Routines tab ──────────────────────────────────────────────────────────────
  String get routinesTitle         => _tr ? 'Rutinler'      : _es ? 'Rutinas'      : _de ? 'Routinen'     : _fr ? 'Routines'      : _pt ? 'Rotinas'      : 'Routines';
  String get routineWindDown       => _tr ? 'Yatma Rutini'  : _es ? 'Rutina para dormir' : _de ? 'Schlafroutine' : _fr ? 'Routine du coucher' : _pt ? 'Rotina para dormir' : 'Wind-Down Routine';
  String get routineMorning        => _tr ? 'Sabah Rutini'  : _es ? 'Rutina matutina' : _de ? 'Morgenroutine' : _fr ? 'Routine matinale' : _pt ? 'Rotina matinal' : 'Morning Routine';
  String get routineStart          => _tr ? 'Rutini Başlat' : _es ? 'Iniciar rutina' : _de ? 'Routine starten' : _fr ? 'Démarrer la routine' : _pt ? 'Iniciar rotina' : 'Start Routine';
  String get routineComplete       => _tr ? 'Rutin Tamamlandı!' : _es ? '¡Rutina completada!' : _de ? 'Routine abgeschlossen!' : _fr ? 'Routine terminée !' : _pt ? 'Rotina concluída!' : 'Routine Complete!';
  String get routineAddStep        => _tr ? 'Adım Ekle'     : _es ? 'Añadir paso'  : _de ? 'Schritt hinzufügen' : _fr ? 'Ajouter une étape' : _pt ? 'Adicionar etapa' : 'Add Step';
  String get routineEmpty          => _tr ? 'Henüz rutin eklenmedi' : _es ? 'Aún no hay rutina' : _de ? 'Noch keine Routine' : _fr ? 'Pas encore de routine' : _pt ? 'Nenhuma rotina ainda' : 'No routine yet';

  // ── Default routine step titles ────────────────────────────────────────────
  String get routineStepDimLights    => _tr ? 'Işıkları kıs ve ekranları bırak'   : _es ? 'Atenúa las luces y deja las pantallas'  : _de ? 'Lichter dimmen & Bildschirme weglegen' : _fr ? 'Tamisez les lumières et rangez les écrans' : _pt ? 'Diminua as luzes e largue as telas' : 'Dim lights & put down screens';
  String get routineStepBreathing    => _tr ? '4-7-8 nefes egzersizi (3 tur)'     : _es ? 'Respiración 4-7-8 (3 rondas)'          : _de ? '4-7-8 Atemübung (3 Runden)'           : _fr ? 'Respiration 4-7-8 (3 tours)'           : _pt ? 'Respiração 4-7-8 (3 rodadas)'       : '4-7-8 breathing (3 rounds)';
  String get routineStepWriteTasks   => _tr ? 'Yarının ilk 3 görevini yaz'         : _es ? 'Escribe las 3 tareas principales de mañana' : _de ? 'Die 3 wichtigsten Aufgaben von morgen aufschreiben' : _fr ? 'Écris les 3 tâches prioritaires de demain' : _pt ? 'Escreva as 3 tarefas principais de amanhã' : 'Write tomorrow\'s top 3 tasks';
  String get routineStepBodyScan     => _tr ? 'Hafif beden taraması / esneme'      : _es ? 'Exploración corporal suave / estiramiento' : _de ? 'Sanfter Bodyscan / Dehnen'            : _fr ? 'Scan corporel doux / étirement'         : _pt ? 'Escaneamento corporal suave / alongamento' : 'Gentle body scan / stretch';
  String get routineStepSetAlarm     => _tr ? 'Alarmı kur ve telefonu odanın dışında şarj et' : _es ? 'Pon la alarma y carga el teléfono fuera del dormitorio' : _de ? 'Wecker stellen & Handy außerhalb des Zimmers laden' : _fr ? 'Règle le réveil et charge le téléphone hors de la chambre' : _pt ? 'Defina o alarme e carregue o celular fora do quarto' : 'Set alarm & charge phone outside room';
  String get routineStepBrightLight  => _tr ? 'Parlak ışığa maruz kal (panjurları aç)' : _es ? 'Exposición a luz brillante (abre las persianas)' : _de ? 'Helles Licht (Jalousien öffnen)'    : _fr ? 'Exposition à la lumière vive (ouvrir les stores)' : _pt ? 'Exposição à luz intensa (abra as persianas)' : 'Bright light exposure (open blinds)';
  String get routineStepDrinkWater   => _tr ? 'Bir bardak dolu su iç'              : _es ? 'Bebe un vaso lleno de agua'              : _de ? 'Ein volles Glas Wasser trinken'        : _fr ? 'Boire un grand verre d\'eau'            : _pt ? 'Beba um copo cheio de água'          : 'Drink a full glass of water';
  String get routineStepStretch      => _tr ? '5 dakikalık sabah egzersizi'        : _es ? 'Estiramiento matutino de 5 minutos'     : _de ? '5-Minuten-Morgenstretch'              : _fr ? 'Étirement matinal de 5 minutes'        : _pt ? 'Alongamento matinal de 5 minutos'   : '5-minute morning stretch';
  String get routineStepLogCheckin   => _tr ? 'Waketale\'de uyku check-in yap'    : _es ? 'Registra el check-in de sueño en Waketale' : _de ? 'Schlaf-Check-in in Waketale eintragen' : _fr ? 'Enregistre ton check-in de sommeil dans Waketale' : _pt ? 'Registre o check-in de sono no Waketale' : 'Log sleep check-in in Waketale';

  // ── Settings tab ──────────────────────────────────────────────────────────────
  String get settingsTitle         => _tr ? 'Ayarlar'       : _es ? 'Configuración'  : _de ? 'Einstellungen' : _fr ? 'Paramètres'     : _pt ? 'Configurações' : 'Settings';
  String get settingsProfile       => _tr ? 'Profil'        : _es ? 'Perfil'         : _de ? 'Profil'        : _fr ? 'Profil'         : _pt ? 'Perfil'        : 'Profile';
  String get settingsLanguage      => _tr ? 'Dil'           : _es ? 'Idioma'         : _de ? 'Sprache'       : _fr ? 'Langue'         : _pt ? 'Idioma'        : 'Language';
  String get settingsNotifications => _tr ? 'Bildirimler'   : _es ? 'Notificaciones' : _de ? 'Benachrichtigungen' : _fr ? 'Notifications' : _pt ? 'Notificações' : 'Notifications';
  String get settingsSubscription  => _tr ? 'Abonelik'      : _es ? 'Suscripción'    : _de ? 'Abonnement'    : _fr ? 'Abonnement'     : _pt ? 'Assinatura'    : 'Subscription';
  String get settingsWearables     => _tr ? 'Giyilebilir Cihazlar' : _es ? 'Dispositivos portátiles' : _de ? 'Wearables' : _fr ? 'Appareils portables' : _pt ? 'Dispositivos vestíveis' : 'Wearables';
  String get settingsPrivacy       => _tr ? 'Gizlilik ve Veriler' : _es ? 'Privacidad y datos' : _de ? 'Datenschutz' : _fr ? 'Confidentialité et données' : _pt ? 'Privacidade e dados' : 'Privacy & Data';
  String get settingsSupport       => _tr ? 'Destek'        : _es ? 'Soporte'        : _de ? 'Support'       : _fr ? 'Support'         : _pt ? 'Suporte'       : 'Support';
  String get settingsSignOut       => _tr ? 'Çıkış Yap'     : _es ? 'Cerrar sesión'  : _de ? 'Abmelden'      : _fr ? 'Se déconnecter'  : _pt ? 'Sair'          : 'Sign Out';
  String get settingsDeleteAccount => _tr ? 'Hesabı Sil'    : _es ? 'Eliminar cuenta'  : _de ? 'Konto löschen' : _fr ? 'Supprimer le compte' : _pt ? 'Excluir conta' : 'Delete Account';
  String get settingsDeleteConfirm => _tr ? 'Hesabını silmek istediğinden emin misin? Bu işlem geri alınamaz.' : _es ? '¿Estás seguro de que quieres eliminar tu cuenta? Esta acción no se puede deshacer.' : _de ? 'Bist du sicher, dass du dein Konto löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.' : _fr ? 'Es-tu sûr(e) de vouloir supprimer ton compte ? Cette action est irréversible.' : _pt ? 'Tem certeza de que deseja excluir sua conta? Esta ação não pode ser desfeita.' : 'Are you sure you want to delete your account? This action cannot be undone.';
  String get settingsVersion       => _tr ? 'Sürüm'         : _es ? 'Versión'        : _de ? 'Version'       : _fr ? 'Version'         : _pt ? 'Versão'        : 'Version';
  String get settingsSectionApp     => _tr ? 'Uygulama'      : _es ? 'Aplicación'     : _de ? 'App'            : _fr ? 'Application'     : _pt ? 'Aplicativo'    : 'App';
  String get settingsSectionPremium => _tr ? 'Premium'       : _es ? 'Premium'        : _de ? 'Premium'        : _fr ? 'Premium'         : _pt ? 'Premium'       : 'Premium';
  String get settingsSectionAccount => _tr ? 'Hesap'         : _es ? 'Cuenta'         : _de ? 'Konto'          : _fr ? 'Compte'          : _pt ? 'Conta'         : 'Account';

  // ── Paywall ────────────────────────────────────────────────────────────────────
  String get paywallTitle          => _tr ? 'Tüm Potansiyelini Aç'    : _es ? 'Desbloquea todo tu potencial' : _de ? 'Dein volles Potenzial freisetzen' : _fr ? 'Libère tout ton potentiel' : _pt ? 'Libere todo o seu potencial' : 'Unlock Your Full Potential';
  String get paywallSubtitle       => _tr ? '7 günlük ücretsiz deneme ile başla' : _es ? 'Comienza con 7 días gratis' : _de ? 'Starte mit 7 Tagen kostenlos' : _fr ? 'Commence avec 7 jours gratuits' : _pt ? 'Comece com 7 dias grátis' : 'Start with 7 days free';
  String get paywallFeature1       => _tr ? 'Kişiselleştirilmiş CBT-I eylem planları' : _es ? 'Planes de acción CBT-I personalizados' : _de ? 'Persönliche CBT-I Aktionspläne' : _fr ? 'Plans d\'action CBT-I personnalisés' : _pt ? 'Planos de ação CBT-I personalizados' : 'Personalized CBT-I action plans';
  String get paywallFeature2       => _tr ? 'Sınırsız AI koç sohbeti' : _es ? 'Chat ilimitado con coach IA' : _de ? 'Unbegrenzte KI-Coach-Gespräche' : _fr ? 'Chat coach IA illimité' : _pt ? 'Chat ilimitado com coach IA' : 'Unlimited AI coach chat';
  String get paywallFeature3       => _tr ? '30 ve 90 günlük uyku trendleri' : _es ? 'Tendencias de sueño de 30 y 90 días' : _de ? '30- und 90-Tage-Schlaftrends' : _fr ? 'Tendances sommeil sur 30 et 90 jours' : _pt ? 'Tendências de sono de 30 e 90 dias' : '30 and 90-day sleep trends';
  String get paywallFeature4       => _tr ? 'Akıllı alarm ve pasif uyku takibi' : _es ? 'Alarma inteligente y seguimiento pasivo' : _de ? 'Smarter Wecker & passives Tracking' : _fr ? 'Réveil intelligent & suivi passif' : _pt ? 'Alarme inteligente e rastreamento passivo' : 'Smart alarm & passive sleep tracking';
  String get paywallFeature5       => _tr ? 'Giyilebilir cihaz entegrasyonu' : _es ? 'Integración con dispositivos portátiles' : _de ? 'Wearable-Integration' : _fr ? 'Intégration des appareils portables' : _pt ? 'Integração com dispositivos vestíveis' : 'Wearable device integration';
  String get paywallMonthly        => _tr ? 'Aylık'                     : _es ? 'Mensual'              : _de ? 'Monatlich'            : _fr ? 'Mensuel'              : _pt ? 'Mensal'               : 'Monthly';
  String get paywallAnnual         => _tr ? 'Yıllık'                    : _es ? 'Anual'                : _de ? 'Jährlich'             : _fr ? 'Annuel'               : _pt ? 'Anual'                : 'Annual';
  String get paywallBestValue      => _tr ? 'En İyi Değer'              : _es ? 'Mejor valor'          : _de ? 'Bestes Angebot'       : _fr ? 'Meilleur rapport'      : _pt ? 'Melhor valor'         : 'Best Value';
  String get paywallSavePercent    => _tr ? '%37 Tasarruf Et'           : _es ? 'Ahorra 37%'           : _de ? '37% sparen'           : _fr ? 'Économisez 37%'       : _pt ? 'Economize 37%'        : 'Save 37%';
  String get paywallCta            => _tr ? 'Ücretsiz Denemeyi Başlat'  : _es ? 'Iniciar prueba gratis': _de ? 'Kostenlos testen'     : _fr ? 'Démarrer l\'essai gratuit' : _pt ? 'Iniciar avaliação gratuita' : 'Start Free Trial';
  String get paywallRestore        => _tr ? 'Satın Alımı Geri Yükle'   : _es ? 'Restaurar compra'     : _de ? 'Kauf wiederherstellen' : _fr ? 'Restaurer l\'achat'    : _pt ? 'Restaurar compra'     : 'Restore Purchase';
  String get paywallCancelAnytime  => _tr ? 'İstediğin zaman iptal et' : _es ? 'Cancela cuando quieras' : _de ? 'Jederzeit kündigen' : _fr ? 'Annule quand tu veux'  : _pt ? 'Cancele quando quiser' : 'Cancel anytime';
  String get paywallTrialDisclosure => _tr ? '7 günlük ücretsiz deneme. Deneme sona erince otomatik yenileme başlar.' : _es ? 'Prueba gratuita de 7 días. Se renueva automáticamente al finalizar.' : _de ? '7 Tage kostenlos testen. Danach automatische Verlängerung.' : _fr ? 'Essai gratuit de 7 jours. Renouvellement automatique à la fin.' : _pt ? 'Avaliação gratuita de 7 dias. Renovação automática ao término.' : '7-day free trial. Automatically renews after trial ends.';

  // ── Wearables ─────────────────────────────────────────────────────────────────
  String get wearableAppleHealth   => 'Apple Health';
  String get wearableGoogleFit     => 'Google Fit';
  String get wearableConnect       => _tr ? 'Bağla'          : _es ? 'Conectar'        : _de ? 'Verbinden'       : _fr ? 'Connecter'        : _pt ? 'Conectar'        : 'Connect';
  String get wearableConnected     => _tr ? 'Bağlı'          : _es ? 'Conectado'       : _de ? 'Verbunden'       : _fr ? 'Connecté'         : _pt ? 'Conectado'       : 'Connected';
  String get wearableDisconnect    => _tr ? 'Bağlantıyı Kes' : _es ? 'Desconectar'     : _de ? 'Trennen'         : _fr ? 'Déconnecter'      : _pt ? 'Desconectar'     : 'Disconnect';
  String get wearablePermission    => _tr ? 'Sağlık verilerine erişim için izin ver' : _es ? 'Permitir acceso a datos de salud' : _de ? 'Zugriff auf Gesundheitsdaten erlauben' : _fr ? 'Autoriser l\'accès aux données de santé' : _pt ? 'Permitir acesso aos dados de saúde' : 'Allow access to health data';

  // ── Sleep Tracker (passive) ────────────────────────────────────────────────────
  String get trackerTitle          => _tr ? 'Uyku Takibi'    : _es ? 'Seguimiento de sueño' : _de ? 'Schlaf-Tracking' : _fr ? 'Suivi du sommeil' : _pt ? 'Rastreamento de sono' : 'Sleep Tracking';
  String get trackerStart          => _tr ? 'Takibi Başlat'  : _es ? 'Iniciar seguimiento' : _de ? 'Tracking starten' : _fr ? 'Démarrer le suivi' : _pt ? 'Iniciar rastreamento' : 'Start Tracking';
  String get trackerStop           => _tr ? 'Takibi Durdur'  : _es ? 'Detener seguimiento' : _de ? 'Tracking stoppen' : _fr ? 'Arrêter le suivi' : _pt ? 'Parar rastreamento' : 'Stop Tracking';
  String get trackerActiveLabel    => _tr ? 'Takip ediliyor' : _es ? 'Siguiendo'           : _de ? 'Wird verfolgt'   : _fr ? 'En cours de suivi' : _pt ? 'Rastreando' : 'Tracking';
  String get trackerPhaseLabel     => _tr ? 'Mevcut Aşama'  : _es ? 'Fase actual'         : _de ? 'Aktuelle Phase'  : _fr ? 'Phase actuelle'   : _pt ? 'Fase atual' : 'Current Phase';

  // ── Error messages ────────────────────────────────────────────────────────────
  String get errorNetworkTitle     => _tr ? 'Bağlantı Sorunu'  : _es ? 'Problema de conexión' : _de ? 'Verbindungsproblem' : _fr ? 'Problème de connexion' : _pt ? 'Problema de conexão' : 'Connection Problem';
  String get errorNetworkBody      => _tr ? 'Şu an bağlanamıyoruz. İnterneti kontrol et ve tekrar dene.' : _es ? 'No podemos conectarnos ahora. Revisa tu conexión e inténtalo de nuevo.' : _de ? 'Wir können uns gerade nicht verbinden. Prüfe deine Verbindung und versuche es erneut.' : _fr ? 'Impossible de se connecter pour l\'instant. Vérifie ta connexion et réessaie.' : _pt ? 'Não conseguimos conectar agora. Verifique sua conexão e tente novamente.' : 'Can\'t connect right now. Check your internet and try again.';
  String get errorGenericBody      => _tr ? 'Beklenmeyen bir hata oluştu. Lütfen tekrar dene.' : _es ? 'Ocurrió un error inesperado. Por favor, inténtalo de nuevo.' : _de ? 'Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es erneut.' : _fr ? 'Une erreur inattendue s\'est produite. Veuillez réessayer.' : _pt ? 'Ocorreu um erro inesperado. Por favor, tente novamente.' : 'An unexpected error occurred. Please try again.';
  String get errorAiCoach          => _tr ? 'Koça ulaşılamıyor. Birazdan tekrar dene.' : _es ? 'No se puede contactar al coach. Inténtalo de nuevo más tarde.' : _de ? 'Coach nicht erreichbar. Versuch es gleich nochmal.' : _fr ? 'Impossible de joindre le coach. Réessaie dans un moment.' : _pt ? 'Não foi possível contatar o coach. Tente novamente em instantes.' : 'Can\'t reach coach. Try again in a moment.';

  // ── Empty states ──────────────────────────────────────────────────────────────
  String get emptyProgressTitle    => _tr ? 'Yolculuğun başlıyor'   : _es ? 'Tu viaje comienza'  : _de ? 'Deine Reise beginnt' : _fr ? 'Ton voyage commence' : _pt ? 'Sua jornada começa' : 'Your journey begins';
  String get emptyProgressBody     => _tr ? 'İlk check-in\'ini yapınca uyku trendlerin burada görünecek.' : _es ? 'Después de tu primer check-in, aquí verás tus tendencias de sueño.' : _de ? 'Nach deinem ersten Check-in siehst du hier deine Schlaftrends.' : _fr ? 'Après ton premier check-in, tes tendances de sommeil apparaîtront ici.' : _pt ? 'Após seu primeiro check-in, suas tendências de sono aparecerão aqui.' : 'After your first check-in, your sleep trends will appear here.';
  String get emptyCoachTitle       => _tr ? 'Koçun hazır'           : _es ? 'Tu coach está listo' : _de ? 'Dein Coach ist bereit' : _fr ? 'Ton coach est prêt' : _pt ? 'Seu coach está pronto' : 'Your coach is ready';
  String get emptyCoachBody        => _tr ? 'Uyku hakkında her şeyi sorabilirsin.' : _es ? 'Puedes preguntar cualquier cosa sobre el sueño.' : _de ? 'Du kannst alles über Schlaf fragen.' : _fr ? 'Tu peux poser n\'importe quelle question sur le sommeil.' : _pt ? 'Você pode perguntar qualquer coisa sobre sono.' : 'Ask anything about sleep.';

  // ── Notifications ─────────────────────────────────────────────────────────────
  String get notifPermissionTitle  => _tr ? 'Uyku hatırlatıcılarını aç'    : _es ? 'Activa los recordatorios de sueño' : _de ? 'Schlaf-Erinnerungen aktivieren' : _fr ? 'Active les rappels de sommeil' : _pt ? 'Ative os lembretes de sono' : 'Enable sleep reminders';
  String get notifPermissionBody   => _tr ? 'Yatmadan önce ve sabah check-in için hatırlatırız.' : _es ? 'Te recordaremos antes de acostarte y para el check-in matutino.' : _de ? 'Wir erinnern dich vor dem Schlafen und für den Morgen-Check-in.' : _fr ? 'On te rappelle avant de dormir et pour le check-in matinal.' : _pt ? 'Lembramos você antes de dormir e para o check-in matinal.' : 'We\'ll remind you before bed and for your morning check-in.';

  // ── Notification content ───────────────────────────────────────────────────
  String get notifChannelName      => _tr ? 'Uyku Hatırlatıcıları'          : _es ? 'Recordatorios de sueño'         : _de ? 'Schlaf-Erinnerungen'             : _fr ? 'Rappels de sommeil'              : _pt ? 'Lembretes de sono'              : 'Sleep Reminders';
  String get notifChannelDesc      => _tr ? 'Waketale\'den yatış ve check-in hatırlatıcıları' : _es ? 'Recordatorios de hora de dormir y check-in de Waketale' : _de ? 'Schlafenszeit- und Check-in-Erinnerungen von Waketale' : _fr ? 'Rappels d\'heure de coucher et de check-in de Waketale' : _pt ? 'Lembretes de hora de dormir e check-in do Waketale' : 'Bedtime and check-in reminders from Waketale';
  String get notifBedtimeTitle     => _tr ? 'Rüzgarını dindir zamanı'       : _es ? 'Hora de relajarse'              : _de ? 'Zeit zum Entspannen'              : _fr ? 'Il est temps de décompresser'    : _pt ? 'Hora de relaxar'                : 'Time to wind down';
  String get notifBedtimeBody      => _tr ? 'Yatma vaktin 30 dakika sonra. Harika bir gece için hazırlan.' : _es ? 'Tu hora de dormir es en 30 minutos. Prepárate para una gran noche.' : _de ? 'Deine Schlafenszeit ist in 30 Minuten. Bereite dich auf eine tolle Nacht vor.' : _fr ? 'Ton coucher est dans 30 minutes. Prépare-toi pour une bonne nuit.' : _pt ? 'Sua hora de dormir é em 30 minutos. Prepare-se para uma ótima noite.' : 'Your bedtime is in 30 minutes. Prepare for a great night\'s sleep.';
  String get notifCheckinTitle     => _tr ? 'Günaydın! Nasıl uyudun?'       : _es ? '¡Buenos días! ¿Cómo dormiste?'  : _de ? 'Guten Morgen! Wie hast du geschlafen?' : _fr ? 'Bonjour ! Comment as-tu dormi ?' : _pt ? 'Bom dia! Como você dormiu?'      : 'Good morning! How did you sleep?';
  String get notifCheckinBody      => _tr ? 'Uyku kaydını yapmak için 30 saniyeni ayır ve ilerlemeyi takip et.' : _es ? 'Dedica 30 segundos a registrar tu sueño y seguir tu progreso.' : _de ? 'Nimm dir 30 Sekunden, um deinen Schlaf zu erfassen und deinen Fortschritt zu verfolgen.' : _fr ? 'Prends 30 secondes pour enregistrer ton sommeil et suivre tes progrès.' : _pt ? 'Reserve 30 segundos para registrar seu sono e acompanhar seu progresso.' : 'Take 30 seconds to log your sleep and track your progress.';
  String get notifWeeklyTitle      => _tr ? 'Haftalık uyku raporun hazır'   : _es ? 'Tu informe de sueño semanal está listo' : _de ? 'Dein wöchentlicher Schlafreport ist fertig' : _fr ? 'Ton rapport de sommeil hebdomadaire est prêt' : _pt ? 'Seu relatório de sono semanal está pronto' : 'Your weekly sleep report is ready';
  String get notifWeeklyBody       => _tr ? 'Bu hafta uykunun nasıl geliştiğini gör. İlerlemeyi görüntülemek için dokun.' : _es ? 'Mira cómo mejoró tu sueño esta semana. Toca para ver tu progreso.' : _de ? 'Sieh, wie sich dein Schlaf diese Woche verbessert hat. Tippe, um deinen Fortschritt zu sehen.' : _fr ? 'Vois comment ton sommeil s\'est amélioré cette semaine. Appuie pour voir tes progrès.' : _pt ? 'Veja como seu sono melhorou esta semana. Toque para ver seu progresso.' : 'See how your sleep improved this week. Tap to view your progress.';

  // ── Notification settings screen ─────────────────────────────────────────────
  String get notifScreenBedtimeSection  => _tr ? 'Yatış Saati'                      : _es ? 'Hora de dormir'              : _de ? 'Schlafenszeit'                    : _fr ? 'Heure de coucher'              : _pt ? 'Hora de dormir'                   : 'Bedtime';
  String get notifScreenBedtimeToggle   => _tr ? 'Yatış hatırlatıcısı'              : _es ? 'Recordatorio de acostarse'   : _de ? 'Schlafenszeit-Erinnerung'         : _fr ? 'Rappel coucher'                 : _pt ? 'Lembrete de hora de dormir'       : 'Bedtime reminder';
  String get notifScreenBedtimeSubtitle => _tr ? 'Yatıştan 30 dk önce'              : _es ? '30 min antes de acostarse'   : _de ? '30 Min. vor der Schlafenszeit'    : _fr ? '30 min avant le coucher'        : _pt ? '30 min antes de dormir'           : '30 min before bedtime';
  String get notifScreenBedtimeLabel    => _tr ? 'Yatış saati'                      : _es ? 'Hora de acostarse'           : _de ? 'Schlafenszeit'                    : _fr ? 'Heure de coucher'              : _pt ? 'Hora de dormir'                   : 'Bedtime';
  String get notifScreenCheckinSection  => _tr ? 'Sabah Check-In'                   : _es ? 'Check-in matutino'           : _de ? 'Morgen-Check-in'                  : _fr ? 'Check-in matinal'              : _pt ? 'Check-in matinal'                 : 'Morning Check-In';
  String get notifScreenCheckinToggle   => _tr ? 'Sabah check-in hatırlatıcısı'     : _es ? 'Recordatorio matutino'       : _de ? 'Morgen-Check-in-Erinnerung'       : _fr ? 'Rappel check-in matinal'       : _pt ? 'Lembrete de check-in matinal'     : 'Morning check-in reminder';
  String get notifScreenCheckinSubtitle => _tr ? 'Kalkış saatinde'                  : _es ? 'A la hora de levantarse'     : _de ? 'Zur Aufwachzeit'                  : _fr ? 'À l\'heure du réveil'          : _pt ? 'Na hora de acordar'               : 'At your wake time';
  String get notifScreenCheckinLabel    => _tr ? 'Kalkış saati'                     : _es ? 'Hora de levantarse'          : _de ? 'Aufwachzeit'                      : _fr ? 'Heure de réveil'               : _pt ? 'Hora de acordar'                  : 'Wake time';
  String get notifScreenWeeklySection   => _tr ? 'Haftalık Rapor'                   : _es ? 'Informe semanal'             : _de ? 'Wochenbericht'                    : _fr ? 'Rapport hebdomadaire'          : _pt ? 'Relatório semanal'                : 'Weekly Report';
  String get notifScreenWeeklyToggle    => _tr ? 'Haftalık ilerleme raporu'         : _es ? 'Informe de progreso semanal' : _de ? 'Wöchentlicher Fortschrittsbericht' : _fr ? 'Rapport de progression hebdomadaire' : _pt ? 'Relatório de progresso semanal' : 'Weekly progress report';
  String get notifScreenWeeklySubtitle  => _tr ? 'Her Pazar 09:00\'da'              : _es ? 'Todos los domingos a las 9:00' : _de ? 'Jeden Sonntag um 9:00 Uhr'      : _fr ? 'Chaque dimanche à 9h00'        : _pt ? 'Todo domingo às 9h00'             : 'Every Sunday at 9:00 AM';

  // ── CBT-I Stage labels ────────────────────────────────────────────────────────
  String get cbtiWeek1             => _tr ? 'Hafta 1: Temel'              : _es ? 'Semana 1: Fundamentos'    : _de ? 'Woche 1: Grundlagen'      : _fr ? 'Semaine 1 : Fondamentaux' : _pt ? 'Semana 1: Fundamentos'    : 'Week 1: Foundations';
  String get cbtiWeek2             => _tr ? 'Hafta 2: Uyku Kısıtlaması'  : _es ? 'Semana 2: Restricción del sueño' : _de ? 'Woche 2: Schlafrestriktion' : _fr ? 'Semaine 2 : Restriction du sommeil' : _pt ? 'Semana 2: Restrição do sono' : 'Week 2: Sleep Restriction';
  String get cbtiWeek3             => _tr ? 'Hafta 3: Uyarı Kontrolü'    : _es ? 'Semana 3: Control de estímulos' : _de ? 'Woche 3: Stimuluskontrolle' : _fr ? 'Semaine 3 : Contrôle des stimuli' : _pt ? 'Semana 3: Controle de estímulos' : 'Week 3: Stimulus Control';
  String get cbtiWeek4             => _tr ? 'Hafta 4: Bilişsel Yeniden Yapılandırma' : _es ? 'Semana 4: Reestructuración cognitiva' : _de ? 'Woche 4: Kognitive Umstrukturierung' : _fr ? 'Semaine 4 : Restructuration cognitive' : _pt ? 'Semana 4: Reestruturação cognitiva' : 'Week 4: Cognitive Restructuring';
  String get cbtiWeek5             => _tr ? 'Hafta 5: Gevşeme Teknikleri'  : _es ? 'Semana 5: Técnicas de relajación' : _de ? 'Woche 5: Entspannungstechniken' : _fr ? 'Semaine 5 : Techniques de relaxation' : _pt ? 'Semana 5: Técnicas de relaxamento' : 'Week 5: Relaxation Techniques';
  String get cbtiWeek6             => _tr ? 'Hafta 6: Uyku Hijyeni'       : _es ? 'Semana 6: Higiene del sueño' : _de ? 'Woche 6: Schlafhygiene' : _fr ? 'Semaine 6 : Hygiène du sommeil' : _pt ? 'Semana 6: Higiene do sono' : 'Week 6: Sleep Hygiene';
  String get cbtiWeek7             => _tr ? 'Hafta 7: Konsolidasyon'      : _es ? 'Semana 7: Consolidación' : _de ? 'Woche 7: Konsolidierung' : _fr ? 'Semaine 7 : Consolidation' : _pt ? 'Semana 7: Consolidação' : 'Week 7: Consolidation';
  String get cbtiWeek8             => _tr ? 'Hafta 8: Bağımsızlık'        : _es ? 'Semana 8: Independencia' : _de ? 'Woche 8: Unabhängigkeit' : _fr ? 'Semaine 8 : Indépendance' : _pt ? 'Semana 8: Independência' : 'Week 8: Independence';

  // ── Premium gate ──────────────────────────────────────────────────────────────
  String get premiumGateTitle      => _tr ? 'Premium Özellik'       : _es ? 'Función premium'        : _de ? 'Premium-Funktion'      : _fr ? 'Fonction premium'        : _pt ? 'Recurso premium'       : 'Premium Feature';
  String get premiumGateBody       => _tr ? 'Bu özellik Premium abonelik gerektirir.' : _es ? 'Esta función requiere una suscripción Premium.' : _de ? 'Diese Funktion erfordert ein Premium-Abonnement.' : _fr ? 'Cette fonctionnalité nécessite un abonnement Premium.' : _pt ? 'Este recurso requer uma assinatura Premium.' : 'This feature requires a Premium subscription.';
  String get premiumGateCta        => _tr ? 'Premium\'a Geç'        : _es ? 'Obtener Premium'         : _de ? 'Premium holen'          : _fr ? 'Passer à Premium'        : _pt ? 'Obter Premium'          : 'Get Premium';

  // ── Navigation bar labels ─────────────────────────────────────────────────────
  String get navHome               => _tr ? 'Bugün'     : _es ? 'Hoy'          : _de ? 'Heute'      : _fr ? 'Aujourd\'hui' : _pt ? 'Hoje'       : 'Today';
  String get navProgress           => _tr ? 'İlerleme'  : _es ? 'Progreso'     : _de ? 'Fortschritt': _fr ? 'Progrès'      : _pt ? 'Progresso'  : 'Progress';
  String get navCoach              => _tr ? 'Koç'       : _es ? 'Coach'        : _de ? 'Coach'      : _fr ? 'Coach'        : _pt ? 'Coach'      : 'Coach';
  String get navRoutines           => _tr ? 'Rutinler'  : _es ? 'Rutinas'      : _de ? 'Routinen'   : _fr ? 'Routines'     : _pt ? 'Rotinas'    : 'Routines';
  String get navSettings           => _tr ? 'Ayarlar'   : _es ? 'Ajustes'      : _de ? 'Einstellungen' : _fr ? 'Réglages'  : _pt ? 'Ajustes'    : 'Settings';
}
