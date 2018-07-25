# frozen_string_literal: true

RSpec.describe Uniqable do
  let!(:dummy) { User.create }
  let!(:dummy_own_uid) { UserOwnUid.create }
  let(:vader) { 'Darth Vader' }

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
    expect(dummy_own_uid.uid).to eq vader
  end

  it 'generates own :another_uid uses :uniqable_uid' do
    expect(dummy_own_uid.another_uid).to eq vader
  end

  describe '#to_param' do
    it 'returns :uid value' do
      expect(dummy.to_param).to eq dummy.uid
      expect(dummy_own_uid.to_param).to eq dummy_own_uid.uid
    end
  end

  context 'with find_* methods' do
    describe '.find_uniqable' do
      it { expect(User.find_uniqable(dummy.uid)).to eq dummy }
      it { expect(User.find_uniqable(dummy.id)).to eq dummy }
      it { expect(User.find_uniqable('WRONG_UID')).to be_nil }

      it { expect(UserOwnUid.find_uniqable(dummy_own_uid.uid)).to eq dummy_own_uid }
      it { expect(UserOwnUid.find_uniqable('WRONG_UID')).to be_nil }
    end

    describe '.find_uniqable!' do
      it { expect(User.find_uniqable!(dummy.uid)).to eq dummy }
      it { expect(User.find_uniqable!(dummy.id)).to eq dummy }
      it { expect { User.find_uniqable!('WRONG_UID') }.to raise_error ActiveRecord::RecordNotFound }

      it { expect(UserOwnUid.find_uniqable!(vader)).to eq dummy_own_uid }
      it { expect { UserOwnUid.find_uniqable!('WRONG_UID') }.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end
