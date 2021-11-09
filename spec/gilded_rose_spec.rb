require "spec_helper"
require "./lib/gilded_rose"

RSpec.describe GildedRose do
  describe 'object creation' do
    subject(:new_gilded_rose) { GildedRose.new }

    it "is a gilded rose" do
      expect(new_gilded_rose).to be_a(GildedRose)
    end
  end

  describe '#tick' do
    context 'when the item is normal' do
      context 'when the quality is greater than 0' do
        context 'when the item is before the sell date' do
          let(:fresh_normal_item) { GildedRose.new(name: "Normal Item", days_remaining: 5, quality: 10) }

          before { fresh_normal_item.tick }

          it 'subtracts 1 from the days remaining and the quality' do
            expect(fresh_normal_item).to have_attributes(days_remaining: 4, quality: 9)
          end
        end

        context 'when the item is on the sell date' do
          let(:normal_item_on_sell_date) { GildedRose.new(name: "Normal Item", days_remaining: 0, quality: 10) }

          before { normal_item_on_sell_date.tick }

          it 'subtracts 1 from the days remaining and subtracts 2 from the quality' do
            expect(normal_item_on_sell_date).to have_attributes(days_remaining: -1, quality: 8)
          end
        end

        context 'when the item is after the sell date' do
          let(:expired_normal_item) { GildedRose.new(name: "Normal Item", days_remaining: -10, quality: 10) }

          before { expired_normal_item.tick }

          it 'subtracts 1 from the days remaining and subtracts 2 from the quality' do
            expect(expired_normal_item).to have_attributes(days_remaining: -11, quality: 8)
          end

        end
      end

      context 'when the quality is 0' do
        context 'when the item is before the sell date' do
          let(:normal_item_with_zero_quality) { GildedRose.new(name: "Normal Item", days_remaining: 5, quality: 0) }

          before { normal_item_with_zero_quality.tick }

          it 'subtracts 1 from the days remaining and the quality is 0' do
            expect(normal_item_with_zero_quality).to have_attributes(days_remaining: 4, quality: 0)
          end
        end
      end
    end

    context 'when the item is "Aged Brie"' do
      context 'when it is before the sell date' do
        context 'when the quality is less than 50' do
          let(:fresh_aged_brie_with_low_quality) { GildedRose.new(name: 'Aged Brie', days_remaining: 5, quality: 10) }

          before { fresh_aged_brie_with_low_quality.tick }

          it 'subtracts 1 from the days remaining and adds 1 to the quality' do
            expect(fresh_aged_brie_with_low_quality).to have_attributes(days_remaining: 4, quality: 11)
          end
        end

        context 'when the quality is the maximum (50)' do
          let(:fresh_aged_brie_with_max_quality) { GildedRose.new(name: 'Aged Brie', days_remaining: 5, quality: 50) }

          before { fresh_aged_brie_with_max_quality.tick }

          it 'subtracts 1 from the days remaining and the quality stays the same' do
            expect(fresh_aged_brie_with_max_quality).to have_attributes(days_remaining: 4, quality: 50)
          end
        end
      end

      context 'when it is on the sell date' do
        context 'when it is more than one from max quality' do
          let(:aged_brie_with_low_quality) { GildedRose.new(name: 'Aged Brie', days_remaining: 0, quality: 10) }

          before { aged_brie_with_low_quality.tick }

          it 'subtracts 1 from the days remaining and adds 2 to the quality' do
            expect(aged_brie_with_low_quality).to have_attributes(days_remaining: -1, quality: 12)
          end
        end

        context 'when it is less than one from max quality' do
          let(:aged_brie_close_to_max_quality) { GildedRose.new(name: 'Aged Brie', days_remaining: 0, quality: 49) }

          before { aged_brie_close_to_max_quality.tick }

          it 'subtracts 1 from the days remaining and adds 2 to the quality' do
            expect(aged_brie_close_to_max_quality).to have_attributes(days_remaining: -1, quality: 50)
          end
        end
      end

      context 'when it is after the sell date' do
        context 'when it is more than one from max quality' do
          let(:expired_aged_brie_with_low_quality) { GildedRose.new(name: 'Aged Brie', days_remaining: -10, quality: 10) }

          before { expired_aged_brie_with_low_quality.tick }

          it 'subtracts 1 from the days remaining and adds 2 to the quality' do
            expect(expired_aged_brie_with_low_quality).to have_attributes(days_remaining: -11, quality: 12)
          end
        end

        context 'when it is at the max quality' do
          let(:expired_aged_brie_at_max_quality) { GildedRose.new(name: 'Aged Brie', days_remaining: -10, quality: 50) }

          before { expired_aged_brie_at_max_quality.tick }

          it 'subtracts 1 from the days remaining and adds 2 to the quality' do
            expect(expired_aged_brie_at_max_quality).to have_attributes(days_remaining: -11, quality: 50)
          end
        end
      end
    end
  end


  it "sulfuras before sell date" do
    gr = GildedRose.new(name: "Sulfuras, Hand of Ragnaros", days_remaining: 5, quality: 80)

    gr.tick

    expect(gr.days_remaining).to eq(5)
    expect(gr.quality).to eq(80)
  end

  it "sulfuras on sell date" do
    gr = GildedRose.new(name: "Sulfuras, Hand of Ragnaros", days_remaining: 0, quality: 80)

    gr.tick

    expect(gr.days_remaining).to eq(0)
    expect(gr.quality).to eq(80)
  end

  it "sulfuras after sell date" do
    gr = GildedRose.new(name: "Sulfuras, Hand of Ragnaros", days_remaining: -10, quality: 80)

    gr.tick

    expect(gr.days_remaining).to eq(-10)
    expect(gr.quality).to eq(80)
  end

  it "backstage passes long before sell date" do
    gr = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 11, quality: 10)

    gr.tick

    expect(gr.days_remaining).to eq(10)
    expect(gr.quality).to eq(11)
  end

  it "backstage passes long before sell date at max quality" do
    gr = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 11, quality: 50)

    gr.tick

    expect(gr).to have_attributes(days_remaining: 10, quality: 50)
  end

  it "backstage passes medium close to sell date upper bound" do
    gr = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 10, quality: 10)

    gr.tick

    expect(gr.days_remaining).to eq(9)
    expect(gr.quality).to eq(12)
  end

  it "backstage passes medium close to sell date upper bound at max quality" do
    gr = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 10, quality: 50)

    gr.tick

    expect(gr.days_remaining).to eq(9)
    expect(gr.quality).to eq(50)
  end

  it "backstage passes medium close to sell date lower bound" do
    gr = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 6, quality: 10)

    gr.tick

    expect(gr.days_remaining).to eq(5)
    expect(gr.quality).to eq(12)
  end

  it "backstage passes medium close to sell date lower bound at max quality" do
    gr = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 6, quality: 50)

    gr.tick

    expect(gr.days_remaining).to eq(5)
    expect(gr.quality).to eq(50)
  end

  it "backstage passes very close to sell date upper bound" do
    gr = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 5, quality: 10)

    gr.tick

    expect(gr.days_remaining).to eq(4)
    expect(gr.quality).to eq(13)
  end

  it "backstage passes very close to sell date upper bound at max quality" do
    gr = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 5, quality: 50)

    gr.tick

    expect(gr.days_remaining).to eq(4)
    expect(gr.quality).to eq(50)
  end

  it "backstage passes very close to sell date lower bound" do
    gr = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 1, quality: 10)

    gr.tick

    expect(gr.days_remaining).to eq(0)
    expect(gr.quality).to eq(13)
  end

  it "backstage passes very close to sell date lower bound at max quality" do
    gr = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 1, quality: 50)

    gr.tick

    expect(gr.days_remaining).to eq(0)
    expect(gr.quality).to eq(50)
  end

  it "backstage passes on sell date" do
    gr = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 0, quality: 10)

    gr.tick

    expect(gr.days_remaining).to eq(-1)
    expect(gr.quality).to eq(0)
  end

  it "backstage passes after sell date" do
    gr = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: -10, quality: 10)
#
    gr.tick

    expect(gr.days_remaining).to eq(-11)
    expect(gr.quality).to eq(0)
  end

  xit "conjured mana before sell date" do
    gr = GildedRose.new(name: "Conjured Mana Cake", days_remaining: 5, quality: 10)

    gr.tick

    expect(gr.days_remaining).to eq(4)
    expect(gr.quality).to eq(8)
  end

  xit "conjured mana before sell date at zero quality" do
    gr = GildedRose.new(name: "Conjured Mana Cake", days_remaining: 5, quality: 0)

    gr.tick

    expect(gr.days_remaining).to eq(4)
    expect(gr.quality).to eq(0)
  end

  xit "conjured mana on sell date" do
    gr = GildedRose.new(name: "Conjured Mana Cake", days_remaining: 0, quality: 10)

    gr.tick

    expect(gr.days_remaining).to eq(-1)
    expect(gr.quality).to eq(6)
  end

  xit "conjured mana on sell date at zero quality" do
    gr = GildedRose.new(name: "Conjured Mana Cake", days_remaining: 0, quality: 0)

    gr.tick

    expect(gr.days_remaining).to eq(-1)
    expect(gr.quality).to eq(0)
  end

  xit "conjured mana after sell date" do
    gr = GildedRose.new(name: "Conjured Mana Cake", days_remaining: -10, quality: 10)

    gr.tick

    expect(gr.days_remaining).to eq(-11)
    expect(gr.quality).to eq(6)
  end

  xit "conjured mana after sell date at zero quality" do
    gr = GildedRose.new(name: "Conjured Mana Cake", days_remaining: -10, quality: 0)

    gr.tick

    expect(gr.days_remaining).to eq(-11)
    expect(gr.quality).to eq(0)
  end
end
