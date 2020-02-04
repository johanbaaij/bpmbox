import { Module } from "vuex";

const userModule: Module<any, any> = {
  namespaced: true,
  state: {
    username: null
  },
  actions: {
    username({ commit }, payload) {
      commit("username", payload);
    }
  },
  mutations: {
    username(state, payload) {
      state.username = payload;
    },
    initialise(state) {
      if (localStorage.getItem("userModule")) {
        const userStorage = JSON.parse(
          localStorage.getItem("userModule") as string
        );
        state = Object.assign(state, userStorage);
      }
    }
  }
};

export default userModule;
