#encoding:utf-8
require "bundler"
require "date"

Bundler.require

class Student
  include DataMapper::Resource

  property :id, Serial

  property :studentwikiname, String
  property :verwandter2aufenthaltsstatus, String
  property :verwandter2arbeitsplatz, String
  property :vorrabschlussdatum, Date
  property :nebenfach, String
  property :verwandter3arbeitsplatz, String
  property :verwandter1geburtstag, Date
  property :anzahl, String
  property :verwandter2verwandschaftsgrad, String
  property :landderzeitigerwohnsitz, String
  property :geburtsort, String
  property :bildungsjahreinsgesamt, String
  property :ortzurvisabeantragung, String
  property :hauptfach, String
  property :wohnorthauptwohnsitz, String
  property :verwandter1verwandschaftsgrad, String
  property :email, String
  property :landhauptwohnsitz, String
  property :nameinkatakana, String
  property :verwandter3nationalitt, String
  property :verwandter2nationalitt, String
  property :vorherigejapanbesuche, String
  property :ablaufdatum, Date
  property :einschreibungsdatum, Date
  property :verwandter3aufenthaltsstatus, String
  property :straehauptwohnsitz, String
  property :verwandter3verwandschaftsgrad, String
  property :verwandter3name, String
  property :verwandter2name, String
  property :plzhauptwohnsitz, String
  property :lngedesaufenthalts, String
  property :verwandter1name, String
  property :nationalitt, String
  property :ortdereinreise, String
  property :verwandter1arbeitsplatz, String
  property :geburtstag, Date
  property :familienstand, String
  property :vorname, String
  property :verwandter1nationalitt, String
  property :endederletzenreise, Date
  property :beginnderletztenreise, Date
  property :mittlerername, String
  property :ankunftsdatum, Date
  property :wohnortderzeitigerwohnsitz, String
  property :passnummer, String
  property :verwandter1aufenthaltsstatus, String
  property :verwandter2geburtstag, Date
  property :verwandter3geburtstag, Date
  property :telefon, String
  property :nachname, String
  property :straederzeitigerwohnsitz, String
  property :plzderzeitigerwohnsitz, String
  property :geschlecht, String

end

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
  entryyear: [49, 8],
  entrymonth: [49, 11],
  entryday: [49, 14],
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
  relation_3_residence: [83,7],
  male: [23,5],
  female:[23,7],
  married: [23, 23],
  past_entry: [58,12],
  accompanying: [52, 19],
  criminalrecord: [65, 10],
  deportation: [68, 17]
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

TRANSLATOR = {
  nationality: :nationalitt,
  name: [:vorname,:mittlerername,:nachname],
  place: :wohnorthauptwohnsitz,
  kana: :nameinkatakana,
  birthyear: :geburtstag ,
  birthmonth: :geburtstag,
  birthday: :geburtstag,
  place_of_birth: :geburtsort,
  passport: :passnummer,
  expyear: :ablaufdatum,
  expmonth: :ablaufdatum,
  expday: :ablaufdatum,
  entryyear: :ankunftsdatum,
  entrymonth: :ankunftsdatum,
  entryday: :ankunftsdatum ,
  port_of_entry: :ortdereinreise,
  visa_place: :ortzurvisabeantragung,
  visit_times: :anzahl,
  start_visit_year: :beginnderletztenreise,
  start_visit_month: :beginnderletztenreise,
  start_visit_day: :beginnderletztenreise ,
  end_visit_year: :endederletzenreise,
  end_visit_month: :endederletzenreise,
  end_visit_day: :endederletzenreise,
  relation_1: :verwandter1verwandschaftsgrad,
  relation_1_name: :verwandter1name,
  relation_1_birthday: :verwandter2geburtstag,
  relation_1_nationality: :verwandter1nationalitt,
  relation_1_employment: :verwandter1arbeitsplatz,
  relation_1_residence: :verwandter1aufenthaltsstatus,
  relation_2: :verwandter2verwandschaftsgrad,
  relation_2_name: :verwandter2name,
  relation_2_birthday: :verwandter2geburtstag,
  relation_2_nationality: :verwandter2nationalitt,
  relation_2_employment: :verwandter2arbeitsplatz,
  relation_2_residence: :verwandter2aufenthaltsstatus,
  relation_3: :verwandter3verwandschaftsgrad,
  relation_3_name: :verwandter3name,
  relation_3_birthday: :verwandter3geburtstag,
  relation_3_nationality: :verwandter3nationalitt,
  relation_3_employment: :verwandter3arbeitsplatz,
  relation_3_residence: :verwandter3aufenthaltsstatus,
  years_of_education: :bildungsjahreinsgesamt,
  graduation_year: :vorrabschlussdatum,
  graduation_month: :vorrabschlussdatum,
  graduation_day: :vorrabschlussdatum,
  supporter_address: [:straehauptwohnsitz, :plzhauptwohnsitz, :wohnorthauptwohnsitz, :landhauptwohnsitz],
  supporter_phone: :telefon,
  male: :geschlecht,
  female: :geschlecht,
  married: :familienstand,
  past_entry: :vorherigejapanbesuche

}

DataMapper.setup(:default, 'sqlite:students.db')
DataMapper.auto_migrate!

helpers do
  def construct_field(student, key)
    case key
    when :accompanying
      text = "有・(無)"
    when :criminalrecord
      text = "） ・ (無)"
    when :deportation
      text = "有・(無)"
    when :past_entry
      text = student[TRANSLATOR[key]][/ein/] ? "有・(無)" : "(有)・無"
    when :married
      text = student[TRANSLATOR[key]][/edig/] ? "有・(無)" : "(有)・無"
    when :male
      text = student[TRANSLATOR[key]][/Männlich/] ? "(男)" : "男"
    when :female
      text = student[TRANSLATOR[key]][/Männlich/] ? "女" : "(女)"
    when /^relation.+day$/
      date = student[TRANSLATOR[key]]
      text = date ? date.to_s : ""
    when /year$/
      date = student[TRANSLATOR[key]]
      text = date ? date.year.to_s : ""
    when /month$/
      date = student[TRANSLATOR[key]]
      text = date ? date.month.to_s : ""
    when /day$/
      date = student[TRANSLATOR[key]]
      text = date ? date.month.to_s : ""
    when /^(name|supporter_name)$/
      positions = TRANSLATOR[:name]
      first_name = student[positions[0]]
      middle_name = student[positions[1]]
      last_name = student[positions[2]]

      text = "#{last_name}, #{first_name} #{middle_name}"
    when :supporter_address
      positions = TRANSLATOR[key]
      street = student[positions[0]]
      zip = student[positions[1]]
      city = student[positions[2]]
      country = student[positions[3]]

      text = [street, zip, city, country].join(", ")
    else
      text = student[TRANSLATOR[key]]
    end
    replace = {"ü" => "ue", "ä" => "ae", "ö" => "oe", "ß" => "ss", "Ä" => "Ae", "Ü" => "Ue", "Ö" => "Oe"}
    text = text.to_s
    replace.each do |k,v|
      text.gsub!(k,v)
    end
    return text
  end

  def fill_document student
    `cp coe_clean.ods coe_temp.ods`

    doc = Rods.new("coe_temp.ods")
    doc.setCurrentTable "申請人用１"
    POSITIONS.each do |key, (row, col)|
      text = construct_field(student, key)
      puts text
    cell = doc.getCell(row,col)
    doc.writeText(cell, "string", text)
    end

    doc.setCurrentTable "申請人用２"
    POSITIONS_2.each do |key, (row, col)|
      text = construct_field(student, key)
    cell = doc.getCell(row,col)
    doc.writeText(cell, "string", text)
    end

    doc.setCurrentTable "所属機関用１"
    POSITIONS_3.each do |key, (row, col)|
      text = construct_field(student, key)
    cell = doc.getCell(row,col)
    doc.writeText(cell, "string", text)
    end

    filebase = "coe_#{student[:studentwikiname].split(".")[1]}.ods"
    filename = "public/" + filebase
    doc.saveAs(filename)

    `unoconv -f pdf #{filename}`
    return filebase
  end

end

post "/fillForm" do
  stuff = Yajl::Parser.parse(request.body.read)
  stuff["NameinKatakana"] = HTMLEntities.new.decode(stuff["NameinKatakana"])

  newHash = {}

  stuff.each do |k, v|
    k = k.downcase.gsub(".","").to_sym
    if v and Student.properties[k].class == DataMapper::Property::Date
      v = Date.parse v
    end
    newHash[k] = v
  end

  wikiname = newHash.delete(:studentwikiname)
  s = Student.first_or_create({:studentwikiname => wikiname}, newHash)
end

post "/generateForms" do
  rokuhara = "http://rokuhara.japanologie.kultur.uni-tuebingen.de/foswiki/bin/rest/KyotoDataPlugin/filledForms"

  filenames = Student.all.map do |student|
    fill_document student
  end
  filenames.map! {|name| [name, name[0..-4] + "pdf"]}.flatten!
  f = Yajl::Encoder.encode(filenames)
  r = RestClient.get(rokuhara, {params: {files: f}})
  return "OK"
end
