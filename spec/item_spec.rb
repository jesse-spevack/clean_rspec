require "spec_helper"
require "./lib/gilded_rose"

RSpec.describe GildedRose::Item do
  subject(:item) { described_class.new(quality, days_remaining) }

  let(:days_remaining) { 1 }
  let(:quality) { 5 }

  describe '#days_remianing' do
    it 'returns given days remaining' do
      expect(item.days_remaining).to eq(days_remaining)
    end
  end

  describe '#quality' do
    it 'returns given quality' do
      expect(item.quality).to eq(quality)
    end
  end

  describe '#tick' do
    it 'does not change quality' do
      expect { item.tick }.not_to change { item.quality }
    end

    it 'does not change days remaining' do
      expect { item.tick }.not_to change { item.days_remaining } 
    end
  end
end
