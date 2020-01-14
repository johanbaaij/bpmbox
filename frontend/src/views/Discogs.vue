<template>
  <v-container class="fill-height" fluid>
    <v-row>
      <v-col>
        <h1>{{ $t("Discogs.title") }}</h1>
      </v-col>
    </v-row>
  </v-container>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import MetaInfo from "vue-meta";

@Component({
  name: "discogs",
  metaInfo(): MetaInfo {
    return {
      title: this.$i18n.t("Discogs.title") as string
    };
  }
})
export default class Discogs extends Vue {
  created() {
    this.discogsWhoami();
  }

  async discogsWhoami() {
    const whoami = await this.axios.get("http://localhost:3000/discogs/whoami");
    console.log(whoami);
  }
}
</script>
