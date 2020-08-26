require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーションのテスト' do
  	let(:user) { create(:user) }
  	let(:post) { build(:post, user_id: user.id) }

  	context 'titleカラム' do
  		it '空欄でない' do
  			post.title = ''
  			expect(post.valid?).to eq false;
  		end
  		it '10文字以下である' do
  			post.title = Faker::Lorem.characters(number:11)
  			expect(post.valid?).to eq false;
  		end
  	end
  	context 'bodyカラム' do
  		it '空欄でない' do
  			post.body = ''
  			expect(post.valid?).to eq false;
  		end
  		it '150文字いない' do
  			post.body = Faker::Lorem.characters(number: 151)
  			expect(post.valid?).to eq false;
  		end
  	end
  	context 'locationカラム' do
  		it '空白でない' do
  			post.location = ''
  			expect(post.valid?).to eq false;
  		end
  		it '15文字いない' do
  			post.location = Faker::Lorem.characters(number: 16)
  			expect(post.valid?).to eq false;
  		end
  	end
  end

  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context 'good_placeモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:good_places).macro).to eq :has_many
      end
    end
    context 'commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'alertモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:alerts).macro).to eq :has_many
      end
    end
    context 'post_imageモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:post_images).macro).to eq :has_many
      end
    end
    context 'post_tagsモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:post_tags).macro).to eq :has_many
      end
    end
    context 'tagsモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:tags).macro).to eq :has_many
      end
    end
  end
end
