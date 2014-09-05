window.Image = class Image
  @get: (id, callback) ->
    if (image = window.cache.getItem(id))
      callback image
    else
      @http_get "/api/0.9/images/#{id}.json", (image) ->
        window.cache.setItem id, image
        callback image

  @search: (query, page, per_page, callback) ->
    if (results = window.cache.getItem([query, page, per_page]))
      callback results
    else
      @http_get "/api/0.9/images.json?page=#{page}&q=#{query}&per_page=#{per_page}", (results) ->
        window.cache.setItem [query, page, per_page], results
        callback results

  @http_get: (url, callback) ->
    xhr = (new XMLHttpRequest)
    xhr.open "GET", url, true
    xhr.onreadystatechange = ->
      if xhr.readyState == 4 && xhr.status == 200
        callback JSON.parse(xhr.responseText)
    xhr.send()
