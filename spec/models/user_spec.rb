require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
  	let(:user) { build(:user) }
  	subject { test_user.valid? }
  	context 'nameカラム' do
  		let(:test_user) { user }
  		it '空欄でないこと' do
  			test_user.name = ''
  			is_expected.to eq false;
  		end
      it '2文字以上であること' do
        test_user.name = Faker::Lorem.characters(number:1)
        is_expected.to eq false;
      end
      it '20文字以下であること' do
        test_user.name = Faker::Lorem.characters(number:21)
        is_expected.to eq false;
      end
  	end
  end

  describe 'アソシエーションのテスト' do
    context 'postモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
    context 'favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context 'good_placeモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:good_places).macro).to eq :has_many
      end
    end
    context 'commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'alertモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:alerts).macro).to eq :has_many
      end
    end
    context 'scheduleモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:schedules).macro).to eq :has_many
      end
    end
  end
end
