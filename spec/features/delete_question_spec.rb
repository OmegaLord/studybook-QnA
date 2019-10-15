require 'rails_helper'

RSpec.describe 'DeleteQuestions', type: :feature do
  describe 'User deletes question' do
    let(:user) { create(:user) }
    let(:questions) { create_list(:question, 5) }
    let(:question_to_delete) { questions.last }

    context 'when registered user' do
      before do
        sign_in(user)
        visit question_path(question_to_delete)
      end

      it 'has delete button' do
        expect(page).to have_link 'Delete'
      end

      it 'redirect to questions' do
        click_on 'Delete'
        expect(page).to have_current_path(questions_path)
      end

      it 'deletes question form list of questions' do
        click_on 'Delete'
        expect(page).not_to have_content question_to_delete.title
      end
    end

    context 'when non-registered user' do
      it 'has not button to delete question' do
        visit question_path(question_to_delete)
        expect(page).not_to have_content('Delete')
      end
    end
  end
end