# ITC6050 — Week 4 Lab: Star Schema + dbt

## Grain of fct_orders
One row represents a single order line item (one product within one order),
matching the grain of shop.order_item.

## dim_date Concept Check
A pre-built date dimension is better than computing date parts on the fly because
it allows analysts to filter and group by any date attribute (weekend, quarter, month name)
without repeating complex EXTRACT() logic in every query. It also enables easy addition
of business-specific attributes like holidays or fiscal periods that have no formula.

## Degenerate Dimension Concept Check
order_status is kept directly in fct_orders because it has very few distinct values
and is always queried alongside other fact columns, making a separate dim_status table
unnecessary overhead. You would move it to its own dimension table if status had many
attributes (e.g. description, SLA days, is_terminal) that would bloat the fact table.

## Q1 — Monthly Revenue (first 5 rows)

year | month | month_name | orders |  revenue

------+-------+------------+--------+------------

2024 |     6 | June       |    306 |  479380.23

2024 |     7 | July       |   4323 | 6830908.88

2024 |     8 | August     |   4161 | 6559522.11

2024 |     9 | September  |   4071 | 6422552.66

2024 |    10 | October    |   4356 | 6874093.66

## Q2 — Top 10 Categories by Revenue

category   | total_units |  revenue

-------------+-------------+------------

Category 35 |       30232 | 3198942.70

Category 4  |       30016 | 3193969.89

Category 17 |       30086 | 3189322.29

Category 36 |       30066 | 3188868.51

Category 29 |       29996 | 3184984.69

Category 8  |       30033 | 3183941.95

Category 21 |       30130 | 3183899.06

Category 25 |       30123 | 3182314.77

Category 23 |       30119 | 3180774.35

Category 2  |       30094 | 3177537.14

## Q3 — Weekend vs Weekday
is_weekend | orders |   revenue    | avg_line_value

------------+--------+--------------+--------------------

f          |  71245 | 112298635.94 | 315.25

t          |  28755 |  45412928.34 | 315.86

## OLTP vs OLAP Query Comparison
The star schema query for Q1 is slightly longer due to the JOIN with dim_date,
but it is much clearer because date attributes (year, month, month_name) are
pre-computed columns rather than inline EXTRACT() calls. Analytical schemas
trade write complexity (building dimensions) for read simplicity (clean, fast queries).

## dbt Materialization Trade-off
A view recomputes the 500K rows every time it is queried, which is slow for
dashboards or frequent analytical queries. A table stores the result physically,
making reads fast but requiring a dbt run to refresh. For a staging model queried
many times per day, switching to materialized: table is worthwhile.

## dbt run output
1 of 1 OK created sql view model dbt_dev.stg_orders [CREATE VIEW in 0.18s]

Done. PASS=1 WARN=0 ERROR=0 SKIP=0 NO-OP=0 TOTAL=1

## dbt test output

Done. PASS=5 WARN=0 ERROR=0 SKIP=0 NO-OP=0 TOTAL=5

