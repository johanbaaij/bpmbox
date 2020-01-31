import { Module } from "vuex";
import TrackQueryParams from "@/TrackQueryParams";

const tracksModule: Module<any, any> = {
  namespaced: true,
  state: {
    serverItemsLength: 0,
    apiLoading: false,
    options: {
      page: 1,
      itemsPerPage: 30,
      sortBy: ["release_title"],
      sortDesc: [false],
      groupBy: [],
      groupDesc: [],
      mustSort: true,
      multiSort: false
    }
  },
  actions: {
    options({ commit, dispatch }, payload) {
      commit("options", payload);
      dispatch("apiData");
    },
    async apiData({ state, dispatch, commit }) {
      commit("apiLoading", true);
      const urlParams = new TrackQueryParams(state.options).urlParams();
      const jsonapiData = {
        _jv: { type: "track" }
      };

      const response = await dispatch(
        "jv/get",
        [
          jsonapiData,
          {
            url: `/collections/johanbaaij/tracks`,
            params: {
              include: "release",
              ...urlParams
            }
          }
        ],
        { root: true }
      );
      const { _jv } = response;
      commit("serverItemsLength", _jv.json.meta.total);
      commit("apiLoading", false);
    }
  },
  mutations: {
    options(state, payload) {
      state.options = payload;
    },
    serverItemsLength(state, payload) {
      state.serverItemsLength = payload;
    },
    apiLoading(state, payload) {
      state.apiLoading = payload;
    }
  }
};

export default tracksModule;
