# Airline Delay & Fare Intelligence Platform

An end-to-end data engineering + ML project analyzing a decade of U.S. domestic flight delays and fares, built on real government data (DOT/BTS) at genuine production scale — 70M+ flight records, 450M+ fare records.

## Status: Data engineering foundation complete; first delay classifier built and validated; weather data pipeline built to address its limitations

## What's built so far

**Data ingestion (2015-2025, 10 years):**

- 70,081,041 flight records from DOT's On-Time Performance data (132 monthly files)
- 453,927,271 fare records blending two DOT survey generations — DB1B (2015-Q2 2025) and its replacement DB1C (Q3 2025-present), reconciled across a real mid-history schema cutover when BTS discontinued DB1B in July 2025

**Data quality investigation:**

- Discovered flight number + date isn't a unique key — carriers reuse flight numbers for multiple daily departures — required adding scheduled departure time to correctly identify unique flights
- Investigated and resolved genuine fare data anomalies (sentinel placeholder values, 100x-outlier fares) using data-driven, per-period-recalculated thresholds rather than fixed cutoffs
- Documented (not silently filtered) a known DB1B methodology quirk producing artificially low fares for Southwest itineraries
- Validated the core route/carrier/quarter join between flight and fare data end-to-end (98.8% match rate), with the unmatched 1.2% traced to an explainable DB1B sampling gap on low-volume routes

**Warehouse & pipeline:**

- BigQuery star schema (fact_flights, fact_fares, dimension tables for airports/carriers/dates)
- dbt Core pipeline with custom business-logic data-quality tests and auto-generated documentation

**Delay classification (first pass):**

- RandomForest classifier predicting arrival delays 15+ minutes, using only pre-departure-safe features to avoid leakage
- Validated with time-series cross-validation (not standard k-fold, since delay patterns cluster in time) — mean AUC 0.64, confirmed stable across folds rather than a lucky single split
- Static schedule/route features have a real, limited ceiling — the model can't see day-of-flight operational conditions like weather, which cross-validation showed matters most in exactly the periods (fall/winter) where performance drops

**Weather data pipeline:**

- Mapped all 395 airports in the dataset to NOAA weather stations, using a verified IATA-to-ICAO lookup after an initial inferred-pattern approach failed for Alaska, Hawaii, and U.S. territories
- Pulled ~4,345 station-years of daily weather data (2015-2025) from NOAA's GHCN-Daily dataset, after discovering the originally planned API was down on NOAA's end
- Next: integrate as classifier features to address the ceiling found above

## Stack

BigQuery · dbt Core · Python (pandas, scikit-learn) · NOAA weather data · Power BI (planned)

## Coming next

Rebuild the delay classifier with weather features, then root-cause attribution by DOT delay-cause category, followed by a GenAI text-to-SQL agent over this warehouse.
