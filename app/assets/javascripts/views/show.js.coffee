#= require views/base

window.views.Show = class ShowView extends window.views.BaseView
  _id: "show"

  empty: ->
    @id("full").src = ''
    @id("tags").innerHTML = ''
    @id(@_id).className =  ''

  close_link: (query, toggle) ->
    @id("close").style.display = 'none';
    if query
      @router.link_to @id("close"), "/#{query}"
    if toggle
      @id("close").style.display = 'block';

  display: (image, callback) ->
    @id("full").src = image.full
    @id("toolbar").style.display = 'none'
    @id("full").onload = =>
      @id("toolbar").style.display = 'block'
      callback(true) if callback

    if window.innerWidth > 800
      top = document.documentElement.scrollHeight - document.documentElement.clientHeight
      height = document.documentElement.clientHeight - 100
      @id("full").style.maxHeight = "#{height}px"
      @id("tags").style.maxHeight = "#{parseInt(height / 29) * 29}px"

    for tag_text in image.tags
      tag = document.createElement "li"
      @id("tags").appendChild(tag)

      tag_link = document.createElement "a"
      tag_link.innerHTML = tag_text
      tag.appendChild(tag_link)
      @router.link_to tag_link, "/#{tag_text}"
