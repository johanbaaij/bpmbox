import Vue from "vue";
import axios from "axios";
import VueAxios from "vue-axios";
import VueAuth from "@websanova/vue-auth";
import VueMeta from "vue-meta";
import App from "@/App.vue";
import "@/registerServiceWorker";
import router from "@/router";
import store from "@/store";
import vuetify from "@/plugins/vuetify";
import "@/plugins/vee-validate";
import i18n from "@/i18n";

Vue.router = router;
Vue.use(VueAxios, axios);
Vue.use(VueMeta);
Vue.axios.defaults.baseURL = "http://localhost:3000";
Vue.axios.defaults.headers.common["Content-Type"] = "application/json";
Vue.use(VueAuth, {
  auth: require("@websanova/vue-auth/drivers/auth/devise.js"),
  http: require("@websanova/vue-auth/drivers/http/axios.1.x.js"),
  router: require("@websanova/vue-auth/drivers/router/vue-router.2.x.js"),
  registerData: { url: "auth" },
  loginData: { url: "auth/sign_in", redirect: "/dashboard" }
});

Vue.config.productionTip = false;

new Vue({
  router,
  store,
  vuetify,
  i18n,
  render: h => h(App)
}).$mount("#app");
