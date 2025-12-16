/// Configuration globale de l’API
/// ------------------------------------------------------------
/// Cette classe centralise toutes les URLs de l’API.
/// Elle permet de changer facilement d’environnement
/// (développement, production) sans modifier le reste du code.
class ApiConfig {
  /// URL de développement
  ///
  /// ⚠️ Cas Android Emulator :
  /// `10.0.2.2` est une adresse spéciale qui pointe vers
  /// le `localhost` du PC hôte (machine de développement).
  ///
  /// ➜ À utiliser UNIQUEMENT sur Android Emulator
  /// ➜ Ne fonctionne PAS sur téléphone réel
  static const String baseUrlDev = 'http://10.0.2.2:8000';

  /// URL de production
  ///
  /// ➜ Serveur réel (cloud, VPS, etc.)
  /// ➜ Utilise HTTPS avec certificat SSL valide
  static const String baseUrlProd = 'https://api.mybank.com';

  /// URL actuellement utilisée par l’application
  ///
  /// Pour le moment, on utilise l’environnement de développement.
  /// En production, cette valeur devra pointer vers `baseUrlProd`
  /// (ou être définie via des variables d’environnement).
  static const String baseUrl = baseUrlDev;
}
