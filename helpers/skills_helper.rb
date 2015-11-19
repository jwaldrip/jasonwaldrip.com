module SkillsHelper

  def languages
    %w{ruby ecjavascript crystal go bash python terraform}
    # @skills ||= JSON.parse(Net::HTTP.get(URI.parse 'https://osrc.dfm.io/jwaldrip.json'))['usage']['languages'].map { |l| l['language'] }
  end

end
