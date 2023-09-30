double getFlourValue(double totalWeight, double hydration, double saltLevel,
    double inoculation) {
  if (totalWeight.isNegative ||
      hydration.isNegative ||
      saltLevel.isNegative ||
      inoculation.isNegative) {
    return 0;
  }
  return totalWeight /
      (1 + hydration / 100 + saltLevel / 100 + inoculation / 100);
}

double getNonFlourIngredientValue(double flour, double dependentLevel) {
  if (dependentLevel.isNegative) {
    return 0;
  }
  return flour * (dependentLevel / 100);
}
