require 'prawn'
require 'prawn/table'
module Report
class CollectionReport

    def print_report(daily_report, date)
      pdf = header daily_report

      data = []
      if date == Date.today.strftime("%Y-%m-%d")
        data[0] = ["Customer","Mobile Number","Given date","Loan amount","Due Weeks","Balance amount","Today's amount"]
      else
        data[0] = ["Customer","Mobile Number","Given date","Loan amount","Due Weeks","Balance amount"]
      end


      if date == Date.today.strftime("%Y-%m-%d")
        daily_report.each_with_index do |daily_collection,i|
          data[i+1] = [daily_collection.loan.customer.name_location, daily_collection.loan.customer.mobile_number, \
        daily_collection.loan.given_date, daily_collection.loan.loan_amount, daily_collection.loan.due_in_weeks, \
        daily_collection.loan.balance_amount, daily_collection.amount ]
        end
      else
        daily_report.each_with_index do |daily_collection,i|
          data[i+1] = [daily_collection.loan.customer.name_location, daily_collection.loan.customer.mobile_number, \
        daily_collection.loan.given_date, daily_collection.loan.loan_amount, daily_collection.loan.due_in_weeks, \
        daily_collection.loan.balance_amount]
        end
      end


      pdf.move_down 110

      pdf.table(data) do |t|
        t.style(t.row(0), :background_color => '0075C9')
        t.header = true
      end

      pdf.number_pages "page <page> of <total>", { :at => [pdf.bounds.right - 150, 0], width: 150, align: :right, page_filter: (1..50), start_count_at: 1, color: "002B82" }
      pdf
    end

    def header(daily_report)
      pdf = Prawn::Document.new
      pdf.font_size = 12
      pdf.draw_text "Printed on: #{Date.today}", at: [0, 670]

      pdf.draw_text "Page 1", at: [480, 670]

      pdf.draw_text "Total Records : #{daily_report.size}", at: [450, 620]
      pdf
    end

end
  end
