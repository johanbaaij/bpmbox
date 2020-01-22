<template>
  <div>
    <p>{{ $t("SearchDiscogsUsername.instructions") }}</p>

    <v-text-field
      prepend-inner-icon="mdi-account"
      :error-messages="errors"
      single-line
      v-model="username"
      prefix="https://www.discogs.com/user/"
      solo
    >
    </v-text-field>

    <v-card v-if="numCollection > 0">
      <v-card-title>Blab</v-card-title>
      <v-card-text>
        yada yada yada
      </v-card-text>
      <v-card-actions>
        <v-btn @click="importCollection" text>Button</v-btn>
      </v-card-actions>
    </v-card>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Watch } from "vue-property-decorator";
import { ValidationProvider, ValidationObserver } from "vee-validate";
import { debounce } from "lodash";
import { AxiosResponse } from "axios";

@Component({
  name: "search-discogs-username",
  components: {
    ValidationProvider,
    ValidationObserver
  }
})
export default class SearchDiscogsUsername extends Vue {
  searched = false;
  username: string | null = null;
  search: string | null = null;
  response: AxiosResponse | null = null;

  created() {
    this.onDebouncedUsername = debounce(this.onDebouncedUsername, 1000);
  }

  @Watch("username")
  onSearchChanged(input: string) {
    this.onDebouncedUsername();
  }

  async onDebouncedUsername() {
    this.response = await this.axios.get(`collections/new/${this.username}`);
    this.searched = true;
  }

  importCollection() {
    this.axios.get(`collections/import/${this.username}`);
  }

  get numCollection() {
    return this.response?.data?.num_collection || 0;
  }

  get errors() {
    if (this.numCollection === 0 && this.searched) {
      return ["no collection"];
    }
    return [];
  }
}
</script>
