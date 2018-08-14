import Utils from '../core/utils'
import Vent from '../core/vent'
import Shopify from '@shopify/buy-button-js'

utils = new Utils
vent = new Vent

client = Shopify.buildClient({
  domain: window.shopify_domain,
  storefrontAccessToken: window.shopify_buy_token
})

window.ui = Shopify.UI.init(client)


class ShopifyButton
  instance = null

  constructor: ->
    if !instance
      instance = this

    else
      instance

  setup: () ->
    utils.log 'setup', 'setup()', 'shopify'

    shopify_button = document.getElementById('shopify_button')

    if shopify_button
      ui.createComponent 'product',
        id: shopify_button.dataset.product
        node: shopify_button
        moneyFormat: '%24%7B%7Bamount%7D%7D'
        options:
          product:
            width: '100%'
            contents:
              img: false
              description: false
              price: false
              title: false
            text:
              button: 'Add to Cart'
            styles:
              button:
                width: '100%'
                "margin-top": "0",
                "padding-left": "px",
                "padding-right": "px",
                "border-radius": "0px",
                "background-color": "#FF8243",
                color: "white",
                "font-family": "Roboto, sans-serif",
                "font-weight": "bold"
            googleFonts: [ "Roboto" ]

          toggle:
            styles:
              toggle:
                "font-family": "Roboto, sans-serif",
                "background-color": "#FF8243",
                "border-radius": 0
                color: "white",

  teardown: () ->
    utils.log 'teardown', 'teardown()', 'shopify'

    shopify_button = document.getElementById('shopify_button')

    if shopify_button
      ui.destroyComponent 'cart'
      ui.destroyComponent 'product'


export { ShopifyButton as default }

