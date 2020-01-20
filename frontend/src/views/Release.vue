<template>
  <v-container fluid>
    <v-row>
      <v-col>
        <v-card v-if="loaded">
          <v-card-title>
            <h1 class="ma-0">{{ release.artist }} - {{ release.title }}</h1>
          </v-card-title>
          <v-card-text>
            <v-data-table :headers="headers" :items="tracks"> </v-data-table>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script lang="ts">
import { Component, Vue, Prop } from "vue-property-decorator";
import { ValidationProvider, ValidationObserver } from "vee-validate";
import { mapGetters } from "vuex";

interface Track {
  position: string;
  bpm: number;
  title: string;
  duration: number;
}

@Component({
  name: "release",
  computed: {
    ...mapGetters({
      get: "jv/get"
    })
  }
})
export default class Release extends Vue {
  @Prop(String) discogsId!: string;
  get: any;
  loaded = false;
  headers = [
    {
      text: "Position",
      value: "position"
    },
    {
      text: "Artist",
      value: "artist"
    },
    {
      text: "Title",
      value: "title"
    },
    {
      text: "Duration",
      value: "duration"
    },
    {
      text: "BPM",
      value: "bpm"
    }
  ];

  mounted() {
    this.$store
      .dispatch("jv/get", `release/${this.discogsId}?include=tracks`)
      .then(response => {
        this.loaded = true;
      });
  }

  get release() {
    return this.get(`release/${this.discogsId}`);
  }

  get tracks() {
    return Object.values(this.release.tracks).map((track: any) => ({
      position: track.position,
      title: track.title,
      bpm: track.bpm,
      duration: track.duration,
      id: track._jv.id
    }));
  }
}
</script>
