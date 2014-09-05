#= require infinite-scroll
#= require views/layout
#= require views/search
#= require views/show
#= require image
#= require cache

window.Controller = class Controller
  constructor: (router) ->
    @layout_view = new window.views.Layout router
    @search_view = new window.views.Search router
    @show_view   = new window.views.Show   router

    @per_page = 60

  search: (router, query) =>
    load = (done) =>
      return done() unless @infinite_scroll
      
      display_results = (results) =>
        @total ||= results.total
        @layout_view.total @total, @layout_view.query()
        if window.innerWidth > 800
          step = 10
        else
          step = 1
        for index in [0...results.images.length] by step
          @search_view.add_images results.images[index..(index + step - 1)]
        for image in results.images
          window.cache.setItem image.id, image
        @infinite_scroll = false if (results.images.length < @per_page)

      @layout_view.loading()
      window.Image.search @layout_view.query(), @page, @per_page, (results) =>
        display_results results
        @page += 1
        done()

    if @layout_view.query() != query || query == ""
      @layout_view.query query
      @search_view.empty()
      @page = 1
      @total = 0
      @infinite_scroll = true
      load ->
        infiniteScroll
          distance: 300
          callback: load

    @search_view.toggle()
    @layout_view.overlay(false)

  show: (router, id) =>
    @show_view.empty()
    @show_view.toggle()

    if window.innerWidth > 800
      @layout_view.overlay(true)
      @search_view.show()

    @show_view.close_link(@layout_view.query(), @layout_view.total() > 0)

    query = @layout_view.query()
    window.Image.get id, (image) =>
      @show_view.display image
