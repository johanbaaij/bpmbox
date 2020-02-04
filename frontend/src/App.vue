<template>
  <v-app v-if="$auth.ready()">
    <the-app-bar />
    <v-content>
      <Notifications />
      <router-view />
    </v-content>
  </v-app>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import MetaInfo from "vue-meta";
import CollectionsChannel from "@/channels/CollectionsChannel";
import Notifications from "@/components/Notifications.vue";
import TheAppBar from "@/components/TheAppBar.vue";

@Component({
  name: "app",
  components: {
    Notifications,
    TheAppBar
  },
  channels: {
    CollectionsChannel
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
export default class App extends Vue {
  beforeCreate() {
    this.$store.commit("user/initialise");
  }
}
</script>
