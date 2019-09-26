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
    when !options[:classpath].blank?
      @key = component_from_classpath(options[:classpath])[0]
      @self = component_from_classpath(options[:classpath])[1]
    else
      raise ArgumentError, "Pass name, klass or classpath in order to build a component"
    end

  end

  ##### Accessors #####

  # @return [String] a unique key by which component can be accessed.
  def key
    @key
  end

  # @return [String] returns the name of the component.
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
    found_component = nil
    number_found = 0
    s("components").each do |component|
      if component[1].respond_to?(:klass) && component[1].klass == klass.to_s
        number_found += 1
        found_component = component
      end
    end

    raise StandardError.new "Multiple componenets with class #{klass.to_s} found. Use another lookup method." if number_found > 1
    raise StandardError.new "Component with class #{klass.to_s} is not found" if found_component.nil?

    found_component
  end

  # # pass a classpath and get a component back
  def component_from_classpath(classpath)
    found_component = nil
    s("components").each do |component|
      if component[1].respond_to?(:klass) && get_classpath(component[0]) == classpath.to_s
        found_component = component
      end
    end
    return found_component unless found_component.nil?
    raise StandardError.new "Component with classpath #{classpath.to_s} is not found"
  end

  ##### Component Lookups #####
  #

  # @param [String] component a name of the component
  # @return [String] returns formatted class name following the FactoryBot
  # conventions. The string is lowercase and "::" is replaced by an undescore.
  def get_classpath(component)
    # returns the lowercase version of the class
    class_path = s("components.#{component}.klass").downcase

    # changing namespaces into the "_" format
    class_path.gsub("::", "_")
  end

  # @param [String] component a name of the component
  # @return [Object] the Config component containing configuration
  def config
    s("views.#{classpath}.config")
  end

  # @param [String] kind of view we are retrieving
  def view(kind)
    case kind
    when "new"
      s("views.#{classpath}.new")
    when "list"
      s("views.#{classpath}.list")
    when "basiclist"
      s("views.#{classpath}.basiclist")
    when "show"
      s("views.#{classpath}.show")
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
