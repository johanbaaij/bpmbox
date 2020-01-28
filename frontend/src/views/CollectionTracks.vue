<template>
  <v-skeleton-loader
    :loading="loading"
    transition="fade-transition"
    type="table"
  >
    <v-data-table
      fixed-header
      :loading="receiving"
      :items="tracks"
      :headers="headers"
      :options.sync="options"
    >
      <template v-slot:item.release="{ item }">
        {{ item.release.title }}
      </template>
    </v-data-table>
  </v-skeleton-loader>
</template>

<script lang="ts">
import { mapState } from "vuex";
import { Component, Vue, Prop } from "vue-property-decorator";
import MetaInfo from "vue-meta";

@Component({
  name: "collection-tracks",
  metaInfo(): MetaInfo {
    return {
      title: this.$i18n.t("Collection.title") as string
    };
  },
  computed: {
    ...mapState(["receiving"])
  }
})
export default class CollectionTracks extends Vue {
  @Prop() readonly username!: string;
  loading = true;
  receiving!: boolean;
  options = {
    sortBy: ["release"]
  };
  headers = [
    {
      text: "Position",
      value: "position",
      sortable: false
    },
    {
      text: "Release",
      value: "release",
      sortable: true,
      sort: (a: any, b: any) => {
        if (a.title == b.title) return 0;
        if (a.title > b.title) return 1;
        return -1;
      }
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
    await this.$store.dispatch("jv/get", [
      data,
      { url: `/collections/${this.username}/tracks?include=release` }
    ]);
    this.loading = false;
  }

  get tracks() {
    return Object.values(
      this.$store.getters["jv/get"](
        "track",
        `$[?(@.collection=="${this.username}")]`
      )
    );
  }
}
</script>

<style lang="sass"></style>
