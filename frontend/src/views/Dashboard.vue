<template>
  <v-container fluid>
    <v-row>
      <v-col>
        <h1>{{ $t("Dashboard.title") }}</h1>
        <connect-to-discogs v-if="!connectedToDiscogs" />
      </v-col>
    </v-row>
  </v-container>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import MetaInfo from "vue-meta";
import ConnectToDiscogs from "@/components/ConnectToDiscogs.vue";

@Component({
  name: "dashboard",
  metaInfo(): MetaInfo {
    return {
      title: this.$i18n.t("Dashboard.title") as string
    };
  },
  components: {
    ConnectToDiscogs
  }
})
export default class Dashboard extends Vue {
  get connectedToDiscogs() {
    return this.$auth.user().connected_to_discogs;
  }
}
</script>
