<template>
  <v-app v-if="$auth.ready()">
    <the-app-bar />
    <v-content>
      <Notifications />
      <router-view />
      <RefreshAppSnackbar />
      <v-snackbar
        v-model="state.snackWithButtons"
        :timeout="state.timeout"
        bottom
      >
        {{ state.snackWithBtnText }}
        <v-spacer />
        <v-btn text @click.native="refreshApp">
          {{ state.snackBtnText }}
        </v-btn>
        <v-btn text @click="state.snackWithButtons = false">
          <v-icon>mdi-close</v-icon>
        </v-btn>
      </v-snackbar>
    </v-content>
  </v-app>
</template>

<script lang="ts">
import MetaInfo from "vue-meta";
import { createComponent } from "@vue/composition-api";
import CollectionsChannel from "@/channels/CollectionsChannel";
import Notifications from "@/components/Notifications.vue";
import TheAppBar from "@/components/TheAppBar.vue";
import i18n from "@/plugins/i18n";
import store from "@/store";

const App = createComponent({
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
          ? `${titleChunk} - ${i18n.t("app.title")}`
          : i18n.t("app.title");
      }
    };
  },
  setup() {
    store.commit("user/initialise");
  }
});

export default App;
</script>
