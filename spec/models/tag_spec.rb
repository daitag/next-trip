require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'バリデーションのテスト' do
  	let(:tag) { build(:tag) }

  	context 'tag_nameカラム' do
  		it '空欄でない' do
  			tag.tag_name = ''
  			expect(tag.valid?).to eq false;
  		end
  		it '10文字以下である' do
  			tag.tag_name = Faker::Lorem.characters(number:11)
  			expect(tag.valid?).to eq false;
  		end
  	end
  end
  describe 'アソシエーションのテスト' do
    context 'post_tagsモデルとの関係' do
      it '1:Nとなっている' do
        expect(Tag.reflect_on_association(:post_tags).macro).to eq :has_many
      end
    end
    context 'postモデルとの関係' do
      it '1:Nとなっている' do
        expect(Tag.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
end
