import Vue from "vue";
import VueI18n, { LocaleMessages } from "vue-i18n";
import localesEn from "@/locales/en.json";

Vue.use(VueI18n);

const en: LocaleMessages = { en: localesEn };

export default new VueI18n({
  locale: process.env.VUE_APP_I18N_LOCALE || "en",
  fallbackLocale: process.env.VUE_APP_I18N_FALLBACK_LOCALE || "en",
  messages: en
});
