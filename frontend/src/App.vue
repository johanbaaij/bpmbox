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

interface refreshAppSnackbar {
  registration: null | any;
  refreshing: boolean;
  snackBtnText: string;
  snackWithBtnText: string;
  snackWithButtons: boolean;
  timeout: number;
}

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
    const state = reactive<refreshAppSnackbar>({
      refreshing: false,
      registration: null,
      snackBtnText: "",
      snackWithBtnText: "",
      snackWithButtons: false,
      timeout: 0
    });

    store.commit("user/initialise");

    function showRefreshUI(e: any) {
      state.registration = e.detail;
      state.snackBtnText = "Refresh";
      state.snackWithBtnText = "New version available!";
      state.snackWithButtons = true;
    }

    function refreshApp() {
      state.snackWithButtons = false;
      // Protect against missing registration.waiting.
      if (!state.registration || !state.registration.waiting) {
        return;
      }
      state.registration.waiting.postMessage("skipWaiting");
    }

    // Listen for swUpdated event and display refresh snackbar as required.
    document.addEventListener("swUpdated", showRefreshUI, { once: true });
    // Refresh all open app tabs when a new service worker is installed.
    navigator.serviceWorker.addEventListener("controllerchange", () => {
      if (state.refreshing) return;
      state.refreshing = true;
      window.location.reload();
    });

    return {
      state,
      refreshApp,
      showRefreshUI
    };
  }
});

export default App;
</script>
