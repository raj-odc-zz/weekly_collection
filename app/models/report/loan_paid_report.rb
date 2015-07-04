require 'prawn'
require 'prawn/table'
module Report
class LoanPaidReport

    def print_report(loan)
      pdf = header loan

      data = []
        data[0] = ["Date","Amount"]

        loan.daily_collections.each_with_index do |daily_collection,i|
          data[i+1] = [daily_collection.date_with_name, daily_collection.amount]
        end


      pdf.move_down 110

      pdf.table(data) do |t|
        t.style(t.row(0), :background_color => '0075C9')
        t.header = true
      end

      pdf.number_pages "page <page> of <total>", { :at => [pdf.bounds.right - 150, 0], width: 150, align: :right, page_filter: (1..50), start_count_at: 1, color: "002B82" }
      pdf
    end

    def header(loan)
      pdf = Prawn::Document.new
      pdf.font_size = 12
      pdf.draw_text "Printed on: #{Date.today.strftime('%d-%m-%Y')}", at: [0, 670]

      pdf.draw_text "Page 1", at: [480, 670]

      pdf.draw_text "Customer Name: #{loan.customer.name_location}", at: [0, 640]
      pdf.draw_text "Loan Given date: #{loan.given_date.strftime('%d-%m-%Y')}", at: [0, 620]
      pdf.draw_text "Loan Amount: #{loan.loan_amount}", at: [0, 600]
      pdf.draw_text "Loan Paid Amount: #{loan.paid_amount}", at: [0, 580]
      pdf.draw_text "Balance Amount: #{loan.balance_amount}", at: [0, 540]
      pdf.move_down 110
      pdf.draw_text "Total Records : #{loan.daily_collections.size}", at: [450, 620]

      pdf
    end

end
  end
