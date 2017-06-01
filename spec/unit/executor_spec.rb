# frozen_string_literal: true

describe Robotoy::Executor do
  describe 'without arguments' do
    it 'should output help' do
      allow(ARGF).to receive(:read).and_return('')
      expect(described_class.execute).to be_equal(described_class::HELP_STRING)
    end
  end

  describe 'with arguments' do
    it 'should return help if --help or -? is provided' do
      expect(described_class.execute(STDIN, ['--help'])).to be_equal(described_class::HELP_STRING)
      expect(described_class.execute(STDIN, ['-?'])).to be_equal(described_class::HELP_STRING)
    end

    it 'should take input from file' do
      allow(File).to receive(:read).once.and_call_original
      expect_any_instance_of(Robotoy::Robot).to receive(:process).once
      described_class.execute(STDIN, [File.expand_path('../../fixtures/input01.txt', __FILE__)])
    end

    it 'should take input from STDIN' do
      allow(ARGF).to receive(:read).and_return('REPORT')
      expect_any_instance_of(Robotoy::Robot).to receive(:process).with(['REPORT']).once
      described_class.execute
    end
  end
end
