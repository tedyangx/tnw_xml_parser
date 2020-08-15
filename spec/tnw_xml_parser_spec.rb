RSpec.describe TnwXmlParser do
  it "raises ArgumentError if host is not sec.gov" do
    expect do
      parser = TnwXmlParser.new("https://google.com/asdf.xml")
    end.to raise_error(ArgumentError)
  end

  it "raises ArgumentError if not xml link" do
    expect do
      parser = TnwXmlParser.new("https://google.com/asdf.xml")
    end.to raise_error(ArgumentError)
  end

  it "does not raise ArgumentError" do
    expect do
      parser = TnwXmlParser.new("https://www.sec.gov/Archives/edgar/data/1067983/000095012320005345/form13fInfoTable.xml")
    end.to_not raise_error
  end

  it "can read the xml data as a Nokogiri::XML::Document" do
    parser = TnwXmlParser.new("https://www.sec.gov/Archives/edgar/data/1067983/000095012320005345/form13fInfoTable.xml")
    parser.read_data
    expect(parser.xml_doc).to be_an_instance_of(Nokogiri::XML::Document)
  end

  it "raises error if the XML has no infoTable" do
    parser = TnwXmlParser.new("https://www.sec.gov/Archives/edgar/data/813917/000081391720000038/primary_doc.xml")
    expect do
      parser.read_data
    end.to raise_error(/infoTable missing/)
  end

  it "converts to hash" do
    parser = TnwXmlParser.new("https://www.sec.gov/Archives/edgar/data/1067983/000095012320005345/form13fInfoTable.xml")
    parser.read_data
    parser.convert_to_hash
  end
end
