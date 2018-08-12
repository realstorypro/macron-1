# frozen_string_literal: true

class Product < Entry
  include Autoloadable
  content_attr :product_code, :string

  validate :product_link_in_admin
  validate :product_link_numeric
  validates_presence_of :category

  before_save :extract_product_code
  #validates_presence_of :product_code


  paginates_per 5

  def product_link_in_admin
    matchers = %w[admin shopify]
    if matchers.all? {|matcher| product_link.include? matcher}
      return true
    end
    errors.add(:product_link, "Please post the product URL from the Shopify Admin")
  end

  def product_link_numeric
    return true if is_number?(product_link.split('/').last)
    errors.add(:product_link, "Product ID is missing from the URL")
  end

  def extract_product_code
    self.product_code = product_link.split('/').last
  end

  private

  def is_number? string
    true if Float(string) rescue false
  end


end
