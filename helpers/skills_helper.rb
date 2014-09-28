module SkillsHelper

  def languages
    @skills ||= JSON.parse(Net::HTTP.get(URI.parse 'https://osrc.dfm.io/jwaldrip.json'))['usage']['languages'].map { |l| l['language'] }
  end

end
