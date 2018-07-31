# frozen_string_literal: true

class DataType
  def initialize(options = {})
    defaults = {
      text_datatypes: %w(text rich),
      string_datatypes: %w(string date datepicker image),
      integer_datatypes: %w(integer)
    }
    options = defaults.merge(options)

    @text_datatypes = options[:text_datatypes]
    @string_datatypes = options[:string_datatypes]
    @integer_datatypes = options[:integer_datatypes]
  end

  def which?(type)
    :text if @text_datatypes.include?(type)
    :string if @string_datatypes.include?(type)
    :integer if @integer_datatypes.include?(type)
  end
end
