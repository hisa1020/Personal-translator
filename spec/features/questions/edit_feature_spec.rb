require 'rails_helper'
require 'spec_helper'

RSpec.feature "Questions::Edit", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.create(:question) }

  before do
    sign_in user
    visit edit_question_path(question.id)
  end

  describe "質問内容を変更" do
    scenario "変更前の質問内容が表示される" do
      expect(page).to have_field("q_title", with: question.q_title)
      expect(page).to have_field("q_content", with: question.q_content)
    end

    context "質問内容の変更成功" do
      scenario "タイトル、内容を変更できる" do
        fill_in "q_title", with: "New-Test-Question-Title"
        fill_in "q_content", with: "New-Test-Question-Content"
        click_button '質問内容を更新'
        expect(page).to have_content("質問内容を更新しました。")
      end

      scenario "変更なしで質問を更新できる" do
        click_button '質問内容を更新'
        expect(page).to have_content("質問内容を更新しました。")
        expect(page).to have_content question.q_title
        expect(page).to have_content question.q_content
      end

      scenario "タイトルのみを変更できる" do
        fill_in "q_title", with: "New-Test-Question-Title"
        click_button '質問内容を更新'
        expect(page).to have_content("質問内容を更新しました。")
        expect(page).to have_content("New-Test-Question-Title")
      end

      scenario "内容のみを変更できる" do
        fill_in "q_content", with: "New-Test-Question-Content"
        click_button '質問内容を更新'
        expect(page).to have_content("質問内容を更新しました。")
        expect(page).to have_content("New-Test-Question-Content")
      end
    end

    context "質問内容の変更成功" do
      scenario "タイトルが空だと更新失敗" do
        fill_in "q_title", with: ""
        click_button '質問内容を更新'
        expect(page).to have_content("タイトルを入力してください")
      end

      scenario "内容が空だと更新失敗" do
        fill_in "q_content", with: ""
        click_button '質問内容を更新'
        expect(page).to have_content("内容を入力してください")
      end
    end
  end
end
