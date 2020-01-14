<template>
  <v-container fluid>
    <v-row>
      <v-col>
        <p>404</p>
        <p>Time to go <router-link to="home">home</router-link>.</p>
      </v-col>
    </v-row>
  </v-container>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";

@Component({
  name: "FourOhFour"
})
export default class FourOhFour extends Vue {}
</script>
