<template>
  <v-data-table
    fixed-header
    disable-pagination
    :items="tracks"
    :headers="headers"
  />
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import MetaInfo from "vue-meta";

@Component({
  name: "collection-tracks",
  metaInfo(): MetaInfo {
    return {
      title: this.$i18n.t("Collection.title") as string
    };
  }
})
export default class CollectionTracks extends Vue {
  loaded = false;
  headers = [
    {
      text: "Position",
      value: "position",
      sortable: false
    },
    {
      text: "Release",
      value: "release",
      sortable: true
    },
    {
      text: "Artist",
      value: "artist",
      sortable: true
    },
    {
      text: "Title",
      value: "title",
      sortable: true
    },
    {
      text: "BPM",
      value: "bpm",
      sortable: true
    },
    {
      text: "Key",
      value: "key",
      sortable: true
    }
  ];

  async mounted() {
    const data = { _jv: { type: "track" } };
    const username = this.$route.params.username;
    await this.$store.dispatch("jv/get", [
      data,
      { url: `/collections/${username}/tracks` }
    ]);
    this.loaded = true;
  }

  get tracks() {
    return Object.values(
      this.$store.getters["jv/get"]({ _jv: { type: "track" } })
    );
  }
}
</script>

<style lang="sass"></style>
