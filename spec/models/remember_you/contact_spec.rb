require 'rails_helper'

RSpec.describe "Contactモデルのテスト", type: :model do
  describe "バリデーションテスト" do
    let(:contact) { create(:contact) }

    subject { test_contact.valid? }
    let(:test_contact) { contact }

    context "nameカラム" do
      it "空欄でないこと" do
        test_contact.name = ''
        is_expected.to eq false;
      end
    end
  end
end
