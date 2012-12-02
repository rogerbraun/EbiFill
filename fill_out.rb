#encoding: utf-8
require "rods"
require "pry"
require "csv"
require "andand"

testdata = CSV.read("testdata.csv")

POSITIONS = {
  nationality: [17, 7],
  name: [20, 5],
  place: [26, 15],
  birthyear: [17,14],
  birthmonth: [17,17],
  birthday: [17,20],
  place_of_birth:[23,15],
  passport: [35, 8],
  expyear: [35, 16],
  expmonth: [35, 19],
  expday: [35, 22],
#  entryyear: [49, 8],
#  entrymonth: [49, 11],
#  entryday: [49, 14],
  port_of_entry:[49, 23],
  visa_place: [55, 10],
  visit_times: [61, 5],
  start_visit_year: [61,11],
  start_visit_month: [61, 13],
  start_visit_day: [61, 15],
  end_visit_year: [61, 18],
  end_visit_month: [61, 20],
  end_visit_day:  [61, 22],
  relation_1: [79,1],
  relation_1_name: [79,2],
  relation_1_birthday: [79,3],
  relation_1_nationality: [79,4],
  relation_1_employment: [79,6],
  relation_1_residence: [79,7],
  relation_2: [81,1],
  relation_2_name: [81,2],
  relation_2_birthday: [81,3],
  relation_2_nationality: [81,4],
  relation_2_employment: [81,6],
  relation_2_residence: [81,7],
  relation_3: [83,1],
  relation_3_name: [83,2],
  relation_3_birthday: [83,3],
  relation_3_nationality: [83,4],
  relation_3_employment: [83,6],
  relation_3_residence: [83,7]
}

POSITIONS_2 = {
  years_of_education: [12,22],
  graduation_year: [22, 10],
  graduation_month: [22, 12],
  graduation_day: [22, 14],
  supporter_name: [69,7],
  supporter_address: [71, 7],
  supporter_phone: [71, 13]
}

POSITIONS_3 = {
  name: [5, 12]
}

ARRAY_POSITION = {
  nationality: 4,
  name: [0, 1, 2],
  place: 11,
  kana: 3,
  birthyear: 5,
  birthmonth: 5,
  birthday: 5,
  place_of_birth: 8,
  passport: 21,
  expyear: 22,
  expmonth: 22,
  expday: 22,
  entryyear: 19,
  entrymonth: 19,
  entryday:19,
  port_of_entry:24,
  visa_place: 23,
  visit_times: 26,
  start_visit_year: 27,
  start_visit_month: 27,
  start_visit_day: 27,
  end_visit_year: 28,
  end_visit_month: 28,
  end_visit_day: 28,
  relation_1: 41,
  relation_1_name: 36,
  relation_1_birthday: 37,
  relation_1_nationality: 38,
  relation_1_employment: 39,
  relation_1_residence: 40,
  relation_2: 47,
  relation_2_name: 42,
  relation_2_birthday: 43,
  relation_2_nationality: 44,
  relation_2_employment: 45,
  relation_2_residence: 46,
  relation_3: 53,
  relation_3_name: 48,
  relation_3_birthday: 49,
  relation_3_nationality: 50,
  relation_3_employment: 51,
  relation_3_residence: 52,
  years_of_education: 35,
  graduation_year: 32,
  graduation_month: 32,
  graduation_day: 32,
  supporter_address: [9, 10, 11],
  supporter_phone: 18
}

`cp coe_clean.ods coe_temp.ods`

doc = Rods.new("coe_temp.ods")

def construct_field(data, key)
  case key
  when :expyear
    text = data[ARRAY_POSITION[key]].split("-")[0]
  when :expmonth
    text = data[ARRAY_POSITION[key]].split("-")[1]
  when :expday
    text = data[ARRAY_POSITION[key]].split("-")[2]
  when :birthyear
    text = data[ARRAY_POSITION[key]].split(".")[2]
  when :birthmonth
    text = data[ARRAY_POSITION[key]].split(".")[1]
  when :birthday
    text = data[ARRAY_POSITION[key]].split(".")[0]
  when :entryyear
    text = data[ARRAY_POSITION[key]].split(".")[2]
  when :entrymonth
    text = data[ARRAY_POSITION[key]].split(".")[1]
  when :entryday
    text = data[ARRAY_POSITION[key]].split(".")[0]
  when :start_visit_year
    text = data[ARRAY_POSITION[key]].split("/")[2] if data[ARRAY_POSITION[key]]
  when :start_visit_month
    text = data[ARRAY_POSITION[key]].split("/")[1] if data[ARRAY_POSITION[key]]
  when :start_visit_day
    text = data[ARRAY_POSITION[key]].split("/")[0] if data[ARRAY_POSITION[key]]
  when :end_visit_year
    text = data[ARRAY_POSITION[key]].split("/")[2] if data[ARRAY_POSITION[key]]
  when :end_visit_month
    text = data[ARRAY_POSITION[key]].split("/")[1] if data[ARRAY_POSITION[key]]
  when :end_visit_day
    text = data[ARRAY_POSITION[key]].split("/")[0] if data[ARRAY_POSITION[key]]
  when :graduation_year
    text = data[ARRAY_POSITION[key]].split("/")[2] if data[ARRAY_POSITION[key]]
  when :graduation_month
    text = data[ARRAY_POSITION[key]].split("/")[1] if data[ARRAY_POSITION[key]]
  when :graduation_day
    text = data[ARRAY_POSITION[key]].split("/")[0] if data[ARRAY_POSITION[key]]
  when /^(name|supporter_name)$/
    positions = ARRAY_POSITION[:name]
    first_name = data[positions[0]]
    middle_name = data[positions[1]]
    last_name = data[positions[2]]

    text = "#{last_name}, #{first_name} #{middle_name}"
  when :supporter_address
    positions = ARRAY_POSITION[key]
    street = data[positions[0]]
    zip = data[positions[1]]
    city = data[positions[2]]

    text = [street, zip, city].join(", ")
  else
    text = data[ARRAY_POSITION[key]]
  end
  return text.to_s
end

testdata[1..-1].each do |data|

  doc.setCurrentTable "申請人用１"
  POSITIONS.each do |key, (row, col)|
    text = construct_field(data, key)
    cell = doc.getCell(row,col)
    doc.writeText(cell, "string", text)
  end

  doc.setCurrentTable "申請人用２"
  POSITIONS_2.each do |key, (row, col)|
    text = construct_field(data, key)
    cell = doc.getCell(row,col)
    doc.writeText(cell, "string", text)
  end

  doc.setCurrentTable "所属機関用１"
  POSITIONS_3.each do |key, (row, col)|
    text = construct_field(data, key)
    cell = doc.getCell(row,col)
    doc.writeText(cell, "string", text)
  end

  filename = "out/coe_#{construct_field(data,:name).downcase.gsub(/\s/,"_")}.ods"
  doc.saveAs(filename)

  `unoconv -f pdf #{filename}`
end

