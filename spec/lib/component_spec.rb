require "rails_helper"

settings = SettingProxy.instance

describe Component, "component tester for macron-1" do
  @components = settings.fetch('components')

  @components.each do |component|
    it "#{component[1].name} can create a component from symbol name" do
      component_instance = Component.new(key: component[0])
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

  it "it can create a component from a string class name" do
    component = Component.new(klass: 'Tag')
  end

  it "it can create a component from an actual class" do
    component = Component.new(klass: Tag)
  end

end