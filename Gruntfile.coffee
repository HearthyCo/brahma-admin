module.exports = ->
  # Load task configurations.
  @loadTasks "build/tasks"

  # COMMON
  @registerTask "html",    ["merge-json", "copy:html"]
  @registerTask "css",     ["compass"]
  @registerTask "js",      ["copy:components", "coffeelint", "browserify"]
  @registerTask "compile", ["uglify:dist", "copy:jsdist", "clean:jsdist"]

  @registerTask "build-dev", ["clean:public", "html", "css", "js"]
  @registerTask "build",     ["clean:public", "html", "css", "cssmin", "js", "compile"]

  # ENVIRONMENTS
  @registerTask "development",   ["env:development", "build-dev"]
  @registerTask "preproduction", ["env:preproduction", "build"]
  @registerTask "production",    ["env:production", "build"]

  # DEFAULT
  @registerTask "default",  ["development"]
  @registerTask "dev",      ["development", "run", "watch"]
  @registerTask "mobile",   ["env:mobile", "development"]
  @registerTask "heroku",   ["production"]
