# frozen_string_literal: true

Kaminari.configure do |config|
  config.default_per_page = 25
  # config.max_per_page = nil
  config.window = 1
  # config.outer_window = 0
  # config.left = 0
  # config.right = 0
  # config.page_method_name = :page
  # config.param_name = :page
  # config.params_on_first_page = false
end

# This seems to prevent Kaminari from wigging out ... not sure why
# module Kaminari
#   module Helpers
#     class Tag
#       def page_url_for(page)
#         (@options[:routes_proxy] || @template).url_for @params.merge(@param_name => (page <= 1 ? nil : page))
#       end
#     end
#   end
# end
