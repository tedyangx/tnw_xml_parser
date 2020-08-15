require "uri"
require "nokogiri"
require "open-uri"

class TnwXmlParser

  attr_reader :xml_url, :xml_doc, :prefix

  def initialize(xml_url)
    validate_xml_url(xml_url)

    @xml_url = xml_url
  end

  def read_data
    @xml_doc = Nokogiri::XML(open(@xml_url)) do |config|
      config.strict.noblanks
    end

    if @xml_doc.css("infoTable").size > 0
      @prefix = ""
    elsif @xml_doc.css("n1:infoTable").size > 0
      @prefix = "n1:"
    else
      raise "infoTable missing from the XML"
    end
    
    @xml_doc
  end

  def convert_to_hash
    raise "Please read_data first before converting to json" if xml_doc.nil?
    result = {}
    xml_doc.css("#{prefix}infoTable").each do |info_table|
      cusip = info_table.children.find { |ele| ele.name == "cusip" }.content.upcase
      if result[cusip].nil?
        result[cusip] = {}
        result[cusip]["cusip"] = cusip
        result[cusip]["nameOfIssuer"] = info_table.children.find { |ele| ele.name == "nameOfIssuer" }.content
        result[cusip]["value"] = info_table.children.find { |ele| ele.name == "value" }.content.to_i
        result[cusip]["shrsOrPrnAmt"] = info_table.children.find { |ele| ele.name == "shrsOrPrnAmt" }.children[0].content.to_i
        result[cusip]["shrsOrPrnAmt type"] = info_table.children.find { |ele| ele.name == "shrsOrPrnAmt" }.children[1].content
        result[cusip]["putCall"] = info_table.children.find { |ele| ele.name == "putCall" }&.content
      else
        result[cusip]["value"] += info_table.children.find { |ele| ele.name == "value" }.content.to_i
        result[cusip]["shrsOrPrnAmt"] += info_table.children.find { |ele| ele.name == "shrsOrPrnAmt" }.children[0].content.to_i
      end
    end
    result
  end

  private

  def validate_xml_url(url_string)
    uri = URI.parse(url_string)
    raise ArgumentError.new("Url must be from www.sec.gov") if uri.host != "www.sec.gov"
    raise ArgumentError.new("Url must ends with .xml") if !uri.path.end_with?(".xml")
  end
end
