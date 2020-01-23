<template>
  <div>
    <p>{{ $t("SearchDiscogsUsername.instructions") }}</p>

    <v-text-field
      prepend-inner-icon="mdi-account"
      :error-messages="errors"
      :loading="loading"
      single-line
      v-model="username"
      prefix="https://www.discogs.com/user/"
      solo
    >
    </v-text-field>

    <v-card v-if="numCollection > 0">
      <v-card-title>
        {{ response.data.username }}
      </v-card-title>
      <v-card-text>
        <v-img :src="response.data.avatar_url" width="92"></v-img>
        <p>
          {{
            $t("SearchDiscogsUsername.card.text", {
              num_collection: response.data.num_collection
            })
          }}
        </p>
      </v-card-text>
      <v-card-actions>
        <v-btn @click="importCollection" text>{{
          $t("SearchDiscogsUsername.card.button")
        }}</v-btn>
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
  loading = false;
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
    this.loading = true;
    this.response = await this.axios.get(
      `collections/${this.username}/discogs_lookup`
    );
    this.searched = true;
    this.loading = false;
  }

  importCollection() {
    this.axios.post(`collections/${this.username}/import`);
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
