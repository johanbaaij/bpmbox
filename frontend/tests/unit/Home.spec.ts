import { expect } from "chai";
import { shallowMount } from "@vue/test-utils";
import Home from "@/views/Home.vue";

describe("Home.vue", () => {
  it("renders", () => {
    const wrapper = shallowMount(Home);
    expect(wrapper.find(".home"));
  });
});
