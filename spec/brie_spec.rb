require "spec_helper"
require "./lib/gilded_rose"

RSpec.describe GildedRose::Brie do
  subject(:item) { described_class.new(quality, days_remaining) }

  describe '#tick' do
    context 'before sell date' do
      let(:days_remaining) { 5 }
      let(:quality) { 10 }

      it 'increases quality by 1' do
        expect { item.tick }.to change { item.quality }
          .from(quality).to(quality + 1)
      end

      it 'decreases days remaining by 1' do
        expect { item.tick }.to change { item.days_remaining }
          .from(days_remaining).to(days_remaining - 1)
      end
    end
 
    context 'with max quality' do
      let(:days_remaining) { 5 }
      let(:quality) { 50 }

      it 'does not change quality' do
        expect { item.tick }.not_to change { item.quality }
      end

      it 'decreases days remaining by 1' do
        expect { item.tick }.to change { item.days_remaining }
          .from(days_remaining).to(days_remaining - 1)
      end
    end

    context 'on sell date' do
      let(:days_remaining) { 0 }
      let(:quality) { 10 }

      it 'increases quality by 2' do
        expect { item.tick }.to change { item.quality }
          .from(quality).to(quality + 2)
      end

      it 'decreases days remaining by 1' do
        expect { item.tick }.to change { item.days_remaining }
          .from(days_remaining).to(days_remaining - 1)
      end
    end

    context 'on sell date with near max quality' do
      let(:days_remaining) { 0 }
      let(:quality) { 49 }

      it 'increases quality by 1' do
        expect { item.tick }.to change { item.quality }
          .from(quality).to(quality + 1)
      end

      it 'decreases days remaining by 1' do
        expect { item.tick }.to change { item.days_remaining }
          .from(days_remaining).to(days_remaining - 1)
      end
    end

    context 'after sell date' do
      let(:days_remaining) { -10 }
      let(:quality) { 10 }

      it 'increases quality by 2' do
        expect { item.tick }.to change { item.quality }
          .from(quality).to(quality + 2)
      end

      it 'decreases days remaining by 1' do
        expect { item.tick }.to change { item.days_remaining }
          .from(days_remaining).to(days_remaining - 1)
      end
    end

    context 'after sell date with max quality' do
      let(:days_remaining) { -10 }
      let(:quality) { 50 }

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
