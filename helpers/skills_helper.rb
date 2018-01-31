require "faraday"

module SkillsHelper

  def languages
    @languages ||= begin
      conn = Faraday.new("https://api.github.com/")
      res = conn.post do |req|
        req.url '/graphql'
        req.headers['Authorization'] = "Bearer #{ENV["GITHUB_TOKEN"]}"
        req.headers['Accept'] = 'application/json'
        query = <<~graphql
          {
            user(login: "jwaldrip") {
              repositoriesContributedTo(first: 100, orderBy: { field: PUSHED_AT, direction: DESC }) {
                nodes {
                  languages(first: 1) {
                    nodes {
                      name
                    }
                  }
                }
              }
            }
          }
        graphql
        req.body = JSON.dump({ query: query })
      end
      JSON.parse(res.body)['data']['user']['repositoriesContributedTo']['nodes'].flat_map do |r|
        r['languages']['nodes'].map do |l|
          l['name']
        end
      end.uniq.sort
    end
  end

end
