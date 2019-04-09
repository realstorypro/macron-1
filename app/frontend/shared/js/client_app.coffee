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
import Sticky from './widgets/sticky'
import Navigation from './widgets/navigation'
import ImagePreloader from './widgets/image_preloader'
import LinkPreloader from './widgets/link_preloader'
import ConversionTracker from './widgets/conversion_tracker'
import ShopifyButton from './widgets/shopify_button'

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
import Liker from './vue/liker'


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
sticky = new Sticky
navigation = new Navigation
image_preloader = new ImagePreloader
link_preloader = new LinkPreloader
conversion_tracker = new ConversionTracker
shopify_button = new ShopifyButton

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
liker = new Liker

class Client_app

  initialize: ->
    @setup()
    @register_service_workers()

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
    sticky.setup()
    image_preloader.setup()
    link_preloader.setup()
    conversion_tracker.setup()
    shopify_button.setup()
    navigation.setup()

  register_service_workers: ->
    return unless 'serviceWorker' of navigator
    navigator.serviceWorker.register('/worker.js').then((reg) ->
        console.log 'Service Worker Registration Successful at:', reg.scope
      ).catch (error) ->
        console.log 'Registration failed with ' + error


  teardown: ->
    dispatcher.teardown()

    notifications.teardown()
    checkbox.teardown()
    dropdown.teardown()
    multiselect.teardown()
    sticky.teardown()
    image_preloader.teardown()
    link_preloader.teardown()
    conversion_tracker.teardown()
    shopify_button.teardown()
    navigation.teardown()

    utils.log 'status', 'teardown() complete'

export { Client_app as default}
