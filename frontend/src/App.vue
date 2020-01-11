<template>
  <v-app v-if="$auth.ready()">
    <v-app-bar app>
      <v-toolbar-title
        ><router-link :to="{ name: 'home' }">{{
          $t("app.title")
        }}</router-link></v-toolbar-title
      >
      <v-spacer></v-spacer>

      <v-toolbar-items v-if="$auth.ready()">
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
    <v-content>
      <Notifications />
      <router-view />
    </v-content>
  </v-app>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import Notifications from "@/components/Notifications.vue";
import EventBus from "@/utils/event-bus";
import MetaInfo from "vue-meta";

@Component({
  name: "app",
  components: {
    Notifications
  },
  metaInfo(): MetaInfo {
    return {
      titleTemplate: (titleChunk: string) => {
        return titleChunk
          ? `${titleChunk} - ${this.$i18n.t("app.title")}`
          : this.$i18n.t("app.title");
      }
    };
  }
})
export default class App extends Vue {}
</script>
