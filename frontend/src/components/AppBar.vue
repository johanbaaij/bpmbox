<template>
  <v-app-bar app>
    <v-toolbar-title class="mr-2"
      ><router-link :to="homeRoute">{{
        $t("app.title")
      }}</router-link></v-toolbar-title
    >
    <v-toolbar-items class="ml-2" v-if="$auth.ready()">
      <v-btn v-if="!$auth.check()" to="register" text>{{
        $t("AppBar.register")
      }}</v-btn>
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
}
</script>
