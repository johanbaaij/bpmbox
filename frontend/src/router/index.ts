import Vue from "vue";
import VueRouter from "vue-router";
import Home from "@/views/Home.vue";
import DiscogsCallback from "@/views/DiscogsCallback.vue";
import Register from "@/views/Register.vue";
import Login from "@/views/Login.vue";
import FourOhFour from "@/views/404.vue";
import Collection from "@/views/Collection.vue";
import CollectionTracks from "@/views/CollectionTracks.vue";
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
    path: "/collections/:username",
    name: "collection",
    component: Collection,
    props: true,
    children: [
      {
        name: "tracks",
        props: true,
        path: "tracks",
        component: CollectionTracks
      }
    ]
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
  },
  {
    path: "/discogs/callback",
    name: "discogsCallback",
    component: DiscogsCallback,
    meta: { auth: true }
  },
  { path: "*", component: FourOhFour }
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});

router.beforeEach((to, from, next) => {
  next();
  displayNextNotification();
});

const displayNextNotification = function(): void {
  EventBus.$emit("DISPLAY_NEXT_NOTIFICATION");
};

export default router;
