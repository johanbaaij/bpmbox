import store from "@/store";

export default {
  connected(data: any) {},
  rejected() {},
  received(url: string) {
    const data = { _jv: { type: "release" } };
    store.dispatch("jv/get", [data, { url }]);
  },
  disconnected() {}
};
