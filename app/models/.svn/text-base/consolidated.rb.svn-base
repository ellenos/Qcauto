require 'mysql'

class Consolidated < ActiveRecord::Base
	
	def self.con_status(dbname)
		array = Array.new
		ret = ""
		retall = ""
		con = Mysql.new 'prod-aqcdb102', 'ODBC', 'ODBC'
		results = con.query("SELECT * FROM qa.LOG L where L.DETAILS like '%DB: " + dbname + "' ORDER BY keyname DESC LIMIT 1")
		numRows = results.num_rows
		numRows.times do
			record = results.fetch_hash
			lognum = record["lognum"]
			puts lognum
			unless lognum.nil?
				res2 = con.query("SELECT * from qa.LOG L where L.DETAILS like '%DB: " + dbname + "' AND L.lognum = " + lognum)
				numR = res2.num_rows
				numR.times do
					rec2 = res2.fetch_hash
					dbcode = rec2["DBCode"]
					res3 = con.query("SELECT * FROM qa.LOG L where L.DBCode = '" + dbcode + "' AND L.lognum = " + lognum)
					numR3 = res3.num_rows
					
					numR3.times do
						rec3 = res3.fetch_hash
						#ret = rec3['STATUS'] + " " + rec3['STEPNAME'] + " " + rec3['EXPECTED'] + "<br/>"
						array.push rec3
					end
				end
			end
		end
		con.close
		return array
	end
end
