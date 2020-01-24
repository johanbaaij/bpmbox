<template>
  <v-container fluid>
    <v-row>
      <v-col>
        <h1>{{ $t("app.title") }}</h1>
        <h2>{{ $t("app.subtitle") }}</h2>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <search-discogs-username />
      </v-col>
    </v-row>
  </v-container>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import MetaInfo from "vue-meta";
import SearchDiscogsUsername from "@/components/SearchDiscogsUsername.vue";

@Component({
  name: "home",
  metaInfo(): MetaInfo {
    return {
      title: this.$i18n.t("Home.title") as string
    };
  },
  components: {
    SearchDiscogsUsername
  }
})
export default class Home extends Vue {}
</script>

<style lang="sass"></style>
