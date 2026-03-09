# Installation Guide - AK Bank Card System Template

## Prerequisites

Before installing this template, ensure you have:

- [ ] FiveM server running
- [ ] QB-Core framework installed
- [ ] qb-target resource installed
- [ ] qb-progressbar resource installed (optional but recommended)

## Installation Steps

### 1. Place the Resource

Copy the `ak_bankcard_template` folder to your server's `resources` directory:

```
resources/
└── ak_bankcard_template/
    ├── client/
    ├── server/
    ├── html/
    ├── fxmanifest.lua
    ├── README.md
    └── ...
```

### 2. Add to Server Config

Add the following line to your `server.cfg`:

```
ensure ak_bankcard_template
```

### 3. Create Required Item

Add the `bank_card` item to your items database in QB-Core:

```lua
['bank_card'] = {
    label = 'Bank Card',
    weight = 0,
    type = 'item',
    image = 'bank_card.png',
    unique = true,
    useable = false,
    shouldClose = false,
}
```

### 4. Implementation

Now you need to complete the implementation:

1. **Client Implementation** (`client/main.lua`):
   - Set up qb-target for ATMs
   - Implement card control logic
   - Add NUI callbacks
   - Create animations

2. **Server Implementation** (`server/main.lua`):
   - Implement player load event
   - Create transaction processing
   - Add data retrieval functions

3. **HTML/CSS/JS** (`html/` folder):
   - Design PIN entry screen
   - Create bank menu interface
   - Implement form handling
   - Add styling and animations

## Dependencies Explanation

### QB-Core
The framework that manages player data, inventory, and money systems.

### qb-target
Handles ATM targeting system. Allows players to interact with ATM models.

### qb-progressbar (Optional)
Shows a progress bar during ATM card reading animation.

## Troubleshooting

### Resource Not Starting
- Check server console for errors
- Ensure all dependencies are installed
- Verify file paths in `fxmanifest.lua`

### Events Not Triggering
- Check that event names match between client and server
- Verify NUI callbacks are properly registered
- Check browser console (F8) for JavaScript errors

### Functions Not Working
- Ensure QB-Core is properly exported
- Check player data structure
- Verify money types: 'cash' vs 'bank'

## Support

For issues during implementation, refer to:
- QB-Core documentation
- qb-target GitHub repository
- FiveM scripting documentation

---

**Note**: This is a template. Implementation follows QB-Core framework patterns and FiveM scripting best practices.

---

# Kurulum Rehberi - AK Banka Kartı Sistemi Template

## Ön Koşullar

Bu şablonu kurmadan önce aşağıdakilere sahip olduğunuzdan emin olun:

- [ ] FiveM sunucusu çalışıyor
- [ ] QB-Core framework kurulu
- [ ] qb-target kaynağı kurulu
- [ ] qb-progressbar kaynağı kurulu (opsiyonel ama önerilir)

## Kurulum Adımları

### 1. Kaynağı Yerleştirin

`ak_bankcard_template` klasörünü sunucunuzun `resources` dizinine kopyalayın:

```
resources/
└── ak_bankcard_template/
    ├── client/
    ├── server/
    ├── html/
    ├── fxmanifest.lua
    ├── README.md
    └── ...
```

### 2. Sunucu Yapılandırmasına Ekleyin

`server.cfg` dosyanıza aşağıdaki satırı ekleyin:

```
ensure ak_bankcard_template
```

### 3. Gerekli Öğeyi Oluşturun

`bank_card` öğesini QB-Core'daki öğeler veritabanınıza ekleyin:

```lua
['bank_card'] = {
    label = 'Banka Kartı',
    weight = 0,
    type = 'item',
    image = 'bank_card.png',
    unique = true,
    useable = false,
    shouldClose = false,
}
```

### 4. Uygulama

Şimdi uygulamayı tamamlamanız gerekir:

1. **İstemci Uygulaması** (`client/main.lua`):
   - ATM'ler için qb-target kurulumu
   - Kart kontrol mantığını uygulama
   - NUI geri aramaları ekleme
   - Animasyonlar oluşturma

2. **Sunucu Uygulaması** (`server/main.lua`):
   - Oyuncu yükleme olayını uygulama
   - İşlem işlemesini oluşturma
   - Veri alma fonksiyonları ekleme

3. **HTML/CSS/JS** (`html/` klasörü):
   - PIN giriş ekranı tasarlama
   - Banka menüsü arayüzü oluşturma
   - Form işlemesini uygulama
   - Stil ve animasyonlar ekleme

## Bağımlılık Açıklaması

### QB-Core
Oyuncu verilerini, envanteri ve para sistemlerini yöneten çerçeve.

### qb-target
ATM hedefleme sistemini işler. Oyuncuların ATM modelleriyle etkileşim kurmasına izin verir.

### qb-progressbar (Opsiyonel)
ATM kart okuma animasyonu sırasında ilerleme çubuğu gösterir.

## Sorun Giderme

### Kaynak Başlamıyor
- Sunucu konsolunda hataları kontrol edin
- Tüm bağımlılıkların kurulu olduğundan emin olun
- `fxmanifest.lua` dosyasında dosya yollarını doğrulayın

### Olaylar Tetiklenmiyor
- Olay adlarının istemci ve sunucu arasında eşleştiğini kontrol edin
- NUI geri aramaların düzgün kaydedildiğini doğrulayın
- Tarayıcı konsolunda (F8) JavaScript hatalarını kontrol edin

### Fonksiyonlar Çalışmıyor
- QB-Core'un düzgün şekilde dışarı aktarıldığından emin olun
- Oyuncu veri yapısını kontrol edin
- Para türlerini doğrulayın: 'cash' vs 'bank'

## Destek

Uygulama sırasında sorunlar ortaya çıkarsa, aşağıdakilere başvurun:
- QB-Core dokümantasyonu
- qb-target GitHub deposu
- FiveM script yazma dokümantasyonu

---

**Not**: Bu bir şablondur. Uygulama, QB-Core çerçeve desenleri ve FiveM script yazma en iyi uygulamalarını takip eder.
