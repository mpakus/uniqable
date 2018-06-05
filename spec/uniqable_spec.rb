# frozen_string_literal: true

require_relative 'fixtures/dummy'

RSpec.describe Uniqable do
  it 'has a version number' do
    expect(Uniqable::VERSION).not_to be nil
  end

  it 'generates :uid' do
    expect(Dummy.create.uid).not_to be_empty
  end

  it 'generates :another_uid' do
    expect(Dummy.create.another_uid).not_to be_empty
  end

  it 'generates own :uid uses :uniqable_uid' do
    expect(DummyOwnUid.create.uid).to eq 'Darth Vader'
  end

  it 'generates own :another_uid uses :uniqable_uid' do
    expect(DummyOwnUid.create.another_uid).to eq 'Darth Vader'
  end
end
