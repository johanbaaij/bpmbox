import { reactive } from "@vue/composition-api";

interface refreshAppSnackbar {
  registration: null | any;
  refreshing: boolean;
  snackBtnText: string;
  snackWithBtnText: string;
  snackWithButtons: boolean;
  timeout: number;
}

export default function useServiceWorkerRefresh() {
  const state = reactive<refreshAppSnackbar>({
    refreshing: false,
    registration: null,
    snackBtnText: "",
    snackWithBtnText: "",
    snackWithButtons: false,
    timeout: 0
  });

  function showRefreshUI(e: any) {
    state.registration = e.detail;
    state.snackBtnText = "Refresh";
    state.snackWithBtnText = "New version available!";
    state.snackWithButtons = true;
  }

  function refreshApp() {
    state.snackWithButtons = false;
    // Protect against missing registration.waiting.
    if (!state.registration || !state.registration.waiting) {
      return;
    }
    state.registration.waiting.postMessage("skipWaiting");
  }

  // Listen for swUpdated event and display refresh snackbar as required.
  document.addEventListener("swUpdated", showRefreshUI, { once: true });
  // Refresh all open app tabs when a new service worker is installed.
  navigator.serviceWorker.addEventListener("controllerchange", () => {
    if (state.refreshing) return;
    state.refreshing = true;
    window.location.reload();
  });

  return {
    state,
    showRefreshUI,
    refreshApp
  };
}
