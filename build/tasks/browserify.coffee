module.exports = ->
  @loadNpmTasks "grunt-browserify"
  @loadNpmTasks "grunt-coffeeify"

  @config "browserify",
    dev:
      files:
        "public/main.js": "app/app.coffee"
      options:
        browserifyOptions:
          extensions: [".coffee"]
          fullPath: false
        transform: ["coffeeify", "reactify", ["envify", { _: 'purge' }] ]
        exclude: ["jquery"]
