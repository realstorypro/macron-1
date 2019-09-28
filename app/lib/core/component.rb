# frozen_string_literal: true

module Core
  class Component
    def initialize(options = {})
      case
        # key can be passed as a string or a symbol
      when !options[:key].blank?
        @key = options[:key].to_s
        @self = component_from_key(@key)
        # klass can either be passed as an actual class or a string
      when !options[:klass].blank?
        @key = key_from_klass(options[:klass])
        @self = component_from_key(@key)
      else
        raise ArgumentError, "Pass the component key or klass in order to build a component"
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

    # @return [Class] returns a class tied to a component.
    def klass
      s("components.#{@key}.klass").classify.constantize
    end

    # @return [String] returns a component name
    def name
      @self.name
    end

    # @return [String] returns a classpath, which
    # can be used to set the required params
    def classpath
      @self.klass.downcase.gsub("::", "_")
    end

    ##### Component Lookups #####

    # pass a component name and get a component back
    def component_from_key(key)
      s("components.#{key}")
    end

    # pass a class and get a component back
    def key_from_klass(klass)
      # turn class into an actual class if a string was passed
      klass = klass.constantize unless klass.instance_of? Class

      # component names are based on class names and are plural
      component_key = klass.name.downcase.pluralize

      # except for site settings
      if component_key.include?("sitesettings")
        component_key = component_key.singularize
        component_key = component_key.gsub("sitesettings", "site_settings")
        component_key = component_key.gsub("::", "_")
      end

      # and elements
      if component_key.include?("elements")
        component_key = component_key.singularize
        component_key = component_key.gsub("::", "_")
      end

      component_key
    end

    ##### Component Lookups #####

    # @param [String] component a name of the component
    # @return [Object] the Config component containing configuration
    def config
      s("views.#{@key}.config")
    end

    # @param [String] kind of view we are retrieving
    def view(kind)
      case kind
      when "new"
        s("views.#{@key}.new")
      when "list"
        s("views.#{@key}.list")
      when "basiclist"
        s("views.#{@key}.basiclist")
      when "show"
        s("views.#{@key}.show")
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
end
