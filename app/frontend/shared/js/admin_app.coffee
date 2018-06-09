import Utils from './core/utils'
import Settings from './core/settings'
import Vent from './core/vent'
import Dispatcher from './core/dispatcher'
import Render from './core/render'
import Vue from './core/vue'

import Notifications from './widgets/notifications'
import Drawer from './widgets/drawer'
import Crud from './widgets/crud'
import Checkbox from './widgets/checkbox'
import Dropdown from './widgets/dropdown'
import Datepicker from './widgets/datepicker'
import Multiselect from './widgets/multiselect'
import Richtext from './widgets/richtext'
import Navigation from './widgets/navigation'
import ImagePreloader from './widgets/image_preloader'

import Comments from './vue/comments'
import CategoryFilter from './vue/category_filter'
import NavigationButtons from './vue/navigation_buttons'
import Sidenav from './vue/sidenav'
import Newsletter from './vue/newsletter'
import Video from './vue/video'
import Cover from './vue/cover'

# Core Components
dispatcher = new Dispatcher
render = new Render
vue = new Vue
settings = new Settings
utils =  new Utils


# Regular Widgets
notifications = new Notifications
drawer = new Drawer
crud = new Crud
checkbox = new Checkbox
dropdown = new Dropdown
datepicker = new Datepicker
multiselect = new Multiselect
richtext = new Richtext
navigation = new Navigation
image_preloader = new ImagePreloader

# Vue Addons
comments = new Comments
category_filter = new CategoryFilter
navigation_buttons = new NavigationButtons
sidenav = new Sidenav
newsletter = new Newsletter
video = new Video
cover = new Cover

class App

  initialize: ->
    @setup()

  reload: ->
    @teardown()
    @setup()

  setup: ->
    dispatcher.setup()
    vue.setup()

    notifications.setup()
    checkbox.setup()
    dropdown.setup()
    datepicker.setup()
    multiselect.setup()
    richtext.setup()
    image_preloader.setup()
    navigation.setup()

  teardown: ->
    dispatcher.teardown()

    notifications.teardown()
    checkbox.teardown()
    dropdown.teardown()
    datepicker.teardown()
    multiselect.teardown()
    richtext.teardown()
    image_preloader.teardown()
    navigation.teardown()

    utils.log 'status', 'teardown() complete'

export { App as default}
