const String title = 'Sourdoc';
const String appBarHomeHelpButtonTooltip = 'Open help page';
const String formIntro =
    'Change these settings, and the ingredients and fermentation values will automatically update.';
const String headerIngredients = 'Ingredients';
const String headerFermentation = 'Fermentation';
const String inputPrefixWeight = 'Target bread weight';
const String inputPrefixHydration = 'Hydration level';
const String inputPrefixSalt = 'Salt level';
const String inputPrefixTemperature = 'Ambient temperature';
String getInputErrorMessage(double maxValue) =>
    'The maximum value supported by this field is $maxValue';
const String additionalInfoInoculation =
    '''Refers to the proportion of sourdough starter (or levain) you use in relation to the total amount of flour in your dough.
It's a key factor that influences the fermentation process and the characteristics of your bread. The inoculation level percentage affects the fermentation rate, flavor profile, and texture of your sourdough bread. Higher percentages result in a faster and more pronounced fermentation, which can lead to a stronger sour flavor and more open crumb structure. Lower percentages result in a milder flavor and a slower fermentation.
This value is directly affected by ambient temperature; for example, a colder environment will require a stronger fermantation and so a higher inoculation level.''';
const String additionalInfoDoughRise =
    '''Indicates how much should the dough should rise, compared to its original volume at the moment of mixing the starter, in order to consider the bulk fermentation phase completed. Once your dough reaches the target level, you can begin the shaping phase.
It is recommended to avoid basing the bulk fermentation duration on time, as it depends on too many variables; instead, the percentage of volume rise is a more reliable way to measure that that produces more consistent results.
This percentage is directly affected by the ambient temperature; for example, in a warmer environment the dough will need to rise less to be considered ready for shaping.''';
const String degreesCelsius = 'Celsius';
const String degreesFarenheit = 'Farenheit';
const String labelTemperatureUnit = 'Temperature unit';
const String variableLabelFlour = 'Flour';
const String variableLabelWater = 'Water';
const String variableLabelLevain = 'Levain';
const String variableLabelSalt = 'Salt';
const String variableLabelInoculation = 'Inoculation level';
const String variableLabelDoughRise = 'Target dough rise';
const String unitGrams = 'g';
const String unitPercent = '%';
const String unitDegreesCelsius = 'ºC';
const String unitDegreesFarenheit = 'ºF';
const String helpPageTitle = 'Help';
const String appBarHelpCloseButtonTooltip = 'Close help page';
const String labelVersion = 'Version';
const String labelCommit = 'Commit';

// Accessibility
const String a11yAppBarHomeTitleLabel = 'Sourdoc home page title';
const String a11yAppBarHomeTitleIconLabel =
    'Sourdoc home page title calculator icon';
const String a11yAppBarHomeHelpButtonLabel = 'Help page button';
const String a11yAppBarHomeHelpButtonHint = 'When pressed opens the help page';
const String a11yAppBarHomeHelpButtonIconLabel = 'Question mark icon';
const String a11yFormIntroLabel = 'Instructions on how to use this page';
const String a11yTemperatureUnitChoiceLabel =
    'A toggle to choose your temperature unit of measure';
String getA11yTextFieldLabel(String fieldName) =>
    'Input field for the $fieldName';
const String a11yTextFieldHint =
    'When this value is changed, all variables depending on it are automatically updated';
const String a11yTextFieldErrorLabel = 'Error message for the input field';
String getA11yHeaderLabel(String headerText) => '$headerText section header';
const String a11yVariableLabelLabel = 'Name of this variable';
const String a11yVariableValueLabel = 'Value of this variable';
const String a11yVariableInfoButtonLabel = 'Additional information button';
const String a11yVariableInfoButtonHint =
    'When pressed opens an overlay with the explanation of this variable';
const String a11yVariableInfotTextLabel =
    'Additional information about this variable';
const String a11yAppBarHelpTitleLabel = 'Sourdoc help page title';
const String a11yAppBarHelpCloseButtonLabel = 'Close help page button';
const String a11yAppBarHelpCloseButtonHint =
    'When pressed closes the help page';
const String a11yAppBarHelpCloseButtonIconLabel = 'Close icon';
