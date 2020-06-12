require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "#image_name" do
    before do
      @item = create(:item, name: "popao", id: 999)
    end

    it "should return the name and id string of the image item" do
      expect(@item.image_name).to eq "popao_999_image"
    end
  end

  describe "#self.top_selling_items" do
    before do
      @item_1 = create(:item, name: "Item 1")
      @item_2 = create(:item, name: "Item 2")
      @item_3 = create(:item, name: "Item 3")

      3.times do # item 1 vai ser o top 1 de vendas
        create(:order, item: @item_1)
      end

      2.times do # item 2 vai ser o top 2 de vendas
        create(:order, item: @item_2)
      end

      1.times do # item 3 vai ser o top 3 de vendas
        create(:order, item: @item_2)
      end
    end

    it 'should return the list of the top selling items' do
      expect(Item.top_selling_items.first).to eq @item_1
      expect(Item.top_selling_items.last).to eq @item_3
    end
  end
end
