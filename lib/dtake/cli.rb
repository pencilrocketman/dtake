#! /usr/bin/env ruby

require 'dtake'
require 'thor'

module Dtake
  class CLI < Thor
		desc "ls", "show all files on list.html." # コマンドの使用例と、概要
		def ls()
			list_url = "https://web.sfc.keio.ac.jp/~takefuji/list.html" 
			doc = Nokogiri::HTML(open(list_url))
			doc.inner_text.split("\n").each do |line|
				next if (line == "") #空行は無視
				
				puts line
			end
		end
		
		desc "d filename", "download file on the server." # コマンドの使用例と、概要
		def d(filename)
			command = "wget https://web.sfc.keio.ac.jp/~takefuji/" + filename
			system(command)
		end

		desc "find query", "search files by filename." # コマンドの使用例と、概要
		option :aliases => "f"
		def find(q)
			list_url = "https://web.sfc.keio.ac.jp/~takefuji/list.html" 
			doc = Nokogiri::HTML(open(list_url))
			doc.inner_text.split("\n").each do |line|
				next if (line == "") #空行は無視
				
				file_name = line.split(" ").last
				if(file_name.match(q))
					puts line
				end
			end
		end

	end
end

