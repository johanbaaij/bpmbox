<template>
  <v-row>
    <v-col md="6">
      <find-collection-widget />
    </v-col>
  </v-row>
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
  }
})
export default class Home extends Vue {}
</script>

<style lang="sass"></style>
