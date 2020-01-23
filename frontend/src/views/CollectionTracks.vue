<template>
  <v-col>
    <v-data-table />
  </v-col>
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
  mounted() {
    const data = { _jv: { type: "track" } };
    const username = this.$route.params.username;
    this.$store
      .dispatch("jv/get", [data, { url: `/collections/${username}/tracks` }])
      .then(data => {
        console.log(data);
      });
  }
}
</script>

<style lang="sass"></style>
