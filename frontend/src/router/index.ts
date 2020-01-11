import Vue from "vue";
import VueRouter from "vue-router";
import Home from "@/views/Home.vue";
import Register from "@/views/Register.vue";
import Login from "@/views/Login.vue";
import FourOhFour from "@/views/404.vue";
import Dashboard from "@/views/Dashboard.vue";
import EventBus from "@/utils/event-bus";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "home",
    component: Home
  },
  {
    path: "/404",
    name: "FourOhFour",
    component: FourOhFour
  },
  {
    path: "/register",
    name: "register",
    component: Register,
    meta: { auth: false }
  },
  {
    path: "/login",
    name: "login",
    component: Login,
    meta: { auth: false }
  },
  {
    path: "/dashboard",
    name: "dashboard",
    component: Dashboard,
    meta: { auth: true }
  }
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});

// add notification to "show on next page queue"
// before navigating, add notification to currently

router.beforeEach((_to, _from, next) => {
  next();
  EventBus.$emit("DISPLAY_NEXT_NOTIFICATION");
});

export default router;
