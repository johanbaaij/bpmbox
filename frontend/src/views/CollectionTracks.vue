<template>
  <v-skeleton-loader
    :loading="initialLoading"
    transition="fade-transition"
    type="table"
  >
    <v-data-table
      fixed-header
      :loading="receiving || apiLoading"
      :items="tracks"
      :headers="headers"
      :options.sync="options"
      :server-items-length="totalTracks"
      :items-per-page="30"
      dense
      :footer-props="{
        disableItemsPerPage: true,
        itemsPerPageOptions: [30]
      }"
    >
      <template v-slot:item.release="{ item }">
        {{ item.release.title }}
      </template>
    </v-data-table>
  </v-skeleton-loader>
</template>

<script lang="ts">
import { mapState } from "vuex";
import { Component, Vue, Prop, Watch } from "vue-property-decorator";
import MetaInfo from "vue-meta";
import TrackQueryParams from "@/TrackQueryParams";

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

  initialLoading = true;
  apiLoading = false;
  receiving!: boolean;
  totalTracks = 0;
  tracks = [];

  options = {
    page: 1,
    itemsPerPage: 30,
    sortBy: ["release"],
    sortDesc: [false],
    groupBy: [],
    groupDesc: [],
    mustSort: true,
    multiSort: false
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

  @Watch("options", { deep: true })
  optionsChanged(newOptions: any, oldOptions: any) {
    this.getApiData(newOptions);
  }

  async getApiData(options: any) {
    this.apiLoading = true;
    const urlParams = new TrackQueryParams(options).urlParams();
    const jsonapiData = { _jv: { type: "track" } };

    const response = await this.$store.dispatch("jv/get", [
      jsonapiData,
      {
        url: `/collections/${this.username}/tracks`,
        params: { include: "release", ...urlParams }
      }
    ]);

    const { _jv, ...data } = response;

    this.tracks = Object.values(data);

    this.totalTracks = response._jv.json.meta.total;
    // const data = response;
    // this.trracks = data.map(a => data[a.id]);

    this.apiLoading = false;
    this.initialLoading = false;
  }

  async mounted() {
    this.getApiData(this.options);
  }

  // get tracks() {
  //   return Object.values(
  //     this.$store.getters["jv/get"](
  //       "track",
  //       `$[?(@.collection=="${this.username}")]`
  //     )
  //   );
  // }
}
</script>

<style lang="sass"></style>
