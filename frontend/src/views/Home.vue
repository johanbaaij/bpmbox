<template>
  <v-container class="fill-height" fluid>
    <v-row>
      <v-col><h1>Home</h1></v-col>
    </v-row>
  </v-container>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import MetaInfo from "vue-meta";

@Component({
  name: "home",
  metaInfo(): MetaInfo {
    return {
      title: this.$i18n.t("Home.title") as string
    };
  }
})
export default class Home extends Vue {}
</script>

<style lang="sass"></style>
