module SkillsHelper

  def languages
    %w{ruby javascript crystal go bash python}
    # @skills ||= JSON.parse(Net::HTTP.get(URI.parse 'https://osrc.dfm.io/jwaldrip.json'))['usage']['languages'].map { |l| l['language'] }
  end

end
