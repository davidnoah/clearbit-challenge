module ApplicationHelper
  # Generates the params validation error message
  def param_vaidation_error_message(param)
    "Parameter #{param} is required"
  end
end