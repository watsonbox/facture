module ApplicationHelper
  # Outputs certain Figaro configuration vars to the client
  def javascript_configuration
    white_list = 'redmine_url'
    javascript_tag "Facture.config = #{Figaro.env.slice(white_list).to_json};"
  end
end
