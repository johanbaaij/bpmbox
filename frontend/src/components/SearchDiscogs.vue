<template>
  <ValidationObserver
    name="model"
    v-slot="{ handleSubmit, invalid }"
    mode="aggressive"
  >
    <ValidationProvider rules="required|url" v-slot="{ errors }">
      <v-text-field
        prepend-inner-icon="mdi-magnify"
        :placeholder="$t('SearchDiscogs.placeholder')"
        :error-messages="errors"
        single-line
        v-model="model"
        :loading="isLoading"
        cache-items
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
  isLoading = false;
  model = null;
  response = null;

  async submit() {
    this.isLoading = true;
    this.response = await this.axios.get("discogs/url/redirect", {
      params: {
        url: this.model
      }
    });
    this.isLoading = false;
  }
}
</script>
