CREATE OR REPLACE TABLE `airline-delay-platform.airline_data.dim_carrier` AS
SELECT * FROM UNNEST([
  STRUCT("9E" AS carrier_code, "Endeavor Air" AS carrier_name),
  STRUCT("AA" AS carrier_code, "American Airlines" AS carrier_name),
  STRUCT("AS" AS carrier_code, "Alaska Airlines" AS carrier_name),
  STRUCT("B6" AS carrier_code, "JetBlue Airways" AS carrier_name),
  STRUCT("DL" AS carrier_code, "Delta Air Lines" AS carrier_name),
  STRUCT("EV" AS carrier_code, "ExpressJet Airlines" AS carrier_name),
  STRUCT("F9" AS carrier_code, "Frontier Airlines" AS carrier_name),
  STRUCT("G4" AS carrier_code, "Allegiant Air" AS carrier_name),
  STRUCT("HA" AS carrier_code, "Hawaiian Airlines" AS carrier_name),
  STRUCT("MQ" AS carrier_code, "Envoy Air" AS carrier_name),
  STRUCT("NK" AS carrier_code, "Spirit Airlines" AS carrier_name),
  STRUCT("OH" AS carrier_code, "PSA Airlines" AS carrier_name),
  STRUCT("OO" AS carrier_code, "SkyWest Airlines" AS carrier_name),
  STRUCT("QX" AS carrier_code, "Horizon Air" AS carrier_name),
  STRUCT("UA" AS carrier_code, "United Airlines" AS carrier_name),
  STRUCT("US" AS carrier_code, "US Airways" AS carrier_name),
  STRUCT("VX" AS carrier_code, "Virgin America" AS carrier_name),
  STRUCT("WN" AS carrier_code, "Southwest Airlines" AS carrier_name),
  STRUCT("YV" AS carrier_code, "Mesa Airlines" AS carrier_name),
  STRUCT("YX" AS carrier_code, "Republic Airway" AS carrier_name)
]);