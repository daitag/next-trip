require 'rails_helper'

describe 'ユーザ認証のテスト' do
	describe 'ユーザ新規登録' do
		before do
			visit new_user_registration_path
		end
		context '新規登録画面に遷移' do
			it '新規登録に成功する' do
				fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
				fill_in 'user[email]', with: Faker::Internet.email
				fill_in 'user[password]', with: 'password'
				fill_in 'user[password_confirmation]', with: 'password'
				click_button 'Sign up'

				expect(page).to have_content 'アカウント登録が完了しました'
			end
			it '新規登録に失敗する' do
				fill_in 'user[name]', with: ''
				fill_in 'user[email]', with: ''
				fill_in 'user[password]', with: ''
				fill_in 'user[password_confirmation]', with: ''
				click_button 'Sign up'

				expect(page).to have_content 'エラー'
			end
		end
	end
	describe 'ユーザログイン' do
		let(:user) { create(:user) }
		before do
			visit new_user_session_path
		end
		context 'ログイン画面に遷移' do
			let(:test_user) { user }
			it 'ログインに成功' do
				fill_in 'user[email]', with: test_user.email
				fill_in 'user[password]', with: test_user.password
				click_button 'Log in'

				expect(page).to have_content 'ログインしました。'
			end

			it 'ログインに失敗' do
				fill_in 'user[email]', with: ''
				fill_in 'user[password]', with: ''
				click_button 'Log in'

				expect(page).to have_content 'メールアドレス もしくはパスワードが不正です。'
			end
		end
	end

	describe 'ユーザのテスト' do
		let(:user) { create(:user) }
		let(:test_user2) { create(:user) }
		let(:post) { create(:post, user: user) }
		before do
			visit new_user_session_path
			fill_in 'user[email]', with: user.email
			fill_in 'user[password]', with: user.password
			click_button 'Log in'
		end
		describe '編集のテスト' do
			context '自分の編集画面の遷移' do
				it '遷移ができる' do
					visit edit_user_path(user)
					expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
				end
			end
			context '他人の編集画面に遷移できない' do
				it '遷移できない' do
					visit edit_user_path(test_user2)
					expect(current_path).to eq('/users/' + user.id.to_s)
				end
			end
			context '表示の確認' do
				before do
					visit edit_user_path(user)
				end
				it 'マイページと表示される' do
					expect(page).to have_content('マイページ')
				end
				it '名前フォームに名前が表示される' do
					expect(page).to have_field 'user[name]', with: user.name
				end
				it '画像フォームが表示される' do
					expect(page).to have_field 'user[image]'
				end
				it '編集に成功する' do
					click_button '編集する'
					expect(page).to have_content 'ユーザ情報を更新しました'
					expect(current_path).to eq('/users/' + user.id.to_s)
				end
				it '名前の編集失敗する' do
					fill_in 'user[name]', with: ''
					click_button '編集する'
					expect(page).to have_content '名前は2文字以上に設定して下さい。'
				end
				it '名前の編集失敗する' do
					fill_in 'user[email]', with: ''
					click_button '編集する'
					expect(page).to have_content 'メールアドレスが入力されていません。'
				end
			end
		end
	end
end