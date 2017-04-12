require "uuid"

class ConvertToExcel
  attr_reader :template, :json

  def initialize(template, json)
    @template = template
    @json = json
  end

  def process
    generate_output_file
    rm_old_file
    output_filename = run_fill_to_excel_jar("java -jar #{fill_to_excel_jar_file} \"#{@template}\" \"#{@output_file}\" #{json_file}")
    File.delete(json_file) if File.exists?(json_file)

    [ @output_file, output_filename ]
  end

  def rm_old_file
    file_path = root_path("tmp", "files", "excels")
    Dir.glob("#{file_path}/*").each do |file|
      if File.basename(file).to_date < (Date.today - 2)
        FileUtils.rm_rf(file)
      end
    end
  end

  def json_file
    @json_file ||= begin
      file = root_path("tmp", guid)
      File.open(file, "w") { |f| f.write json }
      file
    end
  end

  def root_path(*arg)
    File.join("/", "app", *arg)
  end

  def guid
    uuid = UUID.new
    uuid.generate
  end

  def run_fill_to_excel_jar(cmd)
    File.open("/tmp/export_xls.sh", "w") do |f|
      f.puts cmd
    end
    res = `/bin/sh /tmp/export_xls.sh`

    res.scan(/\|{3}(.+)\|{3}/m).any? ? "#{$1}.xls" : "BLANK.xls"
  end

  def fill_to_excel_jar_file
    @fill_to_excel_jar_file ||= root_path("lib", "fillToExcel.jar")
  end

  def generate_output_file
    @output_file = root_path("tmp", "files", "excels", Date.today.to_s, "#{File.basename(@template)}_#{guid}")
    dir = File.dirname(@output_file)
    FileUtils.mkdir_p(dir) unless File.exists?(dir)
    FileUtils.cp(@template, @output_file)
  end
end
