double getInoculationValue(double temperature) {
  if (temperature > 41) {
    return 0;
  }
  return 41 - temperature;
}

double getBulkRiseValue(double temperature) {
  if (temperature > 25) {
    return 25;
  }
  if (temperature <= 20) {
    return 100;
  }
  return 50;
}
