require "uri"
require "open-uri"
require "nokogiri"
require "tempfile"
require "roo"

SITE        = "https://www.cbr.ru"
SOURCE_PAGE = URI.join(SITE, "inside/warning-list")
TARGET_LINK = "a.b-export_button"
TMP_FILE    = Tempfile.new(['list', '.xlsx'], binmode: true)
FULL_CSV    = "./data/full.csv"
SITE_CSV    = "./data/sites.csv"

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

  File.open(FULL_CSV, "w") do |io|
    io << xlsx.sheet(xlsx.sheets.first).to_csv
  end

  site_column = xlsx.column(5)
  sites = site_column.compact
                .map{|row| row.split(/[\,,;]/).map(&:strip) }
                .flatten.uniq.sort.join("\n")

  File.open(SITE_CSV, "w") do |io|
    io << sites
  end

  TMP_FILE.unlink
  puts "#{FULL_CSV} & #{SITE_CSV} updated"
else
  raise Exception.new("Not found source file")
end