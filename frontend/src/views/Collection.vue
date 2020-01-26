<template>
  <v-container fluid>
    <v-row>
      <v-col>
        <v-tabs>
          <v-tab to="tracks">Tracks</v-tab>
        </v-tabs>
      </v-col>
    </v-row>
    <router-view />
  </v-container>
</template>

<script lang="ts">
import { Component, Vue, Prop } from "vue-property-decorator";
import MetaInfo from "vue-meta";

@Component({
  name: "collection",
  metaInfo(): MetaInfo {
    return {
      title: this.$i18n.t("Collection.title") as string
    };
  }
})
export default class Collection extends Vue {
  @Prop() readonly username!: string;
  $cable: any;

  mounted() {
    this.$cable.subscribe({
      channel: "CollectionsChannel",
      username: this.username
    });
  }
}
</script>

<style lang="sass"></style>
