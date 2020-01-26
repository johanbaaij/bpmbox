import "./setup";

// Dependencies
import Vuetify from "vuetify";
import i18n from "@/plugins/i18n";
import router from "@/router";
import store from "@/store";

// Components
import Collection from "../../src/views/Collection.vue";

// Utilities
import { mount, createLocalVue } from "@vue/test-utils";

const localVue = createLocalVue();

describe("Collection.vue", () => {
  let vuetify: any;

  beforeEach(() => {
    vuetify = new Vuetify();
  });

  it("should match snapshot", () => {
    const wrapper = mount(Collection, {
      localVue,
      router,
      vuetify,
      i18n,
      store
    });
    expect(wrapper.html()).toMatchSnapshot();
  });
});
