import { required, email, max, confirmed } from "vee-validate/dist/rules";
import { extend } from "vee-validate";
import { setInteractionMode } from "vee-validate";
import i18n from "@/i18n";

setInteractionMode("lazy");

extend("required", {
  ...required,
  message: i18n.t("errors.required") as string
});

extend("email", {
  ...email,
  message: i18n.t("errors.email") as string
});

extend("confirmed", {
  ...confirmed,
  message: i18n.t("errors.confirmed", { target: `{target}` }) as string
});
