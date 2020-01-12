<template>
  <v-container class="fill-height" fluid>
    <v-row>
      <v-col>
        <h1>Dashboard</h1>
      </v-col>
    </v-row>
  </v-container>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import MetaInfo from "vue-meta";

@Component({
  name: "dashboard",
  metaInfo(): MetaInfo {
    return {
      title: this.$i18n.t("Dashboard.title") as string
    };
  }
})
export default class Dashboard extends Vue {}
</script>
