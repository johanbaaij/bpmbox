<template>
  <v-container class="fill-height" fluid>
    <v-row>
      <v-col>
        <h1>{{ $t("Dashboard.title") }}</h1>
        <p>
          <v-btn @click="connectToDiscogs">Connect to Discogs</v-btn>
        </p>
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
export default class Dashboard extends Vue {
  async connectToDiscogs() {
    const response = await this.axios.get(
      "http://localhost:3000/discogs/authenticate"
    );
    window.location = response.data.url;
  }
}
</script>
