📊 Daily Revenue Drop Analysis (April 18, 2024)
📌 Business Problem
Pada tanggal 18 April 2024 terjadi penurunan revenue (-13.95%) dibandingkan hari sebelumnya, pada periode minggu sebelumnya juga menunjukkan pelemahan dan trend avg dalam 7 hari terakhir mengalami penurunan sehingga dapat dipastikan ini bukan noise.
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
Day-over-Day (DoD) Growth -- Pertumbuhan Harian
Week-over-Week (WoW) Growth -- Pertumbuhan Mingguan
Rolling Average 7 hari -- Digunakan untuk melihat trend revenue yang lebih stabil dalam 7 hari terakhir

---

2️⃣ Revenue Decomposition
Revenue dianalisis menggunakan pendekatan:

Revenue = Volume Order × AOV

Hasil:
Volume order turun signifikan ( 9% )
AOV turun relatif moderat ( 4% )

Kesimpulan awal: penurunan revenue dipicu oleh turunnya jumlah transaksi, bukan penurunan nilai pembelian.

---

3️⃣ Customer Analysis
Jumlah customer unik pada hari tersebut turun (9%) sejalan dengan volume order.
Hal ini menunjukkan bahwa penurunan terjadi karena berkurangnya customer yang bertransaksi.

---

4️⃣ Customer Segmentation
Dilakukan analisis per customer type untuk mengidentifikasi apakah penurunan disebabkan oleh customer yang sudah ada atau bukan.
Temuan:
New -0.84%
Returning -11.59%

---

5️⃣ AOV per Segment
Temuan:
AoV New - 8.99%
AoV Returning -4.09%

• AOV Returning relatif stabil (penurunan moderat <5%)
• AOV New turun lebih dalam, namun kontribusi terhadap total revenue lebih kecil dibanding Returning

👉 Tidak terdapat indikasi pergeseran signifikan ke produk bernilai lebih rendah pada segment returning.

---

🎯 Key Insight
Penurunan revenue pada 18 April 2024 terutama didorong oleh penurunan returning customer (-11.59%), sementara AOV hanya mengalami pelemahan moderat. Hal ini menunjukkan tekanan utama berada pada sisi retention, bukan perubahan signifikan dalam perilaku belanja.

---

📌 Recommendation
Mengingat penurunan didominasi oleh returning customer, fokus utama perbaikan sebaiknya diarahkan pada strategi retention dan engagement existing customer.
