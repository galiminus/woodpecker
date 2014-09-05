#= require views/base

window.views.Search = class SearchView extends window.views.BaseView
  _id: "search"

  empty: ->
    @id("thumbnails").innerHTML = ''

  show: ->
    @id(@_id).style.display = 'block'

  add_images: (images) ->
    thumbnails = []
    errored = []
    counter = 0

    after_load = =>
      counter++
      if counter == images.length
        for thumbnail in thumbnails
          thumbnail.style.display = 'block'
        for thumbnail in errored
          thumbnail.parentNode.parentNode.style.display = 'none'

    for image in images
      thumbnail = @add_image(image)

      thumbnail.onload  = after_load
      thumbnail.onerror = (event) =>
        errored.push event.target
        after_load()
      thumbnails.push thumbnail

  add_image: (image) ->
    thumbnail = document.createElement 'li'
    @id("thumbnails").appendChild thumbnail

    thumbnail_link = document.createElement 'a'
    thumbnail_link.classList.add 'thumbnail'
    thumbnail.appendChild thumbnail_link
    @router.link_to thumbnail_link, "/images/#{image.id}"

    thumbnail_image = document.createElement 'img'
    thumbnail_image.style.display = 'none'
    if window.innerWidth > 800
      thumbnail_image.src = image.thumbnail
    else
      thumbnail_image.src = image.full

    thumbnail_link.appendChild thumbnail_image
    thumbnail_image
