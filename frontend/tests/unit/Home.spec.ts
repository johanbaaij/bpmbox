import "./setup";

// Dependencies
import Vuetify from "vuetify";
import i18n from "@/plugins/i18n";

// Components
import Home from "../../src/views/Home.vue";

// Utilities
import { mount, createLocalVue } from "@vue/test-utils";

const localVue = createLocalVue();

describe("Home.vue", () => {
  let vuetify: any;

  beforeEach(() => {
    vuetify = new Vuetify();
  });

  it("should match snapshot", () => {
    const wrapper = mount(Home, {
      localVue,
      vuetify,
      i18n
    });
    expect(wrapper.html()).toMatchSnapshot();
  });
});
