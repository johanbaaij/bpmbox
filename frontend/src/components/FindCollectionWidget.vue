<template>
  <div>
    <v-card>
      <v-card-title>
        BPMs for a collection
      </v-card-title>
      <v-card-text class="pb-0">
        <p>{{ $t("FindCollectionWidget.instructions") }}</p>
        <v-text-field
          prepend-inner-icon="mdi-account"
          :error-messages="errors"
          :loading="loading"
          single-line
          v-model="username"
          placeholder="johanbaaij"
          solo
        >
        </v-text-field>
      </v-card-text>
      <v-card-text class="py-0" v-if="numCollection > 0">
        <v-row>
          <v-col>
            <v-img :src="collection.discogs_user.avatar_url" width="92"></v-img>
          </v-col>
          <v-col>
            <h2>
              <a :href="collection.uri" target="_blank">
                {{ username }}
              </a>
            </h2>
            <p>
              {{
                $t("FindCollectionWidget.card.text", {
                  num_collection: numCollection
                })
              }}
            </p>
          </v-col>
        </v-row>
      </v-card-text>
      <v-card-actions>
        <v-spacer />
        <v-btn
          :disabled="numCollection === 0"
          @click="importCollection"
          color="primary"
          >{{ $t("FindCollectionWidget.card.button") }}</v-btn
        >
      </v-card-actions>
    </v-card>
  </div>
</template>

<script lang="ts">
import { mapGetters } from "vuex";
import { Component, Vue, Watch } from "vue-property-decorator";
import { ValidationProvider, ValidationObserver } from "vee-validate";
import { debounce } from "lodash";
import { AxiosResponse } from "axios";

@Component({
  name: "search-discogs-username",
  components: {
    ValidationProvider,
    ValidationObserver
  },
  computed: {
    ...mapGetters({
      get: "jv/get"
    })
  }
})
export default class FindCollectionWidget extends Vue {
  get: any;
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
    const data = { _jv: { type: "collection" } };
    await this.$store.dispatch("jv/get", [
      data,
      { url: `/collections/${this.username}` }
    ]);
    this.searched = true;
    this.loading = false;
  }

  async importCollection() {
    await this.axios.post(`collections/${this.username}/import`);
    this.$router.push(`collections/${this.username}/tracks`);
  }

  get collection() {
    return this.get(`collection/${this.username}`);
  }

  get numCollection() {
    return this.collection.discogs_user?.num_collection || 0;
  }

  get errors() {
    if (this.numCollection === 0 && this.searched) {
      return ["no collection"];
    }
    return [];
  }
}
</script>
