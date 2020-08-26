require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'バリデーションのテスト' do
  	let(:schedule) { build(:schedule) }

  	context 'contentカラム' do
  		it '空欄でない' do
  			schedule.content = ''
  			expect(schedule.valid?).to eq false;
  		end
  		it '15文字以下である' do
  			schedule.content = Faker::Lorem.characters(number:16)
  			expect(schedule.valid?).to eq false;
  		end
  	end
  	context 'start_dayカラム' do
  		it '空欄でない' do
  			schedule.start_day = ''
  			expect(schedule.valid?).to eq false;
  		end
  	end
  	context 'end_dayカラム' do
  		it '空欄でない' do
  			schedule.end_day = ''
  			expect(schedule.valid?).to eq false;
  		end
  	end
  end
end
