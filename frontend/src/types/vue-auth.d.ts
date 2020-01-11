import { Vue } from "vue/types/vue";
import { AxiosError, AxiosResponse } from "axios";
interface AuthOptions {
  data?: {};
  success?: (res: AxiosResponse) => void;
  error?: (res: AxiosError) => void;
}

type Redirect = { path: string } | string;

interface LoginOptions extends AuthOptions {
  rememberMe?: boolean;
  redirect?: Redirect;
  fetchUser?: boolean;
}

interface FetchOptions extends AuthOptions {}

interface LogoutOptions extends AuthOptions {
  makeRequest?: boolean;
  redirect?: Redirect;
}

interface Oauth2Options extends AuthOptions {
  code?: boolean;
  provider: string;
  redirect?: Redirect;
  rememberMe?: boolean;
}

interface RefreshOptions extends AuthOptions {}

interface RegisterOptions extends AuthOptions {
  autoLogin?: true;
  rememberMe?: boolean;
  redirect?: Redirect;
}

interface ImpersonateOptions extends AuthOptions {
  redirect?: Redirect;
}

interface UnimpersonateOptions extends AuthOptions {
  redirect?: Redirect;
  makeRequest?: boolean;
}

interface UserInterface {
  [key: string]: any;
  email?: string;
  name?: string;
  roles?: string[];
}

interface VueAuth {
  /**
   * Get binded ready property to know when user is fully loaded and checked.
   * Can also set a single callback which will fire once (on refresh or entry)
   *
   * @param {() => void} callBack
   * @returns {boolean}
   */
  ready(callBack?: () => void): boolean;

  /**
   * Data object is passed directly to http method.
   *
   * @param {LoginOptions} options
   */
  login(options: LoginOptions): void;

  /**
   * Fetch the user (again) allowing the users data to be reset (from the api).
   * Data object is passed directly to http method
   *
   * @param {FetchOptions} options
   */
  fetch(options: FetchOptions): void;

  logout(options?: LogoutOptions): void;

  oauth2(options: Oauth2Options): void;

  refresh(options: RefreshOptions): void;

  register(options: RegisterOptions): void;

  impersonate(options: ImpersonateOptions): void;

  unimpersonate(options: UnimpersonateOptions): void;

  disableImpersonate(): void;

  enableImpersonate(): void;

  token(tokenName?: string, token?: string): string;

  redirect(): void;

  check(role?: string, key?: string): boolean;

  user(data?: any): UserInterface;
}

declare module "vue/types/vue" {
  interface Vue {
    $auth: VueAuth;
  }
}
