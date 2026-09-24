double calculateLateFee({required int daysLate, double dailyRate = 2.50}) {
  if (daysLate <= 0) return 0.0;
  return daysLate * dailyRate;
}
