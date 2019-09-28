# frozen_string_literal: true

require "rails_helper"

settings = SettingProxy.instance

describe Core::Component, "component tester for macron-1" do
  @components = settings.fetch("components")

  @components.each do |component|
    it "#{component[1].name} can create a component from symbol name" do
      component_instance = Core::Component.new(key: component[0])
    end


    it "#{component[1].name} can read component name" do
      component_instance = Core::Component.new(key: component[0]).name
    end

    if component[1].respond_to?(:klass)
      it "#{component[1].name} can read component class" do
        component_instance = Core::Component.new(key: component[0])
        expect(component_instance.self.klass).to eq(component[1].klass)
      end
    end
  end

  it "it can create a component from a string class name" do
    component = Core::Component.new(klass: "Tag")
  end

  it "it can create a component from an actual class" do
    component = Core::Component.new(klass: Tag)
  end

  it "can access config" do
    component = Core::Component.new(klass: "Tag")
    component.config
  end

  it "can access new view" do
    component = Core::Component.new(klass: "Tag")
    component.view("new")
  end
end
