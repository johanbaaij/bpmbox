<template>
  <v-container fluid>
    <v-row justify="center">
      <v-col cols="auto">
        <h1 class="text-center">
          {{ $t("app.title") }}
        </h1>
        <h2 class="text-center">
          {{ $t("app.subtitle") }}
        </h2>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col md="6" lg="4" sm="8">
        <find-collection-widget />
      </v-col>
    </v-row>
  </v-container>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import MetaInfo from "vue-meta";
import FindCollectionWidget from "@/components/FindCollectionWidget.vue";

@Component({
  name: "home",
  metaInfo(): MetaInfo {
    return {
      title: this.$i18n.t("Home.title") as string
    };
  },
  components: {
    FindCollectionWidget
  },
  beforeMount() {
    if (this.$store.state.user.username !== null) {
      this.$router.replace({ name: "tracks" });
    }
  }
})
export default class Home extends Vue {}
</script>

<style lang="sass"></style>
