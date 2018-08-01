# frozen_string_literal: true

class DisplayDataType
  def initialize(options = {})
    defaults = {
      date_datatypes: %w(date datepicker),
      text_datatypes: %w(text rich),
      image_datatypes: %w(image),
      string_datatypes: %w(string fixed_dropdown),
      dropdown_datatypes: %w(dropdown),
      association_datatypes: %w(association),
      linked_list_datatypes: %w(linked_list),
      unlinked_list_datatypes: %w(unlinked_list),
      color_datatypes: %w(color),
      integer_datatypes: %w(integer)
    }
    options = defaults.merge(options)

    @date_datatypes = options[:date_datatypes]
    @text_datatypes = options[:text_datatypes]
    @image_datatypes = options[:image_datatypes]
    @string_datatypes = options[:string_datatypes]
    @dropdown_datatypes = options[:dropdown_datatypes]
    @association_datatypes = options[:association_datatypes]
    @linked_list_datatypes = options[:linked_list_datatypes]
    @unlinked_list_datatypes = options[:unlinked_list_datatypes]
    @color_datatypes = options[:color_datatypes]
    @integer_datatypes = options[:integer_datatypes]
  end

  def which?(type)
    return :date if @date_datatypes.include?(type)
    return :text if @text_datatypes.include?(type)
    return :image if @image_datatypes.include?(type)
    return :string if @string_datatypes.include?(type)
    return :dropdown if @dropdown_datatypes.include?(type)
    return :association if @association_datatypes.include?(type)
    return :linked_list if @linked_list_datatypes.include?(type)
    return :unlinked_list if @unlinked_list_datatypes.include?(type)
    return :color if @color_datatypes.include?(type)
    :integer if @integer_datatypes.include?(type)
  end
end
