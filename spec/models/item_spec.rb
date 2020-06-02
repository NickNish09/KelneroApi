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
end
