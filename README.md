# [SCRIPT_NAME] v[VERSION]

Last Updated: [CURRENT_DATE]

## English

### Description
[SCRIPT_NAME] is a basic banking script for FiveM servers using QB-Core framework. It allows players to use bank cards at ATMs for secure transactions including deposits and withdrawals.

### Features
- Bank card item integration
- ATM interaction with target system
- PIN verification system
- Deposit and withdrawal operations
- Basic UI interface
- Automatic bank card assignment to new players

### Requirements
- FiveM server
- QB-Core framework
- qb-target

### Installation
1. Download the script files
2. Place the `[SCRIPT_NAME]` folder in your server's resources directory
3. Add `ensure [SCRIPT_NAME]` to your server.cfg
4. Restart your server

### Configuration
- Default PIN for new cards: [DEFAULT_PIN]
- Configurable ATM models in client/main.lua
- UI can be customized in html/ folder

### Usage
1. Players receive a bank card automatically upon joining
2. Approach an ATM and use the target option to insert card
3. Enter PIN (default: [DEFAULT_PIN])
4. Access banking menu for transactions

### License
This script is for sale. Contact the author for licensing information.

---

## Türkçe

### Açıklama
[SCRIPT_NAME] v[VERSION], QB-Core framework kullanan FiveM sunucuları için temel bir bankacılık scriptidir. Oyuncuların ATM'lerde banka kartlarını kullanarak para yatırma ve çekme işlemlerini yapmalarını sağlar.

Bu, FiveM için AK Banka Kartı & ATM sisteminin şablon versiyonudur. Bu versiyon eksik olup uygulamayı gerektirir.

## Uygulanacak Özellikler

- [ ] ATM Hedef Sistemi Kurulumu (qb-target)
- [ ] Kart Okuma ve Doğrulama
- [ ] PIN Kod Sistemi
- [ ] NUI (Lua to JavaScript) İletişimi
- [ ] Banka Menüsü Arayüzü
- [ ] Para Yatırma ve Çekme Fonksiyonları
- [ ] Bakiye Güncelleme Sistemi

## Dosya Yapısı

```
client/main.lua      - İstemci tarafı mantığı (tamamlanması gerekir)
server/main.lua      - Sunucu tarafı mantığı (tamamlanması gerekir)
html/ui.html         - HTML UI Yapısı (tamamlanması gerekir)
html/style.css       - UI Stil Dosyası (tamamlanması gerekir)
html/script.js       - JavaScript Mantığı (tamamlanması gerekir)
```

## Bağımlılıklar

- QB-Core Framework
- qb-target
- qb-progressbar (opsiyonel)

## Kurulum

1. `ak_bankcard_template` klasörünü resources dizinine yerleştirin
2. server.cfg dosyanıza ekleyin:
   ```
   ensure ak_bankcard_template
   ```
3. Her dosyadaki rehberlere göre uygulamayı tamamlayın

## Uygulama Notları

Her dosya, uygulanması gereken şeyleri açıklayan detaylı yorumlar içerir. Yapıyı takip edin ve belirtilen yerlere özel mantığınızı ekleyin.

---

**Not**: Bu bir şablon versiyonudur. Tam, üretime hazır versiyon için geliştirici ile iletişime geçin.
