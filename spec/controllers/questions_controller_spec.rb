RSpec.describe QuestionsController, type: :controller do
  let(:valid_params) { {} }
  let(:valid_session) { {} }
  let(:question) { create(:question) }

  describe 'GET #index' do
    before { get :index }

    let(:questions) { create_list(:question, 5) }

    it 'render index template' do
      expect(response).to render_template :index
    end

    it 'populates an array of all question' do
      expect(assigns(:questions)).to match_array questions
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assigns requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'render show template' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new Question
    end

    it 'render new template' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: question } }

    it 'assigns a requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'render edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'save valid question' do
        expect do
          post :create, params: { question: attributes_for(:question) }
        end
          .to change(Question, :count).by(1)
      end

      it 'redirects to show view ' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'not save invalid question' do
        expect do
          post :create, params: { question: attributes_for(:question_invalid) }
        end
          .not_to change(Question, :count)
      end

      it 're-render new template' do
        post :create, params: { question: attributes_for(:question_invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      let(:new_attributes) { { title: Faker::Lorem.question, body: Faker::Lorem.question } }

      before { patch :update, params: { id: question, question: new_attributes } }

      it 'assigns a requested question to @question' do
        expect(assigns(:question)).to eq question
      end

      it 'changes question title' do
        question.reload
        expect(question.title).to eq new_attributes[:title]
      end

      it 'changes question body' do
        question.reload
        expect(question.body).to eq new_attributes[:body]
      end

      it 'redirect to the updated question' do
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: question, question: attributes_for(:question_invalid) } }

      it 'do not changes question' do
        reloaded_question = question.reload
        expect(reloaded_question).to eq question
      end

      it 'redirect to the updated question' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { question }

    it 'deletes question' do
      expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
    end

    it 'redirect to the index template' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end
  end
end