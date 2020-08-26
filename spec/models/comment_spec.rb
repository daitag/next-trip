require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーションのテスト' do
  	let(:comment) { build(:comment) }

  	context 'commentカラム' do
  		it '空欄でない' do
  			comment.comment = ''
  			expect(comment.valid?).to eq false;
  		end
  		it '20文字以下である' do
  			comment.comment = Faker::Lorem.characters(number:21)
  			expect(comment.valid?).to eq false;
  		end
  	end
  end
  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'postモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end
