#! /usr/bin/env ruby

require 'dtake'
require 'thor'

module Dtake
  class CLI < Thor
		desc "ls", "show all files on list.html." # コマンドの使用例と、概要
		def ls
			list_url = "https://web.sfc.keio.ac.jp/~takefuji/list.html" 
			doc = Nokogiri::HTML(open(list_url))
			doc.inner_text.split("\n").each do |line|
				next if line == "" #空行は無視
				
				puts line
			end
		end
		
		desc "d filename", "download file on the server." # コマンドの使用例と、概要
		def d(name)
      filenames = []
      p 'hoge'
			list_url = "https://web.sfc.keio.ac.jp/~takefuji/list.html" 

			doc = Nokogiri::HTML(open(list_url))
			doc.inner_text.split("\n").each do |line|
				next if line == ""
				filename = line.split(" ").last
        filenames << filename if filename.match(/(.+)name(.+)/)
			end

      filenames.each do |filename|
        wget(name) if filename == name
        return
      end

      wget(filenames[0])
		end

		desc "find query", "search files by filename." # コマンドの使用例と、概要
		option :aliases => "f"
		def find(q)
			list_url = "https://web.sfc.keio.ac.jp/~takefuji/list.html" 
			doc = Nokogiri::HTML(open(list_url))
			doc.inner_text.split("\n").each do |line|
				next if line == "" #空行は無視
				
				file_name = line.split(" ").last
			  puts line if file_name.match(/q/)
			end
		end

    private

    def wget(name)
			command = "wget https://web.sfc.keio.ac.jp/~takefuji/" + name
      system(command)
    end

	end
end

