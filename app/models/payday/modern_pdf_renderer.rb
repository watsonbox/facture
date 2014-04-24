module Payday
  # A more modern looking implementation of the Payday PdfRenderer
  class ModernPdfRenderer < PdfRenderer
    def font_size
      @font_size || 10
    end

    def font
      @font || {
        "Museo Sans" => {
          normal: "#{Rails.root}/vendor/assets/stylesheets/museosans_500.ttf",
          bold: "#{Rails.root}/vendor/assets/stylesheets/museosans_500.ttf"
        }
      }
    end

    def colors
      {
        text: "444444",
        heading: "707090",
        subtle: "9A9A9A",
        table_border: "E5E5E5"
      }
    end

    def render_header
      fill_color colors[:text]

      float do
        text t('invoice.invoice').upcase, size: 32, align: :right, color: colors[:heading]
        text invoice.invoice_number.to_s, align: :right, size: 12

        move_down 6
        text invoice.date.strftime(Payday::Config.default.date_format), align: :right
      end

      text Payday::Config.default.company_name, size: 20
      text Payday::Config.default.company_details, size: 8, color: colors[:subtle]

      move_down 20
      text t('invoice.client').upcase, color: colors[:heading]

      move_down 6
      text invoice.client_name_and_address

      move_down 30
    end

    def render_line_items_table
      colors = self.colors
      table line_items_table_data, width: bounds.width, header: true do
        cells.size = 10
        cells.borders = []

        row(0).padding_bottom = 12
        row(0).padding_top = 12
        row(1).padding_bottom = 0
        row(1).padding_top = 12
        row(2..-1).padding_bottom = 0
        row(2..-1).padding_top = 12
        row(0).borders = [:bottom]
        row(0).border_width = 2
        row(0).border_color = colors[:table_border]
        row(0).text_color = colors[:heading]

        column(1).width = 60
        column(2).width = 60
        column(3).width = 80
        columns(1..-1).align = :right

        row(-1).borders = [:bottom]
        row(-1).border_width = 2
        row(-1).border_color = colors[:table_border]
        row(-1).padding_bottom = 12
      end

      move_down 30
    end

    def render_totals_table
      colors = self.colors
      font_size = self.font_size

      table(totals_table_data, cell_style: { borders: [], valign: :center }, position: :right) do
        columns(0).font_style = :bold
        columns(0).text_color = colors[:heading]
        columns(1).align = :right
        columns(-1).rows(-1).size = 20
      end

      text t('invoice.payable_details', date: (invoice.date + 1.month).strftime(Payday::Config.default.date_format)),
        align: :right, color: colors[:subtle]
    end

    private

    # Allows direct use of Prawn PDF DSL
    def method_missing(method, *args, &block)
      @pdf.send(method, *args, &block)
    end

    def respond_to_missing?(method, include_private = false)
      @pdf.respond_to?(method) || super
    end
  end
end
