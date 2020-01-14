<template>
  <v-container fluid>
    <v-row>
      <v-col>
        <ValidationObserver v-slot="{ handleSubmit }">
          <v-form v-on:submit.prevent="handleSubmit(login)">
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
            <ValidationProvider rules="required" v-slot="{ errors }">
              <v-text-field
                v-model="formData.body.password"
                :label="$t('user.password')"
                :error-messages="errors"
                type="password"
                required
              ></v-text-field>
            </ValidationProvider>
            <v-checkbox
              v-model="formData.rememberMe"
              :label="$t('user.rememberMe')"
            ></v-checkbox>
            <v-btn @click="handleSubmit(login)">{{
              $t("Login.login_button")
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
    password: ""
  },
  rememberMe: false
};

@Component({
  name: "login",
  components: {
    ValidationProvider,
    ValidationObserver
  },
  metaInfo(): MetaInfo {
    return {
      title: this.$i18n.t("Login.title") as string
    };
  }
})
export default class Login extends Vue {
  errorMessage: string | null = null;
  formData = JSON.parse(JSON.stringify(defaultFormValues));

  login() {
    const vm = this;
    this.$auth.login({
      data: this.formData.body,
      rememberMe: this.formData.rememberMe,
      success: function(res: AxiosResponse) {
        vm.resetForm();
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
