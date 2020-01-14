<template>
  <v-container fluid>
    <v-row>
      <v-col>
        <h1>{{ $t("DiscogsCallback.title") }}</h1>
      </v-col>
    </v-row>
  </v-container>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import MetaInfo from "vue-meta";
import EventBus from "@/utils/event-bus";

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

  async discogsCallback() {
    await this.axios.get("/discogs/callback", {
      params: this.$route.query
    });
    await this.$auth.fetch({});
    EventBus.$emit(
      "ADD_NOTIFICATION",
      this.$i18n.t("notifications.discogsAuthenticationComplete")
    );
    this.$router.replace({ name: "dashboard" });
  }
}
</script>
