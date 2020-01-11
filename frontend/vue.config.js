module.exports = {
  transpileDependencies: ["vuetify"],

  configureWebpack: {
    devtool: "source-map"
  },

  pluginOptions: {
    i18n: {
      locale: "en",
      fallbackLocale: "en",
      localeDir: "locales",
      enableInSFC: false
    }
  }
};
