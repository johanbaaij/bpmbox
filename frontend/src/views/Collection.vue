<template>
  <v-container fluid>
    <router-view />
  </v-container>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import MetaInfo from "vue-meta";

@Component({
  name: "collection",
  metaInfo(): MetaInfo {
    return {
      title: this.$i18n.t("Collection.title") as string
    };
  }
})
export default class Collection extends Vue {}
</script>

<style lang="sass"></style>
