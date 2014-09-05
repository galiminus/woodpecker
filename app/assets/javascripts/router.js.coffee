window.Router = class Router
  constructor: ->
    @routes = []
    @current_path = null
    window.addEventListener 'popstate', (event) =>
      unless @current_path == document.location.pathname
        this.route document.location.pathname

  register: (path, method) =>
    @routes.push(path: path, method: method)

  route: (path) =>
    path ||= document.location.pathname
    for route in @routes
      if (match = route.path.exec(path))
        route.method(this, unescape(match[1]))
        @current_path = path
        break

  link_to: (link, path, innerHTML) =>
    link.href = path
    link.innerHTML = innerHTML if innerHTML
    link.onclick = (event) =>
      if event.which == 1
        history.pushState(null, "Woodpecker", path);
        @route path
        event.preventDefault()
