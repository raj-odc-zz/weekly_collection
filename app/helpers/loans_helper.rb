module LoansHelper
  def check_for_value(row_id)
    row_id == nil ? :blank : row_id.value
  end
end
