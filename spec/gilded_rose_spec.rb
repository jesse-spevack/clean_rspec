require "spec_helper"
require "./lib/gilded_rose"

RSpec.describe GildedRose do

  describe '.for' do
    subject(:gilded_rose) do 
      described_class.for(
        name: name,
        quality: quality,
        days_remaining: days_remaining
      )
    end

    let(:days_remaining) { 5 }
    let(:quality) { 10 }

    context 'when given normal item'  do
      let(:name) { 'Normal Item' }

      it 'returns normal item' do
        expect(gilded_rose).to be_a(GildedRose::Normal)
      end
    end

    context 'when given brie item'  do
      let(:name) { 'Aged Brie' }

      it 'returns normal item' do
        expect(gilded_rose).to be_a(GildedRose::Brie)
      end
    end

    context 'when given backstage item'  do
      let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }

      it 'returns normal item' do
        expect(gilded_rose).to be_a(GildedRose::Backstage)
      end
    end
  end

  xit "conjured mana before sell date at zero quality" do
    gr = GildedRose.for(name: "Conjured Mana Cake", days_remaining: 5, quality: 0)

    gr.tick

    expect(gr.days_remaining).to eq(4)
    expect(gr.quality).to eq(0)
  end

  xit "conjured mana on sell date" do
    gr = GildedRose.for(name: "Conjured Mana Cake", days_remaining: 0, quality: 10)

    gr.tick

    expect(gr.days_remaining).to eq(-1)
    expect(gr.quality).to eq(6)
  end

  xit "conjured mana on sell date at zero quality" do
    gr = GildedRose.for(name: "Conjured Mana Cake", days_remaining: 0, quality: 0)

    gr.tick

    expect(gr.days_remaining).to eq(-1)
    expect(gr.quality).to eq(0)
  end

  xit "conjured mana after sell date" do
    gr = GildedRose.for(name: "Conjured Mana Cake", days_remaining: -10, quality: 10)

    gr.tick

    expect(gr.days_remaining).to eq(-11)
    expect(gr.quality).to eq(6)
  end

  xit "conjured mana after sell date at zero quality" do
    gr = GildedRose.for(name: "Conjured Mana Cake", days_remaining: -10, quality: 0)

    gr.tick

    expect(gr.days_remaining).to eq(-11)
    expect(gr.quality).to eq(0)
  end
end
