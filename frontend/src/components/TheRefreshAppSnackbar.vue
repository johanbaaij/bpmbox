<template>
  <v-snackbar v-model="state.snackWithButtons" :timeout="state.timeout" bottom>
    {{ state.snackWithBtnText }}
    <v-spacer />
    <v-btn text @click.native="refreshApp">
      {{ state.snackBtnText }}
    </v-btn>
    <v-btn text @click="state.snackWithButtons = false">
      <v-icon>mdi-close</v-icon>
    </v-btn>
  </v-snackbar>
</template>

<script lang="ts">
import useServiceWorkerRefresh from "@/composables/useServiceWorkerRefresh";
import { createComponent } from "@vue/composition-api";

const TheRefreshAppSnackbar = createComponent({
  setup() {
    const { state, refreshApp, showRefreshUI } = useServiceWorkerRefresh();

    return {
      state,
      refreshApp,
      showRefreshUI
    };
  }
});
</script>
