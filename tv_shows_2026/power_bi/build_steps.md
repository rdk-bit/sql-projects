# How to build it in Power BI Desktop (about 45 minutes)

## 1. Load the data
1. Open Power BI Desktop > **Get data** > **Text/CSV** > pick `data/tv_shows_2026.csv` > **Transform Data**.
2. In Power Query, check each column's type: `premiere_date` must be **Date** (click the icon in its header); all other columns **Text**.
3. Check for blanks: View > tick **Column quality**. There should be 0% errors and 0% empty.
4. **Close & Apply**.

## 2. Add columns and measures
Open `dax_measures.md` and copy each item in: first the two calculated columns, then the measures. After each one, check it against `kpi_definitions.md`.

## 3. Page layout (one page, 16:9)
Top row, four **Card** visuals: Total Shows, Platforms, Streaming Share, Top Platform.

Middle row:
- **Clustered bar chart**: Axis = `platform`, Values = `Total Shows`. Sort descending. Turn on data labels.
- **Column chart**: Axis = `Month` (sorted by Month Number), Values = `Total Shows`.

Bottom row:
- **Line chart**: Axis = `Month`, Values = `Shows Running Total`.
- **Treemap**: Group = `genre`, Values = `Total Shows`.
- **Donut chart**: Legend = `format`, Values = `Total Shows`.

Right side, three **Slicers** (Dropdown style): `platform_type`, `format`, `language`.

Title text box: "New TV Shows of 2026: Who Premiered What" and a subtitle "70 new series, January to October 2026. Source: Wikipedia lists of original programming."

## 4. Make it look clean
- Use one colour family and keep the text dark and large enough to read.
- Align visuals with the grid (Format > Position) and give each a clear title.
- Hover tooltips: leave the defaults on.
- Test the slicers: pick "Streaming" and check the cards change (Total Shows should become 60).

## 5. Add a short "Key findings" text box
Write findings from your own dashboard. From the data:
- Netflix has the most new series (22 of 70, 31%), ahead of Prime Video and Apple TV (13 each).
- Streaming accounts for about 86% of premieres (60 of 70).
- March is the busiest month (16 premieres); June and August are the quietest.
- Scripted series are 53 of 70, and Comedy is the top genre (17).

## 6. Save and share
1. File > **Save as** `tv_shows_2026_dashboard.pbix`.
2. File > **Export** > **Export to PDF**, and take a PNG screenshot too.
3. Put the `.pbix`, the PDF and the screenshot in a `powerbi` folder in your GitHub repo (GitHub Desktop > commit > push).
4. Add a "Dashboard" line to the project README with the screenshot.
5. Add the GitHub link to your resume project line.

## Common problems
- **Months out of order**: set Sort by column to `Month Number`.
- **Running total shows the same number everywhere**: put `Month` on the axis, not `premiere_date`.
- **Card shows "(Blank)"**: check the column names match exactly (lower case, with underscores).
