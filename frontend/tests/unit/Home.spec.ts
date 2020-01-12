import { expect } from "chai";
import Vuetify from "vuetify";

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

  it("should render", () => {
    const wrapper = mount(Home, {
      localVue
    });
    expect(wrapper.find("h1").contains("Home"));
  });
});
