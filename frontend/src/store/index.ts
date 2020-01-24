import Vue from "vue";
import Vuex from "vuex";
import axios from "axios";
import { jsonapiModule } from "jsonapi-vuex";

Vue.use(Vuex);

const api = axios.create({
  baseURL: process.env["VUE_APP_API_URL"],
  headers: {
    "Content-Type": "application/vnd.api+json"
  }
});

export default new Vuex.Store({
  modules: {
    jv: jsonapiModule(api)
  }
});
