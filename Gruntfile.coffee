module.exports = ->
  # Load task configurations.
  @loadTasks "build/tasks"

  # COMMON
  @registerTask "html",  ["merge-json", "copy:html"]
  @registerTask "css",   ["compass"]
  @registerTask "js",    ["copy:components", "coffeelint", "browserify"]
  @registerTask "dev",   ["development", "run", "watch"]
  @registerTask "build", ["html", "css", "js"]

  # ENVIRONMENTS
  @registerTask "development",   ["build"]
  @registerTask "preproduction", ["html", "css", "cssmin", "js"]
  @registerTask "production",    ["html", "css", "cssmin", "js"]

  # DEFAULT
  @registerTask "default", ["development"]
  @registerTask "heroku", ["production"]
