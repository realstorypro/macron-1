# frozen_string_literal: true

# Component Object for Macron-1
class Component
  def initialize(options = {})
    case

      # key can be passed as a string or a symbol
    when !options[:key].blank?
      @key = options[:key].to_s
      @self = component_from_key(@key)

      # klass can either be passed as an actual class or a string
    when !options[:klass].blank?
      @key = component_from_klass(options[:klass])[0]
      @self = component_from_klass(options[:klass])[1]
    else
      raise ArgumentError, "Pass name, klass or classpath in order to build a component"
    end

  end

  ##### Accessors #####

  # @return [String] a unique key by which component can be accessed.
  def key
    @key
  end

  # @return [Object] the YML interpretation of component
  def self
    @self
  end

  # @return [String] returns the formatted name of component class.
  def classpath
    get_classpath(@key)
  end


  ##### Component Lookups #####

  # pass a component name and get a component back
  def component_from_key(key)
    s("components.#{key}")
  end

  # pass a class and get a component back
  def component_from_klass(klass)
    # turn class into an actual class if a string was passed
    klass = klass.constantize unless klass.instance_of? Class

    # component names are based on class names and are plural
    component_name = klass.name.downcase.pluralize

    # except for site settings
    if component_name.include?("sitesettings")
      component_name = self.name.downcase.singularize
      component_name = component_name.gsub("sitesettings", "site_settings")
      component_name = component_name.gsub("::", "_")
    end

    # and elements
    if component_name.include?("elements")
      component_name = self.name.downcase.singularize
      component_name = component_name.gsub("::", "_")
    end

    found_component = s("components.#{component_name}")
  end

  ##### Component Lookups #####

  # @param [String] component a name of the component
  # @return [Object] the Config component containing configuration
  def config
    s("views.#{classpath}.config")
  end

  # @param [String] kind of view we are retrieving
  def view(kind)
    case kind
    when "new"
      s("views.#{@id}.new")
    when "list"
      s("views.#{@id}.list")
    when "basiclist"
      s("views.#{@id}.basiclist")
    when "show"
      s("views.#{@id}.show")
    else
      raise StandardError.new "View #{kind} is not defined"
    end
  end

  private

  # shortcut for site settings
  def s(path)
    SettingProxy.instance.s(path)
  end

end