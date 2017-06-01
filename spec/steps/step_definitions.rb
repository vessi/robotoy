step 'I am a robot' do
  @robot = Robotoy::Robot.new
  @out = []
end

step 'I receive command :command' do |command|
  @out << @robot.process([command])
  @out.reject!(&:empty?)
end

step 'I out :expectation' do |expectation|
  output = @out.compact.join("\n")
  sample = expectation == 'nothing' ? '' : expectation
  expect(output).to eq(sample)
end
