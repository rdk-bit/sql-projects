# KPI definitions

| KPI | Definition | Expected value (no filters) |
|---|---|---|
| Total Shows | Number of rows in the table. One row = one new series. | 70 |
| Platforms | Count of distinct values in `platform`. | 10 |
| Avg Shows per Platform | Total Shows divided by Platforms. | 7.0 |
| Streaming Shows | Shows where `platform_type` is "Streaming". | 60 |
| Streaming Share | Streaming Shows divided by Total Shows. | 85.7% |
| Non-English Shows | Shows where `language` is not "English". | 8 |
| Share of Shows | Total Shows for the current selection divided by Total Shows for everything currently selected in the slicers. | Netflix: 31.4% |
| Shows Running Total | Cumulative shows from January up to the current month. | 70 by October |
| Top Platform | Platform with the most shows. | Netflix (22) |
| Busiest Month | Month with the most premieres. | March (16) |

Use the "expected value" column to check your dashboard: if a card shows a different number, a measure or a filter is wrong.
