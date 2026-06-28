## Grain of fct_orders
One row represents a single order line item (one product within one order), matching the grain of shop.order_item.

 year | month | month_name | orders |  revenue
------+-------+------------+--------+------------
 2024 |     6 | June       |    306 |  479380.23
 2024 |     7 | July       |   4323 | 6830908.88
 2024 |     8 | August     |   4161 | 6559522.11
 2024 |     9 | September  |   4071 | 6422552.66
 2024 |    10 | October    |   4356 | 6874093.66
 2024 |    11 | November   |   4089 | 6365984.16
 2024 |    12 | December   |   4238 | 6674400.78
 2025 |     1 | January    |   4174 | 6633413.69
 2025 |     2 | February   |   3733 | 5897205.25
 2025 |     3 | March      |   4185 | 6542531.65
 2025 |     4 | April      |   4063 | 6452589.17
 2025 |     5 | May        |   4386 | 6897770.57
 2025 |     6 | June       |   4161 | 6606218.46
 2025 |     7 | July       |   4226 | 6678314.24
 2025 |     8 | August     |   4313 | 6797719.28
 2025 |     9 | September  |   4097 | 6510280.95
 2025 |    10 | October    |   4194 | 6599021.69
 2025 |    11 | November   |   4190 | 6634149.18
 2025 |    12 | December   |   4258 | 6695615.54
 2026 |     1 | January    |   4192 | 6661656.30
 2026 |     2 | February   |   3765 | 5931109.08
 2026 |     3 | March      |   4259 | 6639828.68
 2026 |     4 | April      |   4099 | 6468584.71
 2026 |     5 | May        |   4369 | 6889252.69
 2026 |     6 | June       |   3792 | 5969460.67
(25 rows)

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
(10 rows)

 is_weekend | orders |   revenue    |    avg_line_value
------------+--------+--------------+----------------------
 f          |  71245 | 112298635.94 | 315.2463637869324163
 t          |  28755 |  45412928.34 | 315.8610908711528430
(2 rows)