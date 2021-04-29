require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'varidation' do
    it 'is valid with all attributes' do
      task = build(:task)
      expect(task).to be_valid
      expect(task.errors).to be_empty
    end

    it 'is invalid without title' do
      task = build(:task, title: nil)
      expect(task).to be_invalid
      expect(task.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without status' do
      task = FactoryBot.build(:task, status: nil)
      expect(task).to be_invalid
      expect(task.errors[:status]).to include("can't be blank")
    end

    it 'is invalid with a duplicate title' do
      create(:task)
      task = build(:task)
      expect(task).to be_invalid
      expect(task.errors[:title]).to include("has already been taken")
    end

    it 'is valid with another title' do
      create(:task)
      task = build(:task, title: 'hoge')
      expect(task).to be_valid
      expect(task.errors[:title]).to_not include("has already been taken")
    end
    #"User must exist"
  end
end
