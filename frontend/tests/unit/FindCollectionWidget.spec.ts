import "./setup";

// Dependencies
import Vuetify from "vuetify";
import i18n from "@/plugins/i18n";
import router from "@/router";
import store from "@/store";

// Components
import FindCollectionWidget from "../../src/components/FindCollectionWidget.vue";

// Utilities
import { mount, createLocalVue } from "@vue/test-utils";

const localVue = createLocalVue();

describe("FindCollectionWidget.vue", () => {
  let vuetify: any;

  beforeEach(() => {
    vuetify = new Vuetify();
  });

  it("should match snapshot", () => {
    const wrapper = mount(FindCollectionWidget, {
      localVue,
      router,
      vuetify,
      i18n,
      store
    });
    expect(wrapper.html()).toMatchSnapshot();
  });
});
