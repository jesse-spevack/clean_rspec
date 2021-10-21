require "spec_helper"
require "./lib/gilded_rose"

RSpec.describe GildedRose::Normal do
  subject(:item) { described_class.new(quality, days_remaining) }

  describe '#tick' do
    context 'before sell date' do
      let(:days_remaining) { 5 }
      let(:quality) { 10 }

      it 'decreases quality by 1' do
        expect { item.tick }.to change { item.quality }
          .from(quality).to(quality - 1)
      end

      it 'decreases days remaining by 1' do
        expect { item.tick }.to change { item.days_remaining }
          .from(days_remaining).to(days_remaining - 1)
      end
    end

    context 'on sell date' do
      let(:days_remaining) { 0 }
      let(:quality) { 10 }

      it 'decreases quality by 2' do
        expect { item.tick }.to change { item.quality }
          .from(quality).to(quality - 2)
      end

      it 'decreases days remaining by 1' do
        expect { item.tick }.to change { item.days_remaining }
          .from(days_remaining).to(days_remaining - 1)
      end
    end

    context 'with zero quality' do
      let(:days_remaining) { 5 }
      let(:quality) { 0 }

      it 'does not change quality' do
        expect { item.tick }.not_to change { item.quality }
      end

      it 'decreases days remaining by 1' do
        expect { item.tick }.to change { item.days_remaining }
          .from(days_remaining).to(days_remaining - 1)
      end
    end
  end
end
