require "spec_helper"
require "./lib/gilded_rose"

RSpec.describe GildedRose do
  subject(:gilded_rose) { GildedRose.new }

  let(:name) { 'Normal Item' }

  it "is a gilded rose" do
    expect(gilded_rose).to be_a(GildedRose)
  end

  describe '#tick' do
    context 'when a normal item is after the sell date' do
      subject(:normal_item) { GildedRose.new(name: "Normal Item", days_remaining: -10, quality: 10) }

      it "decrements days remaining and quality" do    
        normal_item.tick
    
        expect(normal_item.days_remaining).to eq(-11)
        expect(normal_item.quality).to eq(8)
      end
    end

    context 'when a normal item is on sell date' do
      subject(:normal_item) { GildedRose.new(name: "Normal Item", days_remaining: 0, quality: 10) }

      before do
        normal_item.tick
      end

      it "decrements days remaining and quality" do        
        expect(normal_item.days_remaining).to eq(-1)
        expect(normal_item.quality).to eq(8)
      end
    end

    context 'when a normal item is before the sell date' do
      let(:normal_item) { GildedRose.new(name: "Normal Item", days_remaining: 5, quality: 10) }

      it "decrements days remaining and quality" do
        normal_item.tick
    
        expect(normal_item).to have_attributes(days_remaining: 4, quality: 9)
      end
    end

    context 'when aged brie is before its sell date and has normal quality' do
      let(:aged_brie) { GildedRose.new(name: "Aged Brie", days_remaining: 5, quality: 10) }
      it 'decrements remaining days and increments the quality' do
        aged_brie.tick
        expect(aged_brie).to have_attributes(days_remaining: 4, quality: 11)
      end
    end

    context 'when aged brie is before its sell date and has maximum quality' do
      let(:aged_brie) { GildedRose.new(name: "Aged Brie", days_remaining: 5, quality: 50) }
      it 'decrements remaining days and maintains the quality' do
        aged_brie.tick
        expect(aged_brie).to have_attributes(days_remaining: 4, quality: 50)
      end
    end

    context 'when aged brie is on its sell date and has normal quality' do
      let(:aged_brie) { GildedRose.new(name: "Aged Brie", days_remaining: 0, quality: 10) }
      it 'decrements remaining days and increments the quality' do
        aged_brie.tick
        expect(aged_brie).to have_attributes(days_remaining: -1, quality: 12)
      end
    end

    context 'when aged brie is on its sell date and has high quality' do
      let(:aged_brie) { GildedRose.new(name: "Aged Brie", days_remaining: 0, quality: 49) }
      it 'decrements remaining days and increments the quality' do
        aged_brie.tick
        expect(aged_brie).to have_attributes(days_remaining: -1, quality: 50)
      end
    end

    context 'when aged brie is on its sell date and has maximum quality' do
      let(:aged_brie) { GildedRose.new(name: "Aged Brie", days_remaining: 0, quality: 50) }
      it 'decrements remaining days and maintains the quality' do
        aged_brie.tick
        expect(aged_brie).to have_attributes(days_remaining: -1, quality: 50)
      end
    end

    context 'when aged brie is past its sell date and has normal quality' do
      let(:aged_brie) { GildedRose.new(name: "Aged Brie", days_remaining: -10, quality: 10) }
      it 'decrements remaining days and increments the quality' do
        aged_brie.tick
        expect(aged_brie).to have_attributes(days_remaining: -11, quality: 12)
      end
    end

    context 'when aged brie is past its sell date and has maximum quality' do
      let(:aged_brie) { GildedRose.new(name: "Aged Brie", days_remaining: -10, quality: 50) }
      it 'decrements remaining days and maintains the quality' do
        aged_brie.tick
        expect(aged_brie).to have_attributes(days_remaining: -11, quality: 50)
      end
    end
  end

  it "normal item of zero quality" do
    gr = GildedRose.new(name: name, days_remaining: 5, quality: 0)

    gr.tick

    expect(gr.days_remaining).to eq(4)
    expect(gr.quality).to eq(0)
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
