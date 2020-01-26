<template>
  <v-app v-if="$auth.ready()">
    <v-content>
      <v-container fluid>
        <v-row>
          <v-col>
            <h1>
              <router-link to="/">{{ $t("app.title") }}</router-link>
            </h1>
            <h2>{{ $t("app.subtitle") }}</h2>
          </v-col>
        </v-row>
        <Notifications />
        <router-view />
      </v-container>
    </v-content>
  </v-app>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import MetaInfo from "vue-meta";
import CollectionsChannel from "@/channels/CollectionsChannel";
import Notifications from "@/components/Notifications.vue";
import AppBar from "@/components/AppBar.vue";

@Component({
  name: "app",
  components: {
    Notifications,
    AppBar
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
export default class App extends Vue {}
</script>
