require "uri"
require "nokogiri"
require "open-uri"

class TnwXmlParser

  attr_reader :xml_url, :xml_doc

  def self.parse(xml_url)
    new(xml_url)
  end

  def initialize(xml_url)
    validate_xml_url(xml_url)

    @xml_url = xml_url
    @xml_doc = Nokogiri::HTML(open(@xml_url))
  end

  def convert_to_hash
    # to be implemented
  end

  private

  def validate_xml_url(url_string)
    uri = URI.parse(url_string)
    raise ArgumentError.new("Url must be from www.sec.gov") if uri.host != "www.sec.gov"
    raise ArgumentError.new("Url must ends with .xml") if !uri.path.end_with?(".xml")
  end
end
