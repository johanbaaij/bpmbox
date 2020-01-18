<template>
  <v-container fluid>
    <v-row>
      <v-col
        ><p>{{ $t("Home.instructions") }}</p></v-col
      >
    </v-row>
    <v-row class="fill-height">
      <v-col>
        <search-discogs />
      </v-col>
    </v-row>
  </v-container>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import MetaInfo from "vue-meta";
import SearchDiscogs from "@/components/SearchDiscogs.vue";

@Component({
  name: "home",
  metaInfo(): MetaInfo {
    return {
      title: this.$i18n.t("Home.title") as string
    };
  },
  components: {
    SearchDiscogs
  }
})
export default class Home extends Vue {}
</script>

<style lang="sass"></style>
