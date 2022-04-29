require 'rails_helper'

RSpec.feature "Questions::Edit", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.create(:question) }

  before do
    sign_in user
    visit edit_question_path(question.id)
  end

  describe "質問内容を変更できる" do
    scenario "変更前の質問内容が表示されている" do
      expect(page).to have_field("q_title", with: question.q_title)
      expect(page).to have_field("q_content", with: question.q_content)
    end

    context "変更なしで質問を更新する場合" do
      scenario "元の質問を表示" do
        click_button '質問内容を更新'
        expect(current_path).to eq question_path(question.id)
        expect(page).to have_content("質問内容を更新しました。")
        expect(page).to have_content question.q_title
        expect(page).to have_content question.q_content
      end
    end

    context "タイトルを更新する場合" do
      scenario "新しいタイトルを表示" do
        fill_in "q_title", with: "New-Test-Question-Title"
        click_button '質問内容を更新'
        expect(current_path).to eq question_path(question.id)
        expect(page).to have_content("質問内容を更新しました。")
        expect(page).to have_content("New-Test-Question-Title")
        expect(page).to have_content question.q_content
      end

      scenario "タイトルを更新できず(空白)" do
        fill_in "q_title", with: ""
        click_button '質問内容を更新'
        expect(page).to have_content("タイトルを入力してください")
      end
    end

    context "内容を更新する場合" do
      scenario "新しい内容を表示" do
        fill_in "q_content", with: "New-Test-Question-Content"
        click_button '質問内容を更新'
        expect(current_path).to eq question_path(question.id)
        expect(page).to have_content("質問内容を更新しました。")
        expect(page).to have_content question.q_title
        expect(page).to have_content("New-Test-Question-Content")
      end

      scenario "内容を更新できず(空白)" do
        fill_in "q_content", with: ""
        click_button '質問内容を更新'
        expect(page).to have_content("内容を入力してください")
      end
    end
  end
end
