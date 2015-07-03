module LoansHelper
  def check_for_value(row_id)
    row_id == nil ? :blank : row_id.value
  end

  def check_for_params(params)
    params == nil ? :blank : params[:search_day]
  end
end
