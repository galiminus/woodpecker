#= require views/base

window.views.Layout = class LayoutView extends window.views.BaseView
  constructor: (router) ->
    super router
    @_total = 0
    @_query = @id "nav-query"
    @_query.value = ''
    @_query.parentNode.parentNode.onsubmit = (event) =>
      value = @_query.value
      if value == ''
        document.location.pathname = "/"
      else
        @_query.value = ''
        @router.route "/#{value}"
        history.pushState null, value, "/#{value}"
      event.preventDefault()

    if @id("overlay")
      @id("overlay").onclick = (event) ->
        if event.which == 1
          window.history.back();
          event.preventDefault()

  empty: ->

  total: (total, query) =>
    if total == undefined
        return @_total
    else
        @_total = total
        @router.link_to @id("total"), "/#{query}", "#{total} image#{if total > 1 then 's' else ''}"

  loading: =>
    @id("total").innerHTML = "loading"

  overlay: (bool) =>
    if bool
      @show("overlay")
      @tag("body")[0].style.overflow = 'hidden'
      setTimeout => @_query.focus()
    else
      @hide("overlay")
      @tag("body")[0].style.overflow = 'auto'

  query: (value) =>
    if (value == undefined)
      return @_query.value
    else if (value == false)
      @_query.parentNode.style.display = 'none'
    else
      @_query.parentNode.style.display = 'block'
      @_query.value = value
