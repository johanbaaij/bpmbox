import Vue from "vue";
import VueMeta from "vue-meta";
import App from "@/App.vue";
import "@/registerServiceWorker";
import router from "@/router";
import store from "@/store";
import vuetify from "@/plugins/vuetify";
import i18n from "@/plugins/i18n";
import "@/plugins/vee-validate";
import "@/plugins/vue-auth";

Vue.use(VueMeta);

Vue.config.productionTip = false;

new Vue({
  router,
  store,
  vuetify,
  i18n,
  render: h => h(App)
}).$mount("#app");
