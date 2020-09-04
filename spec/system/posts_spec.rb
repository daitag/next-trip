require 'rails_helper'

describe '投稿のテスト' do
	let(:user) { create(:user) }
	let(:user2) { create(:user) }
	let(:post) { create(:post, user: user) }
	let(:post2) { create(:post, user: user2) }
	before do
		visit new_user_session_path
		fill_in 'user[email]', with: user.email
		fill_in 'user[password]', with: user.password
		click_button 'Log in'
	end
	describe '投稿のテスト' do
		context '表示の確認' do
			before do
				visit new_post_path
			end
			it '投稿ページが表示される' do
				expect(page).to have_content '新規投稿'
			end
			it '投稿に成功する' do
				fill_in 'post[title]', with: Faker::Lorem.characters(number:10)
				fill_in 'post[location]', with: Faker::Lorem.characters(number:10)
				select 'JP', from: 'post[country]',match: :first
				click_button '投稿する'
				expect(page).to have_content '投稿できました'
			end
		end
	end
end