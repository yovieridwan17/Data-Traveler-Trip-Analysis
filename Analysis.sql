/*
TUJUAN BISNIS
-------------
Kita mau ngerti pola perjalanan traveler:
1. Destinasi favorit
2. Karakter traveler (umur, gender, nationality)
3. Durasi trip
4. Biaya perjalanan (akomodasi + transport)
5. Pola waktu (bulan / tahun)

Output yang diharapkan:
- Insight destinasi paling populer & paling mahal
- Segmentasi traveler
- Peluang optimasi biaya & paket travel
*/

-- Cek struktur kolom
SELECT *
FROM clean
LIMIT 10;


-- Cek apakah ada data null
SELECT
    COUNT(*) AS total_data,
    SUM(CASE WHEN destination IS NULL THEN 1 ELSE 0 END) AS null_destination,
    SUM(CASE WHEN `Traveler name` IS NULL THEN 1 ELSE 0 END) AS null_traveler,
    SUM(CASE WHEN `Accommodation cost` IS NULL THEN 1 ELSE 0 END) AS null_Accommodation_cost,
    SUM(CASE WHEN `Transportation cost` IS NULL THEN 1 ELSE 0 END) AS null_Transportation_cost
FROM clean;


/*
Kalau null minim → data aman buat analisis lanjut
Kalau ada null di cost → harus hati-hati saat hitung total biaya
*/


-- Destinasi paling sering dikunjungi
SELECT
    destination,
    COUNT(*) AS total_trip
FROM clean
GROUP BY destination
ORDER BY total_trip DESC;


-- Rata-rata durasi per destinasi
SELECT
    destination,
    ROUND(AVG(`Duration (days)`), 1) AS avg_duration
FROM clean
GROUP BY destination
ORDER BY avg_duration DESC;

/*
Destinasi dengan trip terbanyak = kandidat best seller
Destinasi dengan durasi lama = biasanya leisure / honeymoon
*/


-- Distribusi gender
SELECT
    `Traveler gender`,
    COUNT(*) AS total_traveler
FROM clean
GROUP BY `Traveler gender`;


-- Rata-rata umur traveler
SELECT
    ROUND(AVG(`Traveler age`),1) AS avg_age,
    MIN(`Traveler age`) AS min_age,
    MAX(`Traveler age`) AS max_age
FROM clean;

-- Traveler berdasarkan nationality
SELECT
    `Traveler nationality`,
    COUNT(*) AS total_trip
FROM clean
GROUP BY `Traveler nationality`
ORDER BY total_trip DESC;



-- Traveler berdasarkan nationality
SELECT
    `Traveler nationality`,
    COUNT(*) AS total_trip
FROM clean
GROUP BY `Traveler nationality`
ORDER BY total_trip DESC;


/*
Mayoritas umur produktif → cocok buat paket aktif & city trip
Nationality dominan → target marketing per region
*/


-- Trip per tahun
SELECT
    YEAR(`Start date`) AS tahun,
    COUNT(*) AS total_trip
FROM clean
GROUP BY YEAR(`Start date`)
ORDER BY tahun;


-- Trip per bulan
SELECT
    MONTH(`Start date`) AS bulan,
    COUNT(*) AS total_trip
FROM clean
GROUP BY MONTH(`Start date`)
ORDER BY bulan;


/*
Peak season bisa kelihatan dari bulan dengan trip terbanyak
Bisa dipakai buat dynamic pricing
*/


-- Total biaya per trip
SELECT
    `Trip ID`,
    destination,
    `Accommodation cost` + `Transportation cost` AS total_cost
FROM clean;


-- Rata-rata biaya per destinasi
SELECT
    destination,
    ROUND(AVG(`Accommodation cost` + `Transportation cost`),0) AS avg_total_cost
FROM clean
GROUP BY destination
ORDER BY avg_total_cost DESC;


-- Tipe akomodasi paling mahal
SELECT
    `accommodation type`,
    ROUND(AVG(`Accommodation cost`),0) AS avg_cost
FROM clean
GROUP BY `accommodation type`
ORDER BY avg_cost DESC;


-- Tipe transportasi paling mahal
SELECT
    `Transportation type`,
    ROUND(AVG(`Transportation cost`),0) AS avg_cost
FROM clean
GROUP BY `Transportation type`
ORDER BY avg_cost DESC;

/*
Resort & Plane biasanya paling mahal
Bisa dibuat paket budget vs luxury
*/

-- Biaya per hari
SELECT
    `Trip ID`,
    destination,
    `Duration (days)`,
    (`Accommodation cost` + `Transportation cost`) / `Duration (days)` AS cost_per_day
FROM clean
ORDER BY cost_per_day DESC;

/*
Trip mahal tapi durasi pendek → city premium
Trip murah durasi panjang → cocok buat backpacker
*/



/*
INSIGHT UTAMA
-------------
1. Destinasi populer = peluang paket bundling
2. Mayoritas traveler umur 25–45 → market utama
3. Resort + Flight = segmen luxury
4. Hostel + Train = segmen budget
5. Peak month → naikkan harga, low season → promo

REKOMENDASI
-----------
- Buat 3 segment paket: Budget, Regular, Luxury
- Target iklan berdasarkan nationality dominan
- Optimasi harga berdasarkan bulan perjalanan
*/











