# frozen_string_literal: true

describe Robotoy::Robot do
  describe 'order of commands' do
    it 'should ignore all commands before PLACE' do
      expect(described_class.new.process(%w[REPORT MOVE LEFT])).to eq('')
    end

    it 'should accept PLACE command and set position' do
      expect(described_class.new.process(['PLACE 0,0,NORTH', 'REPORT'])).to eq('0,0,NORTH')
    end

    it 'should ignore case of commands' do
      expect(described_class.new.process(['place 0,0,north', 'report'])).to eq('0,0,NORTH')
    end
  end

  describe 'placement' do
    it 'should not place robot out of bounds' do
      expect(described_class.new.process(['PLACE -1,0,NORTH', 'REPORT'])).to eq('')
    end

    it 'should ignore wrong facing' do
      expect(described_class.new.process(['PLACE 0,1,UP', 'REPORT'])).to eq('')
    end

    it 'should process PLACE after PLACE correctly' do
      expect(described_class.new.process(['PLACE 0,1,NORTH', 'PLACE 0,1,SOUTH', 'REPORT'])).to eq('0,1,SOUTH')
    end
  end

  describe 'rotation' do
    it 'should be able to rotate counter-clockwise (left)' do
      expect(described_class.new.process(['PLACE 0,0,NORTH', 'LEFT', 'REPORT'])).to eq('0,0,WEST')
      expect(described_class.new.process(['PLACE 0,0,WEST', 'LEFT', 'REPORT'])).to eq('0,0,SOUTH')
      expect(described_class.new.process(['PLACE 0,0,SOUTH', 'LEFT', 'REPORT'])).to eq('0,0,EAST')
      expect(described_class.new.process(['PLACE 0,0,EAST', 'LEFT', 'REPORT'])).to eq('0,0,NORTH')
    end

    it 'should be able to rotate clockwise (rigth)' do
      expect(described_class.new.process(['PLACE 0,0,NORTH', 'RIGHT', 'REPORT'])).to eq('0,0,EAST')
      expect(described_class.new.process(['PLACE 0,0,EAST', 'RIGHT', 'REPORT'])).to eq('0,0,SOUTH')
      expect(described_class.new.process(['PLACE 0,0,SOUTH', 'RIGHT', 'REPORT'])).to eq('0,0,WEST')
      expect(described_class.new.process(['PLACE 0,0,WEST', 'RIGHT', 'REPORT'])).to eq('0,0,NORTH')
    end

    it 'should treat correctly sequentual turns' do
      expect(described_class.new.process(['PLACE 0,0,NORTH', 'LEFT', 'RIGHT', 'REPORT'])).to eq('0,0,NORTH')
    end
  end

  describe 'movement' do
    it 'should be able to move' do
      expect(described_class.new.process(['PLACE 0,0,NORTH', 'MOVE', 'REPORT'])).to eq('0,1,NORTH')
    end

    it 'should not be able to move outside table' do
      expect(described_class.new.process(['PLACE 0,4,NORTH', 'MOVE', 'REPORT'])).to eq('0,4,NORTH')
    end
  end
end
