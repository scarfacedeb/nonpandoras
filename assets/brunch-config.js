exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: 'js/app.js',
    },
    stylesheets: {
      joinTo: {
        'css/app.css': 'css/app.css',
        'css/fonts_en.css': 'css/fonts_en.css',
        'css/fonts_ru.css': 'css/fonts_ru.css',
      },
    },
    templates: {
      joinTo: 'js/app.js',
    },
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    assets: /^(static|html)/,
  },

  paths: {
    watched: ["static", "css", "js"],
    public: "../priv/static"
  },

  plugins: {
    autoReload: {
      enabled: {
        css: true,
        js: true,
        assets: true,
      },
    },
    babel: {
      ignore: [/vendor/],
    },
    postcss: {
      progeny: { prefix: '_' },
      processors: [
        require('postcss-easy-import')({ prefix: '_' }),
        require('postcss-nested')(),
        require('postcss-custom-properties')(),
        require('postcss-selector-matches')(),
        require('postcss-selector-not')(),
        require('autoprefixer')(),
        require('postcss-discard-empty')()
      ],

    },
  },

  modules: {
    autoRequire: {
      'js/app.js': ['js/app'],
    },
  },

  npm: {
    enabled: true,
  },
};
