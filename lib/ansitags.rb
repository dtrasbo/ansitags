class String
  def ansi_to_html
    start_tags = 0

    low_intensity_colors = [
      '000000',
      '800000',
      '008000',
      '808000',
      '000080',
      '000080',
      '008080',
      'C0C0C0'
    ]

    high_intensity_colors = [
      '808080',
      'FF0000',
      '00FF00',
      'FFFF00',
      '0000FF',
      'FF00FF',
      '00FFFF',
      'FFFFFF'
    ]

    current_foreground_color = low_intensity_colors[0]
    current_background_color = high_intensity_colors[7]

    '<pre>' + self.gsub('&', '&amp;').gsub('"', '&quot;').gsub('<', '&lt;').gsub('>', '&gt;').gsub(/\\e\[(\d+)m/) do |ansi_code|
      case $1.to_i
      when 0 # reset to default values
        end_tags = start_tags
        start_tags = 0
        '</span>' * end_tags
      when 1 # bold
        start_tags += 1
        '<span style="font-weight: bold;">'
      when 3 # italic
        start_tags += 1
        '<span style="font-style: italic;">'
      when 4 # underlined
        start_tags += 1
        '<span style="text-decoration: underline;">'
      when 7 # swap foreground and background colors
        start_tags += 1
        new_foreground_color     = current_background_color
        new_background_color     = current_foreground_color
        current_foreground_color = new_foreground_color
        current_background_color = new_background_color
        "<span style=\"color: ##{new_foreground_color}; background-color: ##{new_background_color};\">"
      when 8 # hidden
        start_tags += 1
        '<span style="visibility: hidden;">'
      when 22 # normal weight
        start_tags += 1
        '<span style="font-weight: normal;">'
      when 24 # not underlined
        start_tags += 1
        '<span style="text-decoration: none;">'
      when 28 # not hidden
        start_tags += 1
        '<span style="visibility: visible;">'
      when 30..37 # low intensity foreground colors
        start_tags += 1
        "<span style=\"color: ##{current_foreground_color = low_intensity_colors[$1.to_i - 30]};\">"
      when 39 # reset foreground color to default low intensity color
        start_tags += 1
        "<span style=\"color: ##{current_foreground_color = low_intensity_colors[0]};\">"
      when 40..47 # low intensity background colors
        start_tags += 1
        "<span style=\"background-color: ##{current_background_color = low_intensity_colors[$1.to_i - 40]};\">"
      when 49 # reset background color to default low intensity color
        start_tags += 1
        "<span style=\"background-color: ##{current_background_color = low_intensity_colors[7]};\">"
      when 90..97 # high intensity foreground colors
        start_tags += 1
        "<span style=\"color: ##{current_foreground_color = high_intensity_colors[$1.to_i - 90]};\">"
      when 99 # reset foreground color to default high intensity color
        start_tags += 1
        "<span style=\"color: ##{current_foreground_color = high_intensity_colors[0]};\">"
      when 100..107 # high intensity background colors
        start_tags += 1
        "<span style=\"background-color: ##{current_background_color = high_intensity_colors[$1.to_i - 100]};\">"
      when 109 # reset background color to default high intensity color
        start_tags += 1
        "<span style=\"background-color: ##{current_background_color = high_intensity_colors[7]};\">"
      end
    end + '</span>' * start_tags + '</pre>'
  end
end
