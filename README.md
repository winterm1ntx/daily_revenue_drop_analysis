📊 Daily Revenue Drop Analysis (April 18, 2024)
📌 Business Problem
Pada tanggal 18 April 2024 terjadi penurunan revenue dibandingkan hari sebelumnya.
Analisis ini bertujuan untuk mengidentifikasi penyebab utama penurunan hari tersebut.

---

🧪 Data Validation
Dataset terdiri dari 1.000.000 transaksi.

Validasi yang dilakukan:
Tidak ditemukan missing value pada kolom utama yang ingin saya analisis (date, transaction_id, total_items, total_cost, customer_name, city)

Dataset dinyatakan layak untuk saya analisis.

---

🔎 Analytical Approach
1️⃣ Trend Validation
Untuk menghindari kesalahan interpretasi akibat fluktuasi harian, digunakan:
Day-over-Day (DoD) Growth
Week-over-Week (WoW) Growth
Rolling Average 7 hari

---

2️⃣ Revenue Decomposition
Revenue dianalisis menggunakan pendekatan:

Revenue = Volume Order × AOV

Hasil:
Volume order turun signifikan ( 9% )
AOV relatif stabil ( hanya turun 2% )

Kesimpulan awal: penurunan revenue dipicu oleh turunnya jumlah transaksi, bukan penurunan nilai pembelian.

---

3️⃣ Customer Analysis
Jumlah customer unik pada hari tersebut turun sejalan dengan volume order.
Hal ini menunjukkan bahwa penurunan terjadi karena berkurangnya customer yang bertransaksi.

---

4️⃣ Regional Breakdown
Dilakukan analisis per kota untuk mengidentifikasi apakah penurunan bersifat menyeluruh atau lokal.

Temuan:
Kota Dallas mengalami penurunan paling tajam.
Wilayah lain ada yang turun juga namun tidak setajam kota Dallas.
Beberapa wilayah bahkan mencatat sedikit pertumbuhan positif

---
🎯 Key Insight
Penurunan revenue pada 18 April 2024 terutama disebabkan oleh penurunan volume transaksi yang terkonsentrasi di wilayah Dallas.
Wilayah lain tidak menunjukkan penurunan signifikan.

Hal ini mengindikasikan kemungkinan adanya faktor lokal, bukan penurunan demand secara keseluruhan.

---

📌 Recommendation
Perlu dilakukan validasi lebih lanjut terhadap operasional di wilayah Dallas sebelum mengambil keputusan strategis seperti perubahan harga atau intervensi marketing.

---

📂 Files
analysis.sql → Query lengkap analisis
