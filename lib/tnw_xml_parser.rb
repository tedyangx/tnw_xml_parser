require "uri"

class TnwXmlParser

  def initialize(xml_url:)
    validate_xml_url(xml_url)

    @xml_url = xml_url
  end

  def parse
    # to be implemented
  end

  private

  def validate_xml_url(url_string)
    uri = URI.parse(url_string)
    raise ArgumentError.new("Url must be from www.sec.gov") if uri.host != "www.sec.gov"
    raise ArgumentError.new("Url must ends with .xml") if !uri.path.end_with?(".xml")
  end
end
