require 'yaml'

module ResumeHelper

  def render_jobs
    Dir['data/resume/jobs/*.yml']
    .map { |f| load_job f }
    .sort_by { |p| p[:end_date] }
    .reverse
    .map { |p| render 'resume/_position', p }
    .join("\n")
  end

  def render_job(name)
    render 'resume/_position', load_job("data/resume/jobs/#{name}.yml")
  end

  def load_job(file)
    YAML.load_file(file).symbolize_keys.tap do |locals|
      [:start_date, :end_date].each do |f|
        locals[f] = Chronic.parse(locals[f]) if locals[f].present?
      end
    end
  rescue
    binding.pry
  end

end