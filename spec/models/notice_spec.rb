require 'rails_helper'

RSpec.describe Notice, type: :model do
  describe 'バリデーションのテスト' do
  	let(:notice) { build(:notice) }

  	context 'titleカラム' do
  		it '空欄でない' do
  			notice.title = ''
  			expect(notice.valid?).to eq false;
  		end
  		it '10文字以下である' do
  			notice.title = Faker::Lorem.characters(number:16)
  			expect(notice.valid?).to eq false;
  		end
  	end
  	context 'bodyカラム' do
  		it '空欄でない' do
  			notice.body = ''
  			expect(notice.valid?).to eq false;
  		end
  		it '150文字以下である' do
  			notice.body = Faker::Lorem.characters(number:151)
  			expect(notice.valid?).to eq false;
  		end
  	end
  	context 'imageカラム' do
  		it '空欄でない' do
  			notice.image = ''
  			expect(notice.valid?).to eq false;
  		end
  	end
  end
end
