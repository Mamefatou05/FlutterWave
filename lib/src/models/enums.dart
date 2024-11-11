enum TransactionType {
  DEPOT,
  RETRAIT,
  TRANSFERT,
  PAIEMENT
}

enum TransactionStatus {
  EN_ATTENTE,
  VALIDEE,
  ANNULEE,
  REJETEE
}

enum NotificationType {
  EMAIL,
  SMS,
}

enum Periodicity {
  QUOTIDIEN,
  HEBDOMADAIRE,
  MENSUEL
}