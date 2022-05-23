require 'rails_helper'

RSpec.describe QFavorite, type: :model do
  let(:question) { FactoryBot.create(:question) }
  let(:q_favorite) { FactoryBot.create(:q_favorite, question_id: question.id) }

  it 'お気に入りに登録された質問を取得' do
    expect(q_favorite.question.q_title).to eq question.q_title
    expect(q_favorite.question.q_content).to eq question.q_content
  end
end
