require 'date'

IS_DRY_RUN = false
#IS_DRY_RUN = true
FOLDER = "_posts"

Dir.glob(FOLDER + '/**').select{ |e| File.file?(e) }.each do |file|


  file = file.gsub("#{FOLDER}/", '')
  temp = file[0,10]

  #unless temp.match(/2022-07|2022-08|2022-09/)
  #  next
  #end
  puts "=== temp: #{temp}"

  date = Date.strptime temp, "%Y-%m-%d"
  hour = rand(12) + 8
  minute = rand(59)
  second = rand(59)
  git_date_time = "#{date.strftime("%d %b %Y")} #{hour}:#{minute}:#{second}"
  puts "--- file: #{file}"
  puts "git_date_time: #{git_date_time}"

  #git_command = %Q{GIT_COMMITTER_DATE="2 Mar 2022 20:19:19" git commit --amend --no-edit --date "2 Mar 2022 20:19:19 "}
  #git_command = %Q{GIT_COMMITTER_DATE="#{git_date_time}" git commit --amend --no-edit --date "git_date_time"}
  commit_command = %Q{git add "#{FOLDER}/#{file}" && git commit -m "add blog"}
  amend_command = %Q{GIT_COMMITTER_DATE="#{git_date_time}" git commit --amend --no-edit --date "#{git_date_time}"}
  puts "commit_command: #{commit_command}"
  puts "amend_command: #{amend_command}"

  unless IS_DRY_RUN
    `#{commit_command}`
    `#{amend_command}`
  end

  puts "=== this is a dry run" if IS_DRY_RUN

  sleep 0
end


