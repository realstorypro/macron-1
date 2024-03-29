import Utils from './core/utils'
import Settings from './core/settings'
import Vent from './core/vent'
import Dispatcher from './core/dispatcher'
import Token from './core/token'
import Render from './core/render'
import Vue from './core/vue'

import Notifications from './widgets/notifications'
import Drawer from './widgets/drawer'
import Crud from './widgets/crud'
import Checkbox from './widgets/checkbox'
import Dropdown from './widgets/dropdown'
import Tabs from './widgets/tabs'
import Datepicker from './widgets/datepicker'
import Timepicker from './widgets/timepicker'
import Daterange from './widgets/daterange'
import Clicker from './widgets/clicker'
import Sorter from './widgets/sorter'
import Multiselect from './widgets/multiselect'
import Previewer from './widgets/previewer'
import Focus from './widgets/focus'
import Richtext from './widgets/richtext'
import Navigation from './widgets/navigation'
import ImagePreloader from './widgets/image_preloader'

import CategoryFilter from './vue/category_filter'
import NavigationButtons from './vue/navigation_buttons'
import Sidenav from './vue/sidenav'
import Video from './vue/video'
import Cover from './vue/cover'

# Core Components
dispatcher = new Dispatcher
token = new Token
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
tabs = new Tabs
datepicker = new Datepicker
timepicker = new Timepicker
daterange = new Daterange
clicker = new Clicker
sorter = new Sorter
multiselect = new Multiselect
previewer = new Previewer
focus = new Focus
richtext = new Richtext
navigation = new Navigation
image_preloader = new ImagePreloader

# Vue Addons
category_filter = new CategoryFilter
navigation_buttons = new NavigationButtons
sidenav = new Sidenav
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
    token.setup()
    vue.setup()

    notifications.setup()
    checkbox.setup()
    dropdown.setup()
    tabs.setup()
    datepicker.setup()
    timepicker.setup()
    daterange.setup()
    clicker.setup()
    sorter.setup()
    multiselect.setup()
    previewer.setup()
    focus.setup()
    richtext.setup()
    image_preloader.setup()
    navigation.setup()

  teardown: ->
    dispatcher.teardown()

    notifications.teardown()
    checkbox.teardown()
    dropdown.teardown()
    tabs.teardown()
    datepicker.teardown()
    timepicker.teardown()
    daterange.teardown()
    clicker.teardown()
    sorter.teardown()
    multiselect.teardown()
    previewer.teardown()
    focus.teardown()
    richtext.teardown()
    image_preloader.teardown()
    navigation.teardown()

    utils.log 'status', 'teardown() complete'

export { App as default}
