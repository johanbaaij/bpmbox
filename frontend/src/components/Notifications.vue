<template>
  <v-alert dismissible v-model="alertActive">{{ message }}</v-alert>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import EventBus from "@/utils/event-bus";

@Component({
  name: "notifications"
})
export default class Notifications extends Vue {
  messageQueue: Array<string> = [];
  message: string | null = null;
  alertActive: boolean = false;

  created() {
    EventBus.$on("ADD_NOTIFICATION", (message: string) => {
      this.addNotificationToQueue(message);
    });

    EventBus.$on("DISPLAY_NEXT_NOTIFICATION", (message: string) => {
      this.showNotificationFirstInQueue();
    });
  }

  addNotificationToQueue(message: string) {
    this.messageQueue.push(message);
  }

  showNotificationFirstInQueue() {
    this.message = this.messageQueue.pop() || null;
    this.alertActive = this.message !== null;
  }
}
</script>

<style scoped></style>
