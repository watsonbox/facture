module ApplicationHelper
  # Outputs certain Figaro configuration vars to the client
  def javascript_configuration
    white_list = ['redmine_url', 'redmine_api_key', 'default_currency']
    javascript_tag "Facture.config = #{Figaro.env.slice(*white_list).to_json};"
  end
end
