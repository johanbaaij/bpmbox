import Vue from "vue";
import Vuex from "vuex";
import axios from "axios";
import { jsonapiModule } from "jsonapi-vuex";
import tracksModule from "./tracks";
import userModule from "./user";

Vue.use(Vuex);

const api = axios.create({
  baseURL: process.env["VUE_APP_API_URL"],
  headers: {
    "Content-Type": "application/vnd.api+json"
  }
});

const store = new Vuex.Store({
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
    user: userModule,
    jv: jsonapiModule(api, {
      preserveJson: true,
      clearOnUpdate: true
    })
  }
});

store.subscribe((_mutation, state: any) => {
  localStorage.setItem("userModule", JSON.stringify(state.user));
});

export default store;
