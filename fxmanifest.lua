---@diagnostic disable: undefined-global

fx_version 'cerulean'
game 'gta5'

description '[DESCRIPTION]'
author '[AUTHOR_NAME]'
version '[VERSION]'

-- UI Sayfası
ui_page 'html/ui.html'

-- Client (Oyuncu) tarafında çalışacak dosyalar
client_scripts {
    'client/main.lua'
}

-- Server (Sunucu) tarafında çalışacak dosyalar
server_scripts {
    'server/main.lua'
}

-- Sistemin kullanacağı tüm yan dosyalar
-- DUI ve NUI'nin sorunsuz yüklenmesi için buradaki liste eksiksiz olmalı
files {
    'html/ui.html',
    'html/style.css',
    'html/script.js',
    -- Eğer ikonları yerel bir klasörden çekersen buraya 'html/assets/*.png' gibi eklemelisin
}

-- Optimizasyon ve Uyumluluk Ayarları
lua54 'yes' -- Performans için Lua 5.4 kullanımı aktif
use_fxv2_oal 'yes' -- Yeni nesil ses ve script yükleme desteği

-- Meta Veriler
-- Sunucu listesinde veya script loglarında detaylı bilgi görünmesi için
repository '[REPO_URL]' -- Varsa repo adresin
category 'Development'
