#= require router
#= require controller

router = new window.Router
controller = new window.Controller router
router.register /^\/images\/(.*)/,      controller.show
router.register /^\/(.*)/,              controller.search
router.register /^\//,                  controller.search
router.route document.location.pathname
