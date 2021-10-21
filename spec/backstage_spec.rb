require "spec_helper"
require "./lib/gilded_rose"

RSpec.describe GildedRose::Backstage do
  subject(:item) { described_class.new(quality, days_remaining) }

  describe '#tick' do
    context 'long before sell date' do
      let(:days_remaining) { 11 }
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

    context 'long before sell date at max quality' do
      let(:days_remaining) { 11 }
      let(:quality) { 50 }

      it 'does not change quality' do
        expect { item.tick }.not_to change { item.quality }
      end

      it 'decreases days remaining by 1' do
        expect { item.tick }.to change { item.days_remaining }
          .from(days_remaining).to(days_remaining - 1)
      end
    end

    context 'medium close to sell date upper bound' do
      let(:days_remaining) { 10 }
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

    context 'medium close to sell date upper bound at max quality' do
      let(:days_remaining) { 10 }
      let(:quality) { 50 }

      it 'does not change quality' do
        expect { item.tick }.not_to change { item.quality }
      end

      it 'decreases days remaining by 1' do
        expect { item.tick }.to change { item.days_remaining }
          .from(days_remaining).to(days_remaining - 1)
      end
    end

    context 'medium close to sell date lower bound' do
      let(:days_remaining) { 6 }
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

    context 'medium close to sell date lower bound at max quality' do
      let(:days_remaining) { 6 }
      let(:quality) { 50 }

      it 'does not change quality' do
        expect { item.tick }.not_to change { item.quality }
      end

      it 'decreases days remaining by 1' do
        expect { item.tick }.to change { item.days_remaining }
          .from(days_remaining).to(days_remaining - 1)
      end
    end

    context 'very close to sell date upper bound' do
      let(:days_remaining) { 5 }
      let(:quality) { 10 }

      it 'increases quality by 3' do
        expect { item.tick }.to change { item.quality }
          .from(quality).to(quality + 3)
      end

      it 'decreases days remaining by 1' do
        expect { item.tick }.to change { item.days_remaining }
          .from(days_remaining).to(days_remaining - 1)
      end
    end

    context 'very close to sell date upper bound at max quality' do
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

    context 'very close to sell date lower bound' do
      let(:days_remaining) { 1 }
      let(:quality) { 10 }

      it 'increases quality by 3' do
        expect { item.tick }.to change { item.quality }
          .from(quality).to(quality + 3)
      end

      it 'decreases days remaining by 1' do
        expect { item.tick }.to change { item.days_remaining }
          .from(days_remaining).to(days_remaining - 1)
      end
    end

    context 'very close to sell date lower bound at max quality' do
      let(:days_remaining) { 1 }
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

      it 'decreases quality to 0' do
        expect { item.tick }.to change { item.quality }
          .from(quality).to(0)
      end

      it 'decreases days remaining by 1' do
        expect { item.tick }.to change { item.days_remaining }
          .from(days_remaining).to(days_remaining - 1)
      end
    end

    context 'after sell date' do
      let(:days_remaining) { 0 }
      let(:quality) { 10 }

      it 'decreases quality to 0' do
        expect { item.tick }.to change { item.quality }
          .from(quality).to(0)
      end

      it 'decreases days remaining by 1' do
        expect { item.tick }.to change { item.days_remaining }
          .from(days_remaining).to(days_remaining - 1)
      end
    end
  end
end
