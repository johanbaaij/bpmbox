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
  name: "discogsCallback",
  metaInfo(): MetaInfo {
    return {
      title: this.$i18n.t("Discogs.title") as string
    };
  }
})
export default class DiscogsCallback extends Vue {
  created() {
    this.discogsCallback();
  }

  discogsCallback() {
    this.axios
      .get("http://localhost:3000/discogs/callback", {
        params: this.$route.query
      })
      .then(response => {
        this.$router.replace({ name: "discogs" });
      });
  }
}
</script>
