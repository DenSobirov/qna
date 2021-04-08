require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'POST #create' do
    sign_in_user
    let(:answer) { create(:answer) }
    context 'with valid attributes' do
      it 'save the new answer to the db' do
        answer
        expect do
          post :create, #question_answers_path(answer),
               params: { answer: attributes_for(:answer).merge(answer_id: answer.id) }.merge(question_id: answer.question.id, format: :js)
        end.to change(Answer, :count).by(1)
      end

      # it 'redirect to show' do
      #   post :create,
      #        params: { answer: attributes_for(:answer).merge(id: answer.id) }.merge(question_id: answer.question.id, format: :js)
      #   expect(response).to redirect_to question_path(answer.question)
      # end
    end

    context 'with invalid attributes' do
      it 'does not save the new question to the db' do
        answer
        expect { post :create, params: {answer: attributes_for(:invalid_answer)}.merge(question_id: answer.question.id, format: :js) }.to_not change(Answer, :count)
      end
    end
  end
end
