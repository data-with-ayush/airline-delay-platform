# Airline Delay & Fare Intelligence Platform

An end-to-end data engineering + ML project analyzing a decade of U.S. domestic flight delays and fares, built on real government data (DOT/BTS) at genuine production scale — 70M+ flight records, 450M+ fare records.

## Status: Data engineering foundation complete; ML classification in progress

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

## Stack
BigQuery · dbt Core · Python (pandas) · scikit-learn (in progress) · Power BI (planned)

## Coming next
Classification model for flight delay prediction with root-cause attribution, followed by a GenAI text-to-SQL agent over this warehouse.