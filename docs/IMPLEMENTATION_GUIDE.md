# Implementation Guide - AK Bank Card System

This guide provides a step-by-step approach to completing the template code.

## Phase 1: Server-Side Basics

### 1.1 Export QB-Core
```lua
local QBCore = exports['qb-core']:GetCoreObject()
```

### 1.2 Implement Player Load Event
When a player loads, give them a bank card:
- Get player object
- Check if they have `bank_card` item
- If not, create one with info: citizenid, cardholder name, IBAN, PIN

### 1.3 Create PIN Request Event
When player uses ATM:
- Get bank_card from player's inventory
- Extract PIN from card metadata
- Send PIN to client for verification

### 1.4 Data Retrieval Event
When PIN is verified:
- Get player's full name
- Get player's IBAN/account number
- Get player's bank balance
- Send to client

### 1.5 Transaction Processing
For deposit/withdraw operations:
- Validate amount (must be positive)
- Check if player has enough money
- Remove from source
- Add to destination
- Update UI with new balance

## Phase 2: Client-Side Implementation

### 2.1 Setup ATM Target
Register targets for ATM models:
```lua
exports['qb-target']:AddTargetModel({model list}, {
    options = {
        event = "ak_bankcard:client:CardControl"
    }
})
```

### 2.2 Card Control Event
When player interacts with ATM:
- Check if player has bank_card
- Start ATM animation
- Show progressbar (optional)
- Request PIN from server after animation

### 2.3 PIN Display Event
When server sends PIN:
- Set NUI focus
- Send message to HTML with PIN code
- Show PIN entry screen

### 2.4 NUI Callbacks
- **pinSuccess**: PIN is correct → request bank data
- **pinError**: PIN is wrong → show error notification
- **doAction**: Process deposit/withdraw
- **close**: Clean up and close UI

## Phase 3: Frontend (HTML/CSS/JS)

### 3.1 PIN Screen
- Accept 4-digit numeric input
- Display dots for each digit
- Verify against sent PIN
- Have clear/cancel buttons

### 3.2 Bank Menu Screen
- Display credit card design
- Show account details:
  - Cardholder name
  - IBAN/Account number
  - Balance
- Transaction buttons:
  - Deposit
  - Withdraw

### 3.3 JavaScript Logic
- Handle NUI messages
- Process user input
- Send callbacks back to FiveM
- Update UI dynamically
- Handle errors gracefully

## Phase 4: Advanced Features (Optional)

### 4.1 Transaction History
Track and display recent transactions

### 4.2 PIN Change
Allow players to change their PIN

### 4.3 Multiple ATMs
Create different ATM locations

### 4.4 Database Logging
Log all transactions for admin review

### 4.5 Security Features
- Account lockout after failed PINs
- Transaction limits
- Time-based access restrictions

## Common Implementation Patterns

### Getting Player Money
```lua
local player = QBCore.Functions.GetPlayer(src)
local cashMoney = player.PlayerData.money.cash
local bankMoney = player.PlayerData.money.bank
```

### Adding/Removing Money
```lua
Player.Functions.AddMoney('bank', amount, 'Deposit Reason')
Player.Functions.RemoveMoney('cash', amount, 'Withdrawal Reason')
```

### Working with Items
```lua
local item = Player.Functions.GetItemByName('bank_card')
local info = item.info -- Contains custom data
```

### NUI Communication
```lua
-- Send to client
TriggerClientEvent('ak_bankcard:client:Event', src, data)

-- From client to HTML
SendNUIMessage({type = 'openPin', pin = pinCode})

-- Callback from HTML to client
$.post('https://' + GetParentResourceName() + '/callbackName', JSON.stringify(data), function(data) {})
```

## Testing Checklist

- [ ] Script starts without errors
- [ ] Players receive bank card on spawn
- [ ] Can interact with ATM models
- [ ] PIN entry screen appears
- [ ] Correct PIN opens bank menu
- [ ] Wrong PIN shows error
- [ ] Deposit/withdraw works
- [ ] Balance updates correctly
- [ ] Transactions are reversible
- [ ] No duplication of money possible
- [ ] UI closes properly
- [ ] Animation clears on close

## Performance Optimization

- Minimize NUI message frequency
- Use debouncing for rapid interactions
- Optimize database queries
- Clean up event listeners
- Remove debug logging in production

---

**Remember**: Always test thoroughly before deploying to a live server!

---

# Uygulama Rehberi - AK Banka Kartı Sistemi

Bu rehber, şablon kodunu tamamlamaya adım adım bir yaklaşım sağlar.

## Aşama 1: Sunucu Tarafı Temelleri

### 1.1 QB-Core'u Dışarı Aktarın
```lua
local QBCore = exports['qb-core']:GetCoreObject()
```

### 1.2 Oyuncu Yükleme Olayını Uygulayın
Bir oyuncu yüklendiğinde, ona bir banka kartı verin:
- Oyuncu nesnesini alın
- `bank_card` öğesine sahip olup olmadığını kontrol edin
- Değilse, oluşturun: citizenid, kart sahibi adı, IBAN, PIN

### 1.3 PIN İstek Olayını Oluşturun
Oyuncu ATM'yi kullandığında:
- Oyuncunun envanterinden bank_card alın
- PIN'i kart meta verilerinden çıkarın
- Doğrulama için PIN'i istemciye gönderin

### 1.4 Veri Alma Olayı
PIN doğrulandığında:
- Oyuncunun tam adını alın
- Oyuncunun IBAN/hesap numarasını alın
- Oyuncunun banka bakiyesini alın
- İstemciye gönderin

### 1.5 İşlem İşlemesi
Para yatırma/çekme işlemleri için:
- Tutarı doğrulayın (pozitif olmalı)
- Oyuncunun yeterli parası olup olmadığını kontrol edin
- Kaynaktan kaldırın
- Hedefe ekleyin
- UI'yi yeni bakiye ile güncelleyin

## Aşama 2: İstemci Tarafı Uygulama

### 2.1 ATM Hedefini Kurun
ATM modelleri için hedefleri kaydedin:
```lua
exports['qb-target']:AddTargetModel({model listesi}, {
    options = {
        event = "ak_bankcard:client:CardControl"
    }
})
```

### 2.2 Kart Kontrol Olayı
Oyuncu ATM ile etkileşim kurduğunda:
- Oyuncunun bank_card'ı olup olmadığını kontrol edin
- ATM animasyonunu başlatın
- İlerleme çubuğunu gösterin (opsiyonel)
- Animasyondan sonra PIN'i sunucudan talep edin

### 2.3 PIN Ekranı Olayı
Sunucu PIN gönderdiğinde:
- NUI odağını ayarlayın
- PIN kodu ile HTML'ye ileti gönderin
- PIN giriş ekranını gösterin

### 2.4 NUI Geri Aramaları
- **pinSuccess**: PIN doğru → banka verilerini talep edin
- **pinError**: PIN yanlış → hata bildirimi gösterin
- **doAction**: Para yatırma/çekme işlemini gerçekleştirin
- **close**: Temizleyin ve UI'yi kapatın

## Aşama 3: Ön Uç (HTML/CSS/JS)

### 3.1 PIN Ekranı
- 4 haneli sayısal girişi kabul edin
- Her hane için noktalar gösterin
- Gönderilen PIN'le karşılaştırın
- Temizle/İptal düğmeleri ekleyin

### 3.2 Banka Menüsü Ekranı
- Kredi kartı tasarımını gösterin
- Hesap detaylarını gösterin:
  - Kart sahibi adı
  - IBAN/Hesap numarası
  - Bakiye
- İşlem düğmeleri:
  - Para Yatır
  - Para Çek

### 3.3 JavaScript Mantığı
- NUI ileti işlemesini yönetin
- Kullanıcı giriş işlemesini yapın
- FiveM'e geri aramaları gönderin
- UI'yi dinamik olarak güncelleyin
- Hataları zarif bir şekilde işleyin

## Aşama 4: Gelişmiş Özellikler (Opsiyonel)

### 4.1 İşlem Geçmişi
Son işlemleri izleyin ve görüntüleyin

### 4.2 PIN Değişikliği
Oyunculara PIN değiştirmeyi izin verin

### 4.3 Birden Fazla ATM
Farklı ATM konumları oluşturun

### 4.4 Veritabanı Günlüğü
Yönetici incelemesi için tüm işlemleri kaydedin

### 4.5 Güvenlik Özellikleri
- Başarısız PIN'lerden sonra hesap kilitlemesi
- İşlem limitleri
- Zaman tabanlı erişim kısıtlamaları

## Yaygın Uygulama Desenleri

### Oyuncu Parasını Almak
```lua
local player = QBCore.Functions.GetPlayer(src)
local cashMoney = player.PlayerData.money.cash
local bankMoney = player.PlayerData.money.bank
```

### Para Ekleme/Kaldırma
```lua
Player.Functions.AddMoney('bank', amount, 'Para Yatırma Sebebi')
Player.Functions.RemoveMoney('cash', amount, 'Para Çekme Sebebi')
```

### Öğelerle Çalışma
```lua
local item = Player.Functions.GetItemByName('bank_card')
local info = item.info -- Özel veriler içerir
```

### NUI İletişimi
```lua
-- İstemciye gönder
TriggerClientEvent('ak_bankcard:client:Event', src, data)

-- İstemciden HTML'ye
SendNUIMessage({type = 'openPin', pin = pinCode})

-- HTML'den istemciye geri arama
$.post('https://' + GetParentResourceName() + '/callbackName', JSON.stringify(data), function(data) {})
```

## Test Kontrol Listesi

- [ ] Script hatasız başlıyor
- [ ] Oyuncular spawn'da banka kartı alıyor
- [ ] ATM modelleriyle etkileşim kurabilir
- [ ] PIN giriş ekranı görünüyor
- [ ] Doğru PIN banka menüsünü açıyor
- [ ] Yanlış PIN hata gösteriyor
- [ ] Para yatırma/çekme çalışıyor
- [ ] Bakiye doğru şekilde güncelleniyor
- [ ] İşlemler geri alınabilir
- [ ] Para çoğaltma imkansız
- [ ] UI düzgün kapanıyor
- [ ] Kapanışta animasyon temizleniyor

## Performans Optimizasyonu

- NUI ileti sıklığını en aza indirin
- Hızlı etkileşimler için zalımlı kullanın
- Veritabanı sorgularını optimize edin
- Olay dinleyicilerini temizleyin
- Üretimde hata ayıklama günlüğünü kaldırın

---

**Unutmayın**: Canlı sunucuya dağıtmadan önce her zaman iyice test edin!
