# databas_inlamning2

<img width="849" height="590" alt="image" src="https://github.com/user-attachments/assets/1249274a-59e4-4df7-ad7a-e64ad9cc1c58" />


## Beskrivning
Jag har designat databasen med flera separata tabeller: Kunder, Beställningar, Böcker, Orderrader och Kundlogg. Genom att använda primary keys och foreign keys säkerställs att relationerna mellan tabellerna är korrekta och att dataintegriteten bevaras. Jag har även använt constraints för att förhindra ogiltiga värden samt triggers för att automatisera lageruppdatering och loggning av nya kunder.

## Reflektion och Analys
Om databasen i framtiden skulle hantera 100 000 kunder i stället för ett fåtal testposter skulle prestanda bli mycket viktigare. Då bör man undvika att hämta mer data än nödvändigt, till exempel genom att inte använda `SELECT *` utan i stället bara välja de kolumner som behövs.

Index blir också viktigare för att snabba upp sökningar och filtreringar, särskilt på kolumner som ofta används i `WHERE`, `JOIN` och `ORDER BY`, som exempelvis Email, KundID och OrderID.
