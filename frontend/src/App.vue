<template>
  <v-app v-if="$auth.ready()">
    <the-app-bar />
    <v-content>
      <Notifications />
      <router-view />
      <v-snackbar
        v-model="state.snackWithButtons"
        :timeout="state.timeout"
        bottom
      >
        {{ state.snackWithBtnText }}
        <v-spacer />
        <v-btn flat @click.native="refreshApp">
          {{ state.snackBtnText }}
        </v-btn>
        <v-btn icon @click="state.snackWithButtons = false">
          <v-icon>close</v-icon>
        </v-btn>
      </v-snackbar>
    </v-content>
  </v-app>
</template>

<script lang="ts">
import MetaInfo from "vue-meta";
import { createComponent, reactive } from "@vue/composition-api";
import CollectionsChannel from "@/channels/CollectionsChannel";
import Notifications from "@/components/Notifications.vue";
import TheAppBar from "@/components/TheAppBar.vue";
import i18n from "@/plugins/i18n";
import store from "@/store";
import useServiceWorkerRefresh from "@/composables/useServiceWorkerRefresh";

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

    const { state, refreshApp, showRefreshUI } = useServiceWorkerRefresh();

    return {
      state,
      refreshApp,
      showRefreshUI
    };
  }
});

export default App;
</script>
