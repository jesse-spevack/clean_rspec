require "spec_helper"
require "./lib/gilded_rose"

RSpec.describe GildedRose do
  subject(:gilded_rose) { GildedRose.new }

  it "is a gilded rose" do
    expect(gilded_rose).to be_a(GildedRose)
  end

  context "#tick" do
    context "Normal Item after sell date" do
      let(:gilded_rose) { GildedRose.new(name: "Normal Item", days_remaining: -10, quality: 10) }

      it "decreases quality by 2 and decrements days_remaining" do
        gilded_rose.tick

        expect(gilded_rose).to have_attributes(days_remaining: -11, quality: 8)

      end
    end

    context "Normal Item after sell date" do
      let(:gilded_rose) { GildedRose.new(name: "Normal Item", days_remaining: 5, quality: 10) }

      it "decrements both quality and days_remaining" do
        gilded_rose.tick

        expect(gilded_rose).to have_attributes(days_remaining: 4, quality: 9)
      end
    end

    context "Normal Item on sell date" do
      let(:gilded_rose) { GildedRose.new(name: "Normal Item", days_remaining: 0, quality: 10) }

      it "decreases quality by 2 and decrements days_remaining" do
        gilded_rose.tick

        expect(gilded_rose).to have_attributes(days_remaining: -1, quality: 8)
      end
    end

    context "Normal Item of zero quality" do
      let(:gilded_rose) { GildedRose.new(name: "Normal Item", days_remaining: 5, quality: 0) }

      it "decrements ONLY days_remaining" do
        gilded_rose.tick

        expect(gilded_rose).to have_attributes(days_remaining: 4, quality: 0)
      end
    end

    context "Aged Brie before sell date with low quality" do
      let(:gilded_rose) { GildedRose.new(name: "Aged Brie", days_remaining: 5, quality: 10) }

      it "increments quality and decrements days_remaining" do
        gilded_rose.tick

        expect(gilded_rose).to have_attributes(days_remaining: 4, quality: 11)
      end
    end

    context "Aged Brie before sell date with max quality" do
      let(:gilded_rose) { GildedRose.new(name: "Aged Brie", days_remaining: 5, quality: 50) }

      it "only decrements days_remaining" do
        gilded_rose.tick

        expect(gilded_rose).to have_attributes(days_remaining: 4, quality: 50)
      end
    end

    context "Aged Brie on sell date with low quality" do
      let(:gilded_rose) { GildedRose.new(name: "Aged Brie", days_remaining: 0, quality: 10) }

      it "increases quality by 2 and decrements days_remaining" do
        gilded_rose.tick

        expect(gilded_rose).to have_attributes(days_remaining: -1, quality: 12)
      end
    end

    context "Aged Brie on sell date near max quality" do
      let(:gilded_rose) { GildedRose.new(name: "Aged Brie", days_remaining: 0, quality: 49) }

      it "increases quality to max and decrements days_remaining" do
        gilded_rose.tick

        expect(gilded_rose).to have_attributes(days_remaining: -1, quality: 50)
      end
    end

    context "Aged Brie on sell date with max quality" do
      let(:gilded_rose) { GildedRose.new(name: "Aged Brie", days_remaining: 0, quality: 50) }

      it "only decrements days_remaining" do
        gilded_rose.tick

        expect(gilded_rose).to have_attributes(days_remaining: -1, quality: 50)
      end
    end

    context "Aged Brie after sell date with low quality" do
      let(:gilded_rose) { GildedRose.new(name: "Aged Brie", days_remaining: -10, quality: 10) }

      it "increases quality by 2 and decrements days_remaining" do
        gilded_rose.tick

        expect(gilded_rose).to have_attributes(days_remaining: -11, quality: 12)
      end
    end

    context "Aged Brie after sell date with max quality" do
      let(:gilded_rose) { GildedRose.new(name: "Aged Brie", days_remaining: -10, quality: 50) }

      it "only decrements days_remaining" do
        gilded_rose.tick

        expect(gilded_rose).to have_attributes(days_remaining: -11, quality: 50)
      end
    end

    it "sulfuras before sell date" do
      gilded_rose = GildedRose.new(name: "Sulfuras, Hand of Ragnaros", days_remaining: 5, quality: 80)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(5)
      expect(gilded_rose.quality).to eq(80)
    end

    it "sulfuras on sell date" do
      gilded_rose = GildedRose.new(name: "Sulfuras, Hand of Ragnaros", days_remaining: 0, quality: 80)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(0)
      expect(gilded_rose.quality).to eq(80)
    end

    it "sulfuras after sell date" do
      gilded_rose = GildedRose.new(name: "Sulfuras, Hand of Ragnaros", days_remaining: -10, quality: 80)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(-10)
      expect(gilded_rose.quality).to eq(80)
    end

    it "backstage passes long before sell date" do
      gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 11, quality: 10)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(10)
      expect(gilded_rose.quality).to eq(11)
    end

    it "backstage passes long before sell date at max quality" do
      gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 11, quality: 50)

      gilded_rose.tick

      expect(gilded_rose).to have_attributes(days_remaining: 10, quality: 50)
    end

    it "backstage passes medium close to sell date upper bound" do
      gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 10, quality: 10)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(9)
      expect(gilded_rose.quality).to eq(12)
    end

    it "backstage passes medium close to sell date upper bound at max quality" do
      gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 10, quality: 50)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(9)
      expect(gilded_rose.quality).to eq(50)
    end

    it "backstage passes medium close to sell date lower bound" do
      gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 6, quality: 10)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(5)
      expect(gilded_rose.quality).to eq(12)
    end

    it "backstage passes medium close to sell date lower bound at max quality" do
      gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 6, quality: 50)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(5)
      expect(gilded_rose.quality).to eq(50)
    end

    it "backstage passes very close to sell date upper bound" do
      gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 5, quality: 10)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(4)
      expect(gilded_rose.quality).to eq(13)
    end

    it "backstage passes very close to sell date upper bound at max quality" do
      gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 5, quality: 50)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(4)
      expect(gilded_rose.quality).to eq(50)
    end

    it "backstage passes very close to sell date lower bound" do
      gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 1, quality: 10)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(0)
      expect(gilded_rose.quality).to eq(13)
    end

    it "backstage passes very close to sell date lower bound at max quality" do
      gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 1, quality: 50)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(0)
      expect(gilded_rose.quality).to eq(50)
    end

    it "backstage passes on sell date" do
      gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 0, quality: 10)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(-1)
      expect(gilded_rose.quality).to eq(0)
    end

    it "backstage passes after sell date" do
      gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: -10, quality: 10)
  # 
      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(-11)
      expect(gilded_rose.quality).to eq(0)
    end

    xit "conjured mana before sell date" do
      gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: 5, quality: 10)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(4)
      expect(gilded_rose.quality).to eq(8)
    end

    xit "conjured mana before sell date at zero quality" do
      gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: 5, quality: 0)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(4)
      expect(gilded_rose.quality).to eq(0)
    end

    xit "conjured mana on sell date" do
      gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: 0, quality: 10)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(-1)
      expect(gilded_rose.quality).to eq(6)
    end

    xit "conjured mana on sell date at zero quality" do
      gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: 0, quality: 0)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(-1)
      expect(gilded_rose.quality).to eq(0)
    end

    xit "conjured mana after sell date" do
      gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: -10, quality: 10)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(-11)
      expect(gilded_rose.quality).to eq(6)
    end

    xit "conjured mana after sell date at zero quality" do
      gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: -10, quality: 0)

      gilded_rose.tick

      expect(gilded_rose.days_remaining).to eq(-11)
      expect(gilded_rose.quality).to eq(0)
    end
  end
end
