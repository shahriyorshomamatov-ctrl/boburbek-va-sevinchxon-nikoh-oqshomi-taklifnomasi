# Boburbek & Sevinchxon — Nikoh to'yi taklifnomasi

Bitta faylda yozilgan (single-file) zamonaviy to'y taklifnomasi. Hech qanday `npm`,
build yoki framework talab qilinmaydi — fayllarni GitHub Pages'ga qo'ysangiz, ishlayveradi.

## Fayllar

| Fayl | Izoh |
|---|---|
| `index.html` | Butun sayt: HTML + Tailwind (CDN) + CSS + JavaScript |
| `music.m4a`  | Fon musiqasi — "Shahloxonim — Yor-yor" (AAC/M4A, 4:01) |

> Fayl aslida MP4/AAC formatida bo'lgani uchun `.m4a` nomi bilan saqlandi —
> `.mp3` nomi bilan ba'zi brauzerlar (ayniqsa Safari) uni ochmasligi mumkin edi.
> `index.html` ichida `music.mp3` ham zaxira manba sifatida ko'rsatilgan, ya'ni
> keyinchalik haqiqiy MP3 fayl qo'ysangiz ham ishlaydi.

## Musiqa qanday ishlaydi

Musiqa sayt ochilishi bilan avtomatik yoqiladi. Agar brauzer avtomatik ijroni
to'sib qo'ysa (mobil qurilmalarda ko'p uchraydi — Chrome va Safari tovushli
avtomatik ijroga ruxsat bermaydi), musiqa foydalanuvchining **birinchi
teginishida** — odatda muhrni bosganda — o'zi yoqiladi. O'ng pastdagi doira
tugma orqali istalgan payt o'chirish yoki qayta yoqish mumkin.

## GitHub Pages'ga joylash

```bash
git init
git add .
git commit -m "Nikoh to'yi taklifnomasi"
git branch -M main
git remote add origin https://github.com/<foydalanuvchi>/<repo>.git
git push -u origin main
```

So'ng: **Settings → Pages → Source: `Deploy from a branch` → Branch: `main` / `(root)` → Save.**
Bir-ikki daqiqadan so'ng sayt `https://<foydalanuvchi>.github.io/<repo>/` manzilida ochiladi.

## Sozlamalarni o'zgartirish

`index.html` ichidagi JavaScript boshida bitta `CFG` obyekti bor — sana, vaqt va
manzilni faqat shu yerdan o'zgartirasiz:

```js
var CFG = {
  countdownISO:  "2026-10-04T18:00:00+05:00",  // hisoblagich nishoni
  countdownLabel:"4-oktabr, soat 18:00",
  eventStartISO: "2026-10-04T18:00:00+05:00",  // taqvimga qo'shiladigan vaqt
  eventEndISO:   "2026-10-04T23:00:00+05:00",
  lat: 40.226930,                              // "Tanho" to'yxonasi koordinatasi
  lng: 65.305235,
  yandexUrl: "https://yandex.uz/maps/org/tanxo/229357095401/"
};
```

Vaqtlar `+05:00` (O'zbekiston vaqti) bilan yozilgan, shuning uchun hisoblagich
mehmon qaysi davlatda bo'lishidan qat'i nazar to'g'ri ishlaydi.

## Sahifa tuzilishi

1. Muhrli konvert — muhr bosilganda yorilib, konvert ochiladi
2. Asosiy varaq — ismlar, sana, manzil
3. Taklif matni
4. Jonli hisoblagich ("Nikoh kechasiga qoldi")
5. Tadbir tartibi
6. Manzil va lokatsiya — Google va Yandex Xaritalar tugmalari
7. Taqvimga qo'shish — Google Calendar havolasi va `.ics` fayl
8. Footer — "Hurmat bilan: Ota-onalar"
