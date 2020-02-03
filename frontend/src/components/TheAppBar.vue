<template>
  <v-app-bar color="secondary lighten-3" app elevation="0">
    <v-toolbar-title class="mr-2">
      <v-btn icon color="primary" :to="homeRoute">
        <v-icon color="primary">mdi-metronome</v-icon>
      </v-btn>
    </v-toolbar-title>

    <v-chip close @click:close="clearUsername" v-if="username">
      {{ username }}
    </v-chip>
    <v-spacer />
    <v-toolbar-items class="ml-2">
      <v-btn v-if="!$auth.check()" to="login" text>{{
        $t("AppBar.login")
      }}</v-btn>
      <v-btn v-if="$auth.check()" @click="$auth.logout()" text>{{
        $t("AppBar.logout")
      }}</v-btn>
    </v-toolbar-items>
  </v-app-bar>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";

@Component({
  name: "app-bar"
})
export default class AppBar extends Vue {
  get homeRoute() {
    if (this.$auth.check())
      return {
        name: "dashboard"
      };
    return {
      name: "home"
    };
  }

  get username() {
    return this.$store.state.user.username;
  }

  clearUsername() {
    this.$store.dispatch("user/username", null);
    this.$router.replace({ name: "home" });
  }
}
</script>
