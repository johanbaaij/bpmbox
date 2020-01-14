<template>
  <v-container fluid>
    <v-row>
      <v-col>
        <ValidationObserver v-slot="{ handleSubmit }">
          <v-form v-on:submit.prevent="handleSubmit(register)">
            <v-alert outlined color="error" v-if="errorMessage !== null">
              {{ errorMessage }}
            </v-alert>
            <ValidationProvider rules="required|email" v-slot="{ errors }">
              <v-text-field
                v-model="formData.body.email"
                :label="$t('user.email')"
                :error-messages="errors"
                required
              ></v-text-field>
            </ValidationProvider>
            <ValidationProvider
              rules="required|confirmed:confirmation"
              v-slot="{ errors }"
            >
              <v-text-field
                v-model="formData.body.password"
                :label="$t('user.password')"
                type="password"
                :error-messages="errors"
                required
              ></v-text-field>
            </ValidationProvider>
            <ValidationProvider v-slot="{ errors }" vid="confirmation">
              <v-text-field
                v-model="formData.body.password_confirmation"
                :label="$t('user.password_confirmation')"
                type="password"
                :error-messages="errors"
                required
              ></v-text-field>
            </ValidationProvider>
            <v-btn @click="handleSubmit(register)">{{
              $t("Register.register_button")
            }}</v-btn>
          </v-form>
        </ValidationObserver>
      </v-col>
    </v-row>
  </v-container>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import { AxiosResponse, AxiosError } from "axios";
import { ValidationProvider, ValidationObserver } from "vee-validate";
import { getErrorMessage } from "@/utils/errors";
import EventBus from "@/utils/event-bus";
import MetaInfo from "vue-meta";

const defaultFormValues = {
  body: {
    email: "",
    password: "",
    password_confirmation: ""
  }
};

@Component({
  name: "register",
  components: {
    ValidationProvider,
    ValidationObserver
  },
  metaInfo(): MetaInfo {
    return {
      title: this.$i18n.t("Register.title") as string
    };
  }
})
export default class Register extends Vue {
  errorMessage: string | null = null;
  formData = JSON.parse(JSON.stringify(defaultFormValues));

  register() {
    const vm = this;
    this.$auth.register({
      data: this.formData.body,
      success: function(res: AxiosResponse) {
        vm.resetForm();
        EventBus.$emit(
          "ADD_NOTIFICATION",
          this.$i18n.t("notifications.registrationComplete")
        );
      },
      error: function(error: AxiosError): void {
        vm.errorMessage = getErrorMessage(error);
      }
    });
  }

  resetForm() {
    this.errorMessage = null;
    this.formData = JSON.parse(JSON.stringify(defaultFormValues));
  }
}
</script>
