# Defines custom matchers for comparing renderer output with binary or text expectations

require 'fileutils'

# Usage: expect(renderer.render).to match_rendered_output('pdf/test.pdf')
RSpec::Matchers.define(:match_rendered_output) do |file_name|
  match do |actual_output|
    expected_path = File.join('spec/assets/renderers', file_name)
    expected_output = File.read(expected_path)

    actual_output == expected_output
  end

  failure_message do |actual_output|
    "expected output to match '#{File.join('spec/assets/renderers', file_name)}'"
  end

  diffable
end

# Usage: expect(renderer.render).to match_rendered_binary_output('pdf/test.pdf')
RSpec::Matchers.define(:match_rendered_binary_output) do |file_name|
  match do |actual_output|
    expected_path = File.join('spec/assets/renderers', file_name)
    expected_output = File.binread(expected_path)

    (actual_output == expected_output).tap do |result|
      unless result
        output_path = File.join('tmp/rendered_output', file_name)

        FileUtils.mkdir_p(File.dirname(output_path))
        File.open(output_path, "wb") { |f| f.write actual_output }
      end
    end
  end

  failure_message do |actual_output|
    expected_output_path = File.join('spec/assets/renderers', file_name)
    actual_output_path = File.join('tmp/rendered_output', file_name)

    "expected output to match '#{expected_output_path}' (see #{actual_output_path})"
  end
end
