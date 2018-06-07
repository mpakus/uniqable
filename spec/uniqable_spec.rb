# frozen_string_literal: true

require_relative 'fixtures/dummy'

RSpec.describe Uniqable do
  let(:dummy) { Dummy.create }
  let(:dummy_own_uid) { DummyOwnUid.create }

  it 'has a version number' do
    expect(Uniqable::VERSION).not_to be nil
  end

  it 'generates :uid' do
    expect(dummy.uid).not_to be_empty
  end

  it 'generates :another_uid' do
    expect(dummy.another_uid).not_to be_empty
  end

  it 'generates own :uid uses :uniqable_uid' do
    expect(dummy_own_uid.uid).to eq 'Darth Vader'
  end

  it 'generates own :another_uid uses :uniqable_uid' do
    expect(dummy_own_uid.another_uid).to eq 'Darth Vader'
  end

  describe '#to_param' do
    it 'returns :uid value' do
      expect(dummy.to_param).to eq dummy.uid
      expect(dummy_own_uid.to_param).to eq dummy_own_uid.uid
    end
  end
end
