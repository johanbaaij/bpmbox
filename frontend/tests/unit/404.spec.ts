import "./setup";

// Dependencies
import Vuetify from "vuetify";
import i18n from "@/plugins/i18n";
import router from "@/router";

// Components
import FourOhFour from "../../src/views/404.vue";

// Utilities
import { mount, createLocalVue } from "@vue/test-utils";

const localVue = createLocalVue();

describe("FourOhFour.vue", () => {
  let vuetify: any;

  beforeEach(() => {
    vuetify = new Vuetify();
  });

  it("should match snapshot", () => {
    const wrapper = mount(FourOhFour, {
      localVue,
      router,
      vuetify,
      i18n
    });
    expect(wrapper.html()).toMatchSnapshot();
  });
});
