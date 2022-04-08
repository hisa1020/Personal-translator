require 'rails_helper'

RSpec.describe "ApplicationHelper", type: :helper do
  describe "#full_title" do
    context "page_titleがnilの場合" do
      it "BASE_TITLEをタイトルに返す" do
        expect(helper.full_title(nil)).to eq("Personal Translator | チャット型翻訳アプリ")
      end
    end

    context "page_titleが空文字の場合" do
      it "BASE_TITLEをタイトルに返す" do
        expect(helper.full_title("")).to eq("Personal Translator | チャット型翻訳アプリ")
      end
    end

    context "page_titleがあるとき" do
      it "page_name - BASE_TITLEをタイトルに返す" do
        expect(helper.full_title(:page_name)).to eq("page_name | Personal Translator | チャット型翻訳アプリ")
      end
    end
  end
end
