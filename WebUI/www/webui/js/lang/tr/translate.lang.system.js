jQuery.extend(true,langJSON, {
  "tr" : {
    "dummy" : "",
    "dialogSettingsGeneralSettingsTitle" : "Hafiza ayarlari",
    "btnSysConfGeneralSettings" : "Hafiza ayarlari",
    "dialogSettingsSDCardSettings" : "microSD karti",
    "dialogSettingsSDCardStatus" : "Durum",
    "dialogSettingsStorageSettingsBtnInitaliseSDCard" : "Calistirma",
    "dialogSettingsStorageSettingsBtnBackup" : "Verileri koruma",
    "dialogSettingsStorageHintSDCardP1" : "MicroSD karti calistirma. Dikkat! Calistirma sirasinda microSD karti formatlanir.",
    "dialogSettingsStorageHintSDCardP2" : "Verileri koruma isleminde sadece beraberinde g%F6nderilen sistem bilesenleri, %F6rn. diyagramlar tarafindan kullanilan listeler korunur.",
    "dialogSettingsStorageStateInitialised" : "microSD karti calistirildi.",
    "dialogSettingsStorageStateNotInitialised" : "microSD karti var ancak hen%FCz calistirilmadi.",
    "dialogSettingsStorageStateNotPresent" : "microSD karti yok veya algilanmadi.",
    "dialogSettingsInitialisingMessageTitle" : "microSD karti suanda calistiriliyor",
    "lblSysConfStorage" : "Genel ayarlar",

    "dialogSettingsExternalStorageStateInitialised" : "external USB memory available.",
    "dialogSettingsExternalStorageStateNotPresent" : "No external USB memory found."
  }
});

window.setTimeout(function() {
  if (getProduct() >= 3) {
    langJSON.tr.dialogSettingsStorageStateInitialised = langJSON.tr.dialogSettingsExternalStorageStateInitialised;
    langJSON.tr.dialogSettingsStorageStateNotPresent = langJSON.tr.dialogSettingsExternalStorageStateNotPresent;
  }
},750);

