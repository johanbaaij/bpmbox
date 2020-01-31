import Vue from "vue";
import Vuex from "vuex";
import axios from "axios";
import { jsonapiModule } from "jsonapi-vuex";
import tracksModule from "./tracks";

Vue.use(Vuex);

const api = axios.create({
  baseURL: process.env["VUE_APP_API_URL"],
  headers: {
    "Content-Type": "application/vnd.api+json"
  }
});

export default new Vuex.Store({
  state: {
    receiving: false
  },
  mutations: {
    receiving(state, payload) {
      state.receiving = payload;
    }
  },
  actions: {
    receiving({ commit }, value) {
      commit("receiving", value);
    }
  },
  modules: {
    tracks: tracksModule,
    jv: jsonapiModule(api, {
      preserveJson: true,
      clearOnUpdate: true
    })
  }
});
