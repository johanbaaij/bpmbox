<template>
  <ValidationObserver
    name="model"
    v-slot="{ handleSubmit, invalid }"
    mode="aggressive"
  >
    <ValidationProvider rules="required" v-slot="{ errors }">
      <v-text-field
        prepend-inner-icon="mdi-magnify"
        :placeholder="$t('SearchDiscogs.placeholder')"
        :error-messages="errors"
        single-line
        v-model="discogsId"
        solo
      >
        <template v-slot:append>
          <v-btn :disabled="invalid" @click="handleSubmit(submit)">Go</v-btn>
        </template>
      </v-text-field>
    </ValidationProvider>
    <p>
      {{ response }}
    </p>
  </ValidationObserver>
</template>

<script lang="ts">
import { Component, Vue, Watch } from "vue-property-decorator";
import { ValidationProvider, ValidationObserver } from "vee-validate";

@Component({
  name: "search-discogs",
  components: {
    ValidationProvider,
    ValidationObserver
  }
})
export default class SearchDiscogs extends Vue {
  discogsId!: string | null;
  response = null;

  async submit() {
    if (this.discogsId === null) return;
    this.$router.push({
      name: "release",
      params: { discogsId: this.discogsId }
    });
  }
}
</script>
