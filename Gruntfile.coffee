module.exports = ->
  # Load task configurations.
  @loadTasks "build/tasks"

  # COMMON
  @registerTask "html",  ["copy"]
  @registerTask "css",   ["compass"]
  @registerTask "js",    ["coffeelint", "browserify"]
  @registerTask "dev",   ["development", "connect", "watch"]
  @registerTask "build", ["copy", "css", "js"]

  # ENVIRONMENTS
  @registerTask "development",   ["build"]
  @registerTask "preproduction", ["copy", "css", "cssmin", "js"]
  @registerTask "production",    ["copy", "css", "cssmin", "js"]

  # DEFAULT
  @registerTask "default", ["development"]
  @registerTask "heroku", ["production"]
