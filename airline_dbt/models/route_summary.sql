WITH flights_agg AS (
    SELECT
        Year,
        Quarter,
        Reporting_Airline AS carrier,
        Origin,
        Dest,
        COUNT(*) AS total_flights,
        AVG(DepDelay) AS avg_dep_delay,
        AVG(DepDel15) AS pct_delayed_15
    FROM {{ source('airline_data', 'fact_flights') }}
    GROUP BY Year, Quarter, Reporting_Airline, Origin, Dest
),

fares_agg AS (
    SELECT
        Year,
        Quarter,
        OpCarrier AS carrier,
        Origin,
        Dest,
        AVG(MktFare) AS avg_fare,
        SUM(Passengers) AS total_passengers
    FROM {{ source('airline_data', 'fact_fares') }}
    GROUP BY Year, Quarter, OpCarrier, Origin, Dest
)

SELECT
    f.Year,
    f.Quarter,
    f.carrier,
    f.Origin,
    f.Dest,
    f.total_flights,
    f.avg_dep_delay,
    f.pct_delayed_15,
    fa.avg_fare,
    fa.total_passengers
FROM flights_agg f
LEFT JOIN fares_agg fa
    ON f.Year = fa.Year
    AND f.Quarter = fa.Quarter
    AND f.carrier = fa.carrier
    AND f.Origin = fa.Origin
    AND f.Dest = fa.Dest