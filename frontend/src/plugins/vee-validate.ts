import { required, email, confirmed } from "vee-validate/dist/rules";
import isURL from "validator/lib/isURL";
import { extend } from "vee-validate";
import i18n from "@/plugins/i18n";

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

extend("url", {
  validate: url => isURL(url),
  message: i18n.t("errors.url") as string
});
