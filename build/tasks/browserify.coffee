module.exports = ->
  @loadNpmTasks "grunt-browserify"

  @config "browserify",
    dev:
      files:
        "public/main.js": "app/app.coffee"
      options:
        browserifyOptions:
          extensions: [".coffee"]
          fullPaths: false
          debug: true
        transform: ["coffeeify", ["envify", { _: 'purge' }] ]
        exclude: ["jquery"]
