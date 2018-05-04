# frozen_string_literal: true

require 'rails_helper'

describe Symbol, 'on symbol extension' do
  it 'should be true if the value is on' do
    symbol = :on
    expect(symbol.on?).to be(true)
  end

  it 'should be false if the value is not on' do
    symbol = :off
    expect(symbol.on?).to be(false)
  end
end

describe Symbol, 'off symbol extension' do
  it 'should be true if the value is off' do
    symbol = :off
    expect(symbol.off?).to be(true)
  end

  it 'should be false if the value is not off' do
    symbol = :on
    expect(symbol.off?).to be(false)
  end
end
