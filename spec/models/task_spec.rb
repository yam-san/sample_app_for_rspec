require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'varidation' do
    it 'is valid with all attributes' do
      task = build(:task)
      expect(task).to be_valid
      expect(task.errors).to be_empty
    end

    it 'is invalid without title' do
      task_without_title = build(:task, title: nil)
      expect(task_without_title).to be_invalid
      expect(task_without_title.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without status' do
      task_without_status = FactoryBot.build(:task, status: nil)
      expect(task_without_status).to be_invalid
      expect(task_without_status.errors[:status]).to include("can't be blank")
    end

    it 'is invalid with a duplicate title' do
      create(:task)
      task_with_duplicate_title = build(:task)
      expect(task_with_duplicate_title).to be_invalid
      expect(task_with_duplicate_title.errors[:title]).to include("has already been taken")
    end

    it 'is valid with another title' do
      create(:task)
      task_with_another_title = build(:task, title: 'hoge')
      expect(task_valid_with_another_title).to be_valid
      expect(task_valid_with_another_title.errors[:title]).to_not include("has already been taken")
    end
  end
end
