window.views ||= {}
window.views.BaseView = class BaseView
  constructor: (router) ->
    @router = router

  toggle: ->
    for section in @tag "section"
      section.style.display = 'none'
    @id(@_id).style.display = 'block' if @_id

  id: (id) ->
    document.getElementById(id)

  tag: (tag) ->
    document.getElementsByTagName(tag)

  klass: (klass) ->
    document.getElementsByClassName(klass)

  hide: (id) ->
    @id(id).style.display = 'none'

  show: (id) ->
    @id(id).style.display = 'block'
