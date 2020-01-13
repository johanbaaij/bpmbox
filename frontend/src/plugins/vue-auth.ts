import Vue from "vue";
import axios from "axios";
import VueAxios from "vue-axios";
import VueAuth from "@websanova/vue-auth";
import router from "@/router";

Vue.router = router;
Vue.use(VueAxios, axios);
Vue.axios.defaults.baseURL = process.env["VUE_APP_API_URL"];
Vue.axios.defaults.headers.common["Content-Type"] = "application/json";
Vue.use(VueAuth, {
  auth: require("@websanova/vue-auth/drivers/auth/devise.js"),
  http: require("@websanova/vue-auth/drivers/http/axios.1.x.js"),
  router: require("@websanova/vue-auth/drivers/router/vue-router.2.x.js"),
  registerData: { url: "auth" },
  loginData: { url: "auth/sign_in", redirect: "/dashboard" }
});
