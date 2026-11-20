# DAX for the TV Shows 2026 dashboard

Table name used below: `tv_shows_2026` (the name Power BI gives the CSV).

## Calculated columns (Table tools > New column)

```DAX
Month Number = MONTH(tv_shows_2026[premiere_date])
```
```DAX
Month = FORMAT(tv_shows_2026[premiere_date], "mmm")
```
Then click the `Month` column > Column tools > **Sort by column** > `Month Number`, so months show Jan, Feb, Mar instead of alphabetical order.

## Measures (Home > New measure)

```DAX
Total Shows = COUNTROWS(tv_shows_2026)
```
```DAX
Platforms = DISTINCTCOUNT(tv_shows_2026[platform])
```
```DAX
Avg Shows per Platform = DIVIDE([Total Shows], [Platforms])
```
```DAX
Streaming Shows = CALCULATE([Total Shows], tv_shows_2026[platform_type] = "Streaming")
```
```DAX
Streaming Share = DIVIDE([Streaming Shows], [Total Shows])
```
```DAX
Non-English Shows = CALCULATE([Total Shows], tv_shows_2026[language] <> "English")
```
```DAX
Share of Shows = DIVIDE([Total Shows], CALCULATE([Total Shows], ALLSELECTED()))
```
```DAX
Shows Running Total =
CALCULATE(
    [Total Shows],
    FILTER(
        ALLSELECTED(tv_shows_2026[Month Number]),
        tv_shows_2026[Month Number] <= MAX(tv_shows_2026[Month Number])
    )
)
```
```DAX
Top Platform =
VAR t = TOPN(1, VALUES(tv_shows_2026[platform]), [Total Shows], DESC)
RETURN MAXX(t, tv_shows_2026[platform])
```
```DAX
Busiest Month =
VAR t = TOPN(1, VALUES(tv_shows_2026[Month Number]), [Total Shows], DESC)
RETURN FORMAT(DATE(2026, MAXX(t, tv_shows_2026[Month Number]), 1), "mmmm")
```

Format `Streaming Share` and `Share of Shows` as Percentage (Measure tools > Format).
