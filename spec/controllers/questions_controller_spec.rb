require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before do
      get :index
    end

    # it 'populates an array of all questions' do
    #   expect(assigns(:questions)).to match_array(questions)
    # end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: question }
    end

    it 'assigns the requested question for @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new }

    it 'assigns is the new question obj' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    sign_in_user
    before { get :edit, params: { id: question } }

    it 'assigns the requested question for @question' do
      expect(assigns(:question)).to eq(question)
    end

    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'save the new question to the db' do
        expect { post :create, params: {question: attributes_for(:question)}  }.to change(Question, :count).by(1)
      end

      it 'redirect to show' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new question to the db' do
        expect { post :create, params: {question: attributes_for(:invalid_question)} }.to_not change(Question, :count)
      end

      it 're-render new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  # describe 'PATCH #update' do
  #   sign_in_user
  #   context 'with valid attributes' do
  #     it 'assigns the requested question for @question' do
  #       put question_path(question), params: { question: attributes_for(:question) }
  #       expect(assigns(:question)).to eq(question)
  #     end

  #     it 'change question attributes' do
  #       put question_path(question), params: { question: { id: question, title: 'new title', body: 'new body' } }
  #       question.reload
  #       expect(question.title).to eq 'new title'
  #       expect(question.body).to eq 'new body'
  #     end

  #     it 'redirect to the updated question' do
  #       post :update, params: { question: attributes_for(:question).merge(id: question) }
  #       expect(response).to redirect_to question
  #     end
  #   end

  #   context 'with invalid attributes' do
  #     before { patch :update, params: { question: { id: question, title: nil, body: 'new body' } } }
  #     it 'assigns the requested question for @question' do
  #       question.reload
  #       expect(question.title).to eq 'MyString'
  #       expect(question.body).to eq 'MyText'
  #     end

  #     it 're-render new view' do
  #       expect(response).to render_template :edit
  #     end
  #   end
  # end

  describe 'DELETE #destroy' do
    sign_in_user
    before { question }

    # it 'deletes question' do
    #   expect { delete :destroy, params: { question:  { id: question } } }.to change(Question, :count).by(-1)
    # end

    it 'redirect to index view' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end
  end
end
