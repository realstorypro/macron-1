# frozen_string_literal: true
module ColorHelper
  def inverted?(color, options={})
    # apply default inverted color list if non provided
    default_inverted_color_list = %w(red blue olive green teal purple pink brown black)
    options[:inverted_color_list] = default_inverted_color_list if options[:inverted_color_list].nil?

    if options[:inverted_color_list].include?(color)
      "inverted"
    else
      "regular"
    end
  end
end