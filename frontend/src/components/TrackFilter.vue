<template>
  <v-form>
    <v-checkbox
      v-model="hideNullBpms"
      :label="$t('TrackFilter.hideNullBpms')"
    ></v-checkbox>
  </v-form>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";

@Component({
  name: "track-filter"
})
export default class TrackFilter extends Vue {
  get hideNullBpms() {
    return this.$store.state.tracks.hideNullBpms;
  }

  set hideNullBpms(value) {
    this.$store.dispatch("tracks/hideNullBpms", value);
  }
}
</script>

<style scoped></style>
