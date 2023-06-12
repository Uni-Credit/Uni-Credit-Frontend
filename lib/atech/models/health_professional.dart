class HealthProfessional {
  get name => "Médico ---";

  static mock() {
    return [
      HealthProfessional(),
      HealthProfessional(),
      HealthProfessional(),
    ];
  }

  toIdentifier() {
    return 1;
  }
}
