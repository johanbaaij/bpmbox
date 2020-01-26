import Vue from "vue";
import Vuetify from "vuetify";
import ActionCableVue from "actioncable-vue";
Vue.use(Vuetify);
Vue.use(ActionCableVue, {
  debug: true,
  debugLevel: "error",
  connectionUrl: "ws://testing:5000/api/cable",
  connectImmediately: true
});
