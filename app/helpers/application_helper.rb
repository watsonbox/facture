module ApplicationHelper
  # Outputs certain Figaro configuration vars to the client
  def javascript_configuration
    white_list = ['redmine_url', 'redmine_api_key', 'default_currency', 'reference_format']
    config = white_list.each_with_object({}) do |key, hash|
      hash[key] = Figaro.env.send(key)
    end

    javascript_tag "Facture.config = #{config.to_json};"
  end
end
