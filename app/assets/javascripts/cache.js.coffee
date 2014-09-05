class Cache
  constructor: ->
    @_storage = {}
    if window.localStorage
      days = 7
      now = new Date().getTime()
      timeout = localStorage.getItem("timeout")
      if !timeout || parseInt(timeout) < now
        localStorage.clear()
        localStorage.setItem "timeout", (now + (days * 24 * 60 * 60 * 1000))

  setItem: (key, value) ->
    if window.localStorage
      try
        localStorage.setItem key, JSON.stringify(value)
      catch error
        localStorage.clear()
    else
      @_storage[key] = value

  getItem: (key) ->
    if window.localStorage
      JSON.parse(localStorage.getItem key)
    else
      @_storage[key]
  
window.cache = new Cache
  