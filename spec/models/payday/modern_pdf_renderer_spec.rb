require 'spec_helper'

describe Payday::ModernPdfRenderer do
  let(:invoice) { build(:invoice_with_line_items, :date => Date.parse('2014-04-24')) }
  let(:renderer) { Payday::ModernPdfRenderer.new }
  let(:output) { renderer.render(invoice) }

  describe '#render' do
    it 'correctly renders a simple invoice' do
      expect(output).to match_rendered_binary_output 'pdf/test.pdf'
    end
  end
end
