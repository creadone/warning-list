require "uri"
require "open-uri"
require "nokogiri"
require "tempfile"
require "roo"

SITE        = "https://www.cbr.ru"
SOURCE_PAGE = URI.join(SITE, "inside/warning-list")
TARGET_LINK = "a.b-export_button"
TMP_FILE    = Tempfile.new(['list', '.xlsx'], binmode: true)
TARGET_CSV  = "./data/list.csv"

doc = Nokogiri::HTML.parse(URI.open(SOURCE_PAGE))
relative_path = doc.css(TARGET_LINK).attribute('href').value
download_url  = URI.join(SITE, relative_path)

URI.open(download_url) do |xlsx|
  File.open(TMP_FILE, "wb") do |file|
    file.write(xlsx.read)
  end
end

if File.exists?(TMP_FILE)
  xlsx = Roo::Spreadsheet.open(TMP_FILE)
  File.open(TARGET_CSV, "w") do |io|
    io << xlsx.sheet(xlsx.sheets.first).to_csv
  end
  TMP_FILE.unlink
  puts "Done. #{TARGET_CSV}"
else
  raise Exception.new("Not found source file")
end