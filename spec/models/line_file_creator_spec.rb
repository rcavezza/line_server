require "rails_helper"

RSpec.describe Line, :type => :model do
  describe '#exist?' do
    it 'line does not exist' do
      line = Line.new(999999999999)
      expect(line.exist?).to eq(false)
    end

    it 'line exists and creates pstore record' do 
      line = Line.new(4)
      expect(line.exist?).to eq(true)
    end
  end

  describe '#text' do
    it 'line does not exist' do
      id = 99999999999999
      line = Line.new(id)
      expect(line.text).to be_falsey

      cached_ids = PStore.new('lines.pstore')
      cached_ids.transaction(true) do
        expect(cached_ids[id]).to be_nil
      end
    end

    it 'line exists in file creates pstore cache' do 
      id = 4
      line = Line.new(id)
      expect(line.text).to eq('parablast please enigmatically hearthwarming psithurism ecphore organophonic airdrome phlegmatically mealable')

      cached_ids = PStore.new('lines.pstore')
      cached_ids.transaction(true) do
        expect(cached_ids[id]).not_to be_nil
      end
    end
  end
end