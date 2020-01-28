import store from "@/store";

export default {
  connected(data: any) {},
  rejected() {},
  async received(params: {
    username: string;
    release_id: string;
    jobs_left: number;
  }) {
    const { username, release_id, jobs_left } = params;
    store.dispatch("receiving", true);
    const data = { _jv: { type: "release" } };
    await store.dispatch("jv/get", [
      data,
      { url: `collections/${username}/releases/${release_id}?include=tracks` }
    ]);
    if (jobs_left === 0) {
      store.dispatch("receiving", false);
    }
  },
  disconnected() {}
};
