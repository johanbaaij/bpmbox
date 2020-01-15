<template>
  <v-app v-if="$auth.ready()">
    <app-bar />
    <v-content>
      <Notifications />
      <router-view />
    </v-content>
  </v-app>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import Notifications from "@/components/Notifications.vue";
import AppBar from "@/components/AppBar.vue";
import MetaInfo from "vue-meta";

@Component({
  name: "app",
  components: {
    Notifications,
    AppBar
  },
  metaInfo(): MetaInfo {
    return {
      titleTemplate: (titleChunk: string) => {
        return titleChunk
          ? `${titleChunk} - ${this.$i18n.t("app.title")}`
          : this.$i18n.t("app.title");
      }
    };
  }
})
export default class App extends Vue {}
</script>
