<template>
  <ValidationObserver ref="form" v-slot="{ invalid }">
    <v-card>
      <v-card-text class="pb-0">
        <p>{{ $t("FindCollectionWidget.instructions") }}</p>
        <ValidationProvider
          vid="username"
          :debounce="500"
          rules="required|hasPublicCollection"
          v-slot="{ errors }"
        >
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
        </ValidationProvider>
      </v-card-text>
      <v-card-text class="py-0" v-if="numCollection > 0">
        <v-row>
          <v-col>
            <h2>
              <a :href="collection.discogs_user.uri" target="_blank">
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
          <v-col cols="auto">
            <v-img :src="collection.discogs_user.avatar_url" width="92"></v-img>
          </v-col>
        </v-row>
      </v-card-text>
      <v-card-actions>
        <v-spacer />
        <v-btn :disabled="invalid" @click="importCollection" color="primary">{{
          $t("FindCollectionWidget.card.button")
        }}</v-btn>
      </v-card-actions>
    </v-card>
  </ValidationObserver>
</template>

<script lang="ts">
import { mapGetters } from "vuex";
import { Component, Vue, Watch } from "vue-property-decorator";
import { ValidationProvider, ValidationObserver } from "vee-validate";
import { AxiosResponse } from "axios";
import { extend } from "vee-validate";
import i18n from "@/plugins/i18n";

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
  validating = false;
  username: string | null = null;
  search: string | null = null;
  response: AxiosResponse | null = null;

  created() {
    const hasPublicCollection = async () => {
      await this.fetchCollection();
      return this.numCollection > 0;
    };

    extend("hasPublicCollection", {
      validate: hasPublicCollection,
      message: i18n.t("FindCollectionWidget.noPublicCollection") as string
    });
  }

  async importCollection() {
    await this.axios.post(`collections/${this.username}/import`);
    this.commitUsernameAndNavigateToCollection();
  }

  async fetchCollection() {
    this.loading = true;
    const data = { _jv: { type: "collection" } };
    await this.$store.dispatch("jv/get", [
      data,
      { url: `/collections/${this.username}` }
    ]);
    this.searched = true;
    this.loading = false;
  }

  commitUsernameAndNavigateToCollection() {
    this.$store.commit("user/username", this.username);
    this.$router.push(`collection/tracks`);
  }

  get collection() {
    return this.get(`collection/${this.username}`);
  }

  get numCollection() {
    return this.collection.discogs_user?.num_collection || 0;
  }
}
</script>
