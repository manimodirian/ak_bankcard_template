let currentPin = "";
let correctPin = "";

// Ses Efektleri
const clickSound = new Audio('https://www.soundjay.com/buttons/button-16.mp3');
const errorSound = new Audio('https://www.soundjay.com/buttons/button-10.mp3');
clickSound.volume = 0.2;

window.addEventListener('message', function(event) {
    // PIN Ekranını Aç
    if (event.data.type === "openPin") {
        correctPin = event.data.pin.toString();
        currentPin = "";
        $("#bank-wrapper").hide();
        $("#pin-wrapper").show().css("display", "flex");
        updateDots(); 
    }

    // Ana Banka Menüsünü Aç / Veri Güncelle
    if (event.data.type === "openBank") {
        $("#pin-wrapper").hide();
        $("#bank-wrapper").show().css("display", "flex");
        
        let safeBalance = Number(event.data.balance) || 0;
        
        // Verileri Doldur
        $("#playerName").text(event.data.name);
        $("#ibanText").text(event.data.iban);
        $("#balanceText").text("$" + safeBalance.toLocaleString());
        
        // Inputları temizle (İşlem sonrası kalmasın)
        $("#amount").val("");
    }

    // YENİ EKLENTİ: Sadece Bakiyeyi Güncelle (Arayüzü yenilemeden)
    if (event.data.type === "updateBalance") {
        let safeBalance = Number(event.data.balance) || 0;
        $("#balanceText").text("$" + safeBalance.toLocaleString());
        
        // İşlem sonrası inputları (yazı alanlarını) temizle
        $("#amount").val("");
    }
});

// --- SEKME YÖNETİMİ ---
function switchTab(tabName) {
    $(".tab-content").removeClass("active");
    $(".nav-btn").removeClass("active");
    
    $(`#tab-${tabName}`).addClass("active");
    $(`.nav-btn[onclick="switchTab('${tabName}')"]`).addClass("active");
}

// --- PIN İŞLEMLERİ ---
function addPin(num) {
    if (currentPin.length < 4) {
        currentPin += num;
        clickSound.play();
        updateDots();
        
        if (currentPin.length === 4) {
            setTimeout(() => { checkPin(); }, 150);
        }
    }
}

function updateDots() {
    for (let i = 1; i <= 4; i++) {
        const dot = $(`#dot-${i}`);
        dot.removeClass('active filled error-state');

        if (i <= currentPin.length) {
            dot.addClass('filled');
        } else if (i === currentPin.length + 1) {
            dot.addClass('active');
        }
    }
}

function checkPin() {
    if (currentPin === correctPin) {
        $(".dot").css("border-color", "#2ecc71").css("box-shadow", "0 0 20px #2ecc71");
        setTimeout(() => {
            $.post(`https://${GetParentResourceName()}/pinSuccess`, JSON.stringify({}));
            $(".dot").css("border-color", "").css("box-shadow", "");
        }, 300);
    } else {
        errorSound.play();
        $(".atm-container").addClass("shake-animation");
        $(".dot").addClass("error-state");
        
        setTimeout(() => {
            $(".atm-container").removeClass("shake-animation");
            $(".dot").removeClass("error-state");
            clearPin();
        }, 600);
        
        $.post(`https://${GetParentResourceName()}/pinError`, JSON.stringify({}));
    }
}

function clearPin() {
    currentPin = "";
    updateDots();
}

// --- BANKA AKSİYONLARI ---
function action(type) {
    let amount = $("#amount").val();
    if (amount && amount > 0) {
        $.post(`https://${GetParentResourceName()}/doAction`, JSON.stringify({
            action: type,
            amount: parseInt(amount)
        }));
    }
}

function closeUI() {
    $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
    $("#bank-wrapper").hide();
    $("#pin-wrapper").hide();
}

// Klavye Desteği
document.onkeyup = function (data) {
    if (data.which == 27) closeUI(); // ESC
    if (data.which >= 96 && data.which <= 105) addPin(data.which - 96); // Numpad
    if (data.which >= 48 && data.which <= 57) addPin(data.which - 48); // Sayılar
    if (data.which == 8) clearPin(); // Backspace
};