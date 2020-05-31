require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))

    students = []
    page.css(".student-card").each do |student|
      hash = {}
      hash[:name] = student.css(".student-name").text
      hash[:location] = student.css(".student-location").text
      hash[:profile_url] = student.css("a").attribute("href").value
      students.push(hash)
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    

    binding.pry
  end

end


Scraper.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")