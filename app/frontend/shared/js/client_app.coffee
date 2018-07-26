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
import Multiselect from './widgets/multiselect'
import Navigation from './widgets/navigation'
import ImagePreloader from './widgets/image_preloader'
import ConversionTracker from './widgets/conversion_tracker'

import Comments from './vue/comments'
import CategoryFilter from './vue/category_filter'
import NavigationButtons from './vue/navigation_buttons'
import Sidenav from './vue/sidenav'
import Newsletter from './vue/newsletter'
import Video from './vue/video'
import Audio from './vue/audio'
import Cover from './vue/cover'
import Feed from './vue/feed'
import SocialSharing from './vue/social_sharing'


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
multiselect = new Multiselect
navigation = new Navigation
image_preloader = new ImagePreloader
conversion_tracker = new ConversionTracker

# Vue Addons
comments = new Comments
category_filter = new CategoryFilter
navigation_buttons = new NavigationButtons
sidenav = new Sidenav
newsletter = new Newsletter
video = new Video
audio = new Audio
cover = new Cover
feed = new Feed
social_sharing = new SocialSharing

class Client_app

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
    multiselect.setup()
    image_preloader.setup()
    conversion_tracker.setup()
    navigation.setup()

  teardown: ->
    dispatcher.teardown()

    notifications.teardown()
    checkbox.teardown()
    dropdown.teardown()
    multiselect.teardown()
    image_preloader.teardown()
    conversion_tracker.teardown()
    navigation.teardown()

    utils.log 'status', 'teardown() complete'

export { Client_app as default}
