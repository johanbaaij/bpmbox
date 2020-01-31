<template>
  <v-skeleton-loader
    :loading="initialLoading"
    transition="fade-transition"
    type="table"
  >
    <v-data-table
      fixed-header
      dense
      :loading="receiving || apiLoading"
      :items="tracks"
      :headers="headers"
      :options.sync="options"
      :server-items-length="serverItemsLength"
      :items-per-page="30"
      :footer-props="{
        disableItemsPerPage: true,
        itemsPerPageOptions: [30]
      }"
    >
      <template v-slot:top>
        <track-filter />
      </template>
      <template v-slot:item.release_title="{ item }">
        {{ item.release.title }}
      </template>
      <template v-slot:item.release_artist="{ item }">
        {{ item.release.artist }}
      </template>
    </v-data-table>
  </v-skeleton-loader>
</template>

<script lang="ts">
import { mapState } from "vuex";
import { Component, Vue, Prop, Watch } from "vue-property-decorator";
import MetaInfo from "vue-meta";
import TrackFilter from "@/components/TrackFilter.vue";
import i18n from "@/plugins/i18n";

@Component({
  name: "collection-tracks",
  metaInfo(): MetaInfo {
    return {
      title: this.$i18n.t("Collection.title") as string
    };
  },
  computed: {
    ...mapState(["receiving"]),
    ...mapState("tracks", ["serverItemsLength", "apiLoading"])
  },
  components: {
    TrackFilter
  }
})
export default class CollectionTracks extends Vue {
  @Prop() readonly username!: string;
  initialLoading = true;
  receiving!: boolean;

  get options() {
    return this.$store.state.tracks.options;
  }

  set options(value) {
    this.$store.dispatch("tracks/options", value);
  }

  get tracks() {
    return Object.values(
      this.$store.getters["jv/get"]({ _jv: { type: "track" } })
    );
  }

  headers = [
    {
      text: i18n.t("track.position"),
      value: "position",
      sortable: false
    },
    {
      text: i18n.t("track.release_artist"),
      value: "release_artist",
      sortable: true
    },
    {
      text: i18n.t("track.release_title"),
      value: "release_title",
      sortable: true
    },
    {
      text: i18n.t("track.artist"),
      value: "artist",
      sortable: false
    },
    {
      text: i18n.t("track.title"),
      value: "title",
      sortable: true
    },
    {
      text: i18n.t("track.bpm"),
      value: "bpm",
      sortable: true
    },
    {
      text: i18n.t("track.key"),
      value: "key",
      sortable: true
    }
  ];

  async mounted() {
    await this.$store.dispatch("tracks/apiData");
    this.initialLoading = false;
  }
}
</script>

<style lang="sass"></style>
