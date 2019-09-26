require "rails_helper"

settings = SettingProxy.instance

describe Component, "component tester for macron-1" do
  @components = settings.fetch('components')

  @components.each do |component|
    it "#{component[1].name} can create a component from symbol name" do
      component_instance = Component.new(key: component[0])
    end

    if component[1].respond_to?(:klass)
      it "#{component[0]} can create a component from a non duplicate class" do
        # ignoring components which have duplicate classes
        ignored_components = %w(users members store products)

        Component.new(klass: component[1].klass) unless ignored_components.include? (component[0].to_s)
      end
    end

    if component[1].respond_to?(:klass)
      it "#{component[0]} cant create a component from a duplicate class component" do
        duplicate_class_components = %w(users members store products)
        if duplicate_class_components.include? (component[0].to_s)
          expect{ Component.new(klass: component[1].klass)}.to raise_exception
        end
      end
    end

    it "#{component[1].name} can read component name" do
      component_instance = Component.new(key: component[0]).self.name
    end

    if component[1].respond_to?(:klass)
      it "#{component[1].name} can read component class" do
        component_instance = Component.new(key: component[0])
        expect(component_instance.self.klass).to eq(component[1].klass)
      end
    end

  end

end