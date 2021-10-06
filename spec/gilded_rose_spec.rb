require "spec_helper"
require "./lib/gilded_rose"

RSpec.describe GildedRose do
  it "normal item before sell date" do
    gilded_rose = GildedRose.new(name: "Normal Item", days_remaining: 5, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 4, quality: 9)
  end

  it "normal item on sell date" do
    gilded_rose = GildedRose.new(name: "Normal Item", days_remaining: 0, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: -1, quality: 8)
  end

  it "normal item on sell date" do
    gilded_rose = GildedRose.new(name: "Normal Item", days_remaining: 0, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: -1, quality: 8)
  end

  it "normal item after sell date" do
    gilded_rose = GildedRose.new(name: "Normal Item", days_remaining: -10, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: -11, quality: 8)
  end

  it "normal item of zero quality" do
    gilded_rose = GildedRose.new(name: "Normal Item", days_remaining: 5, quality: 0)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 4, quality: 0)
  end

  it "aged brie before sell date" do
    gilded_rose = GildedRose.new(name: "Aged Brie", days_remaining: 5, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 4, quality: 11)
  end

  it "aged brie with max quality" do
    gilded_rose = GildedRose.new(name: "Aged Brie", days_remaining: 5, quality: 50)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 4, quality: 50)
  end

  it "aged brie on sell date" do
    gilded_rose = GildedRose.new(name: "Aged Brie", days_remaining: 0, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: -1, quality: 12)
  end

  it "aged brie on sell date near max quality" do
    gilded_rose = GildedRose.new(name: "Aged Brie", days_remaining: 0, quality: 49)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: -1, quality: 50)
  end

  it "aged brie on sell date with max quality" do
    gilded_rose = GildedRose.new(name: "Aged Brie", days_remaining: 0, quality: 50)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: -1, quality: 50)
  end

  it "aged brie after sell date" do
    gilded_rose = GildedRose.new(name: "Aged Brie", days_remaining: -10, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: -11, quality: 12)
  end

  it "aged brie after sell date with max quality" do
    gilded_rose = GildedRose.new(name: "Aged Brie", days_remaining: -10, quality: 50)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: -11, quality: 50)
  end

  it "sulfuras before sell date" do
    gilded_rose = GildedRose.new(name: "Sulfuras, Hand of Ragnaros", days_remaining: 5, quality: 80)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 5, quality: 80)
  end

  it "sulfuras on sell date" do
    gilded_rose = GildedRose.new(name: "Sulfuras, Hand of Ragnaros", days_remaining: 0, quality: 80)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 0, quality: 80)
  end

  it "sulfuras after sell date" do
    gilded_rose = GildedRose.new(name: "Sulfuras, Hand of Ragnaros", days_remaining: -10, quality: 80)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: -10, quality: 80)
  end

  it "backstage passes long before sell date" do
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 11, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 10, quality: 11)
  end

  it "backstage passes long before sell date at max quality" do
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 11, quality: 50)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 10, quality: 50)
  end

  it "backstage passes medium close to sell date upper bound" do
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 10, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 9, quality: 12)
  end

  it "backstage passes medium close to sell date upper bound at max quality" do
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 10, quality: 50)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 9, quality: 50)
  end

  it "backstage passes medium close to sell date lower bound" do
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 6, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 5, quality: 12)
  end

  it "backstage passes medium close to sell date lower bound at max quality" do
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 6, quality: 50)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 5, quality: 50)
  end

  it "backstage passes very close to sell date upper bound" do
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 5, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 4, quality: 13)
  end

  it "backstage passes very close to sell date upper bound at max quality" do
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 5, quality: 50)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 4, quality: 50)
  end

  it "backstage passes very close to sell date lower bound" do
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 1, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 0, quality: 13)
  end

  it "backstage passes very close to sell date lower bound at max quality" do
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 1, quality: 50)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 0, quality: 50)
  end

  it "backstage passes on sell date" do
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 0, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: -1, quality: 0)
  end

  it "backstage passes after sell date" do
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: -10, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: -11, quality: 0)
  end

  xit "conjured mana before sell date" do
    gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: 5, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 4, quality: 8)
  end

  xit "conjured mana before sell date at zero quality" do
    gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: 5, quality: 0)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: 4, quality: 0)
  end

  xit "conjured mana on sell date" do
    gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: 0, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: -1, quality: 6)
  end

  xit "conjured mana on sell date at zero quality" do
    gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: 0, quality: 0)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: -1, quality: 0)
  end

  xit "conjured mana after sell date" do
    gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: -10, quality: 10)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: -11, quality: 6)
  end

  xit "conjured mana after sell date at zero quality" do
    gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: -10, quality: 0)

    gilded_rose.tick

    expect(gilded_rose).to have_attributes(days_remaining: -11, quality: 0)
  end
end
