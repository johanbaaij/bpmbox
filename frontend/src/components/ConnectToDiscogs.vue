<template>
  <v-card>
    <v-card-title class="headline">
      {{ $t("ConnectToDiscogs.title") }}
    </v-card-title>
    <v-card-subtitle>
      {{ $t("ConnectToDiscogs.subtitle") }}
    </v-card-subtitle>
    <v-card-actions>
      <v-btn @click="connectToDiscogs" text>{{
        $t("ConnectToDiscogs.authorize")
      }}</v-btn>
    </v-card-actions>
  </v-card>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";

@Component({
  name: "connectToDiscogs"
})
export default class ConnectToDiscogs extends Vue {
  async connectToDiscogs() {
    const response = await this.axios.get("discogs/authenticate");
    window.location = response.data.url;
  }
}
</script>
