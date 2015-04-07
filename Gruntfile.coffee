module.exports = ->
  # Load task configurations.
  @loadTasks "build/tasks"

  # COMMON
  @registerTask "html",    ["merge-json", "copy:html"]
  @registerTask "css",     ["compass"]
  @registerTask "js",      ["copy:components", "coffeelint", "browserify"]
  @registerTask "compile", ["uglify:dist"]

  @registerTask "build-dev", ["html", "css", "js"]
  @registerTask "build",     ["html", "css", "cssmin", "js", "compile"]

  # ENVIRONMENTS
  @registerTask "development",   ["build-dev"]
  @registerTask "preproduction", ["build"]
  @registerTask "production",    ["build"]

  # DEFAULT
  @registerTask "default",  ["development"]
  @registerTask "dev",      ["development", "run", "watch"]
  @registerTask "mobile",   ["env:mobile", "development"]
  @registerTask "heroku",   ["production"]
