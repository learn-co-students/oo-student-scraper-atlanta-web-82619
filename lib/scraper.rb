require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    cards = doc.css(".student-card")
    cards.each do |card|
      new_card = {}
      new_card[:name] = card.css(".student-name").text
      new_card[:location] = card.css(".student-location").text
      new_card[:profile_url] = card.css("a")[0]["href"]
      students << new_card
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    attributes = {}
    doc = Nokogiri::HTML(open(profile_url))
    social_media = doc.css("div.social-icon-container a").map {|media| media.attribute('href').value}
    social_media.each do |media|
      if media.include?("twitter")
        attributes[:twitter] = media
      elsif media.include?("linkedin")
        attributes[:linkedin] = media
      elsif media.include?("github")
        attributes[:github] = media
      else
        attributes[:blog] = media
      end
    end
    attributes[:profile_quote] = doc.css(".profile-quote").text
    attributes[:bio] = doc.css(".description-holder p").text
    attributes
    # attributes = {
    #   twitter: social_media[0]["href"],
    #   linkedin: social_media[1]["href"],
    #   github: social_media[2]["href"],
    #   blog: social_media[3]["href"],
    #   profile_quote: doc.css(".profile-quote").text,
    #   bio: doc.css(".description-holder p").text
    # }
    
    # binding.pry
    
  end

end

# Scraper.scrape_profile_page("https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html")