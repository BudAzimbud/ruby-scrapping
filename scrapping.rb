require 'nokogiri'
require 'open-uri'
require 'csv'
require 'json'

db = []


URL = 'https://www.indotrading.com/company/1'
URL2 = 'https://www.indotrading.com/company/2'

$j = 0
while $j <= 10 do
    doc = Nokogiri::HTML(URI.open("https://www.indotrading.com/company/#$j"))
    doc.css("#catcom-container").map do | element |
        db.push([
            element.at(".span-bold span").text.strip,
            element.at("div.mt-1.mb-1.fs-12").text.strip,
            element.at("div.fs-12.color-grey-1 > span").text.strip,
            element.at("p.d-flex.a-center").text.strip,
            element.at("div.d-flex.mt-10 > div > p").text.strip,
            element.at(".text-verified").text.strip,
            element.at(".section_layout_product > div").text.strip,
            element.at(".span-bold span").text.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '').strip
        ])

    end
    $j=$j+1
end



CSV.open("file.csv","w") do |csv|
    csv << ["company_name", "last_online","status_pajak", "rate", "address", "verified?", "supplier", "slug"]
    i = 0
    while i <= db.length() do
        puts db[i]
        csv << db[i-1]
    i=i+1
    end
end