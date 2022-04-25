require 'rails_helper'

RSpec.feature "Questions::New", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.create(:question) }

  before do
    sign_in user
    visit new_question_path
  end

  scenario "新規投稿(投稿)に移動" do
    within('.align-menu-bar') do
      click_link '投稿'
      expect(current_path).to eq new_post_path
    end
  end

  describe "新規質問" do
    context "新規質問成功" do
      scenario "タイトルと内容を記入" do
        fill_in "q_title", with: question.q_title
        fill_in "q_content", with: question.q_content
        click_button '質問する'
        expect(page).to have_content("質問の投稿が完了しました。")
        expect(page).to have_content question.q_title
        expect(page).to have_content question.q_content
      end
    end

    context "新規投稿失敗" do
      scenario "タイトルが未記入" do
        fill_in "q_title", with: ""
        fill_in "q_content", with: question.q_content
        click_button '質問する'
        expect(page).to have_content("タイトルを入力してください")
        expect(page).not_to have_content("内容を入力してください")
      end

      scenario "内容が未記入" do
        fill_in "q_title", with: question.q_title
        fill_in "q_content", with: ""
        click_button '質問する'
        expect(page).not_to have_content("タイトルを入力してください")
        expect(page).to have_content("内容を入力してください")
      end
    end
  end
end
