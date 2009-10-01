require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe String do
  describe '#ansi_to_html' do
    it 'should wrap everything in <pre> tags' do
      'hello world'.ansi_to_html.should == '<pre>hello world</pre>'
    end

    it 'should escape HTML' do
      '<>&"'.ansi_to_html.should == '<pre>&lt;&gt;&amp;&quot;</pre>'
    end

    it 'should set font weight to bold' do
      '\e[1mbold text\e[0m'.ansi_to_html.should == '<pre><span style="font-weight: bold;">bold text</span></pre>'
    end

    it 'should set font style to italic' do
      '\e[3mitalic text\e[0m'.ansi_to_html.should == '<pre><span style="font-style: italic;">italic text</span></pre>'
    end

    it 'should set text decoration to underline' do
      '\e[4munderlined text\e[0m'.ansi_to_html.should == '<pre><span style="text-decoration: underline;">underlined text</span></pre>'
    end

    it 'should swap foreground and background colors' do
      '\e[32mgreen foreground color. \e[7mgreen background color.\e[0m'.ansi_to_html.should == '<pre><span style="color: #008000;">green foreground color. <span style="color: #FFFFFF; background-color: #008000;">green background color.</span></span></pre>'
    end

    it 'should set visibility to hidden' do
      '\e[8mhidden text\e[0m'.ansi_to_html.should == '<pre><span style="visibility: hidden;">hidden text</span></pre>'
    end

    it 'should font weight to normal' do
      '\e[22mnormal text\e[0m'.ansi_to_html.should == '<pre><span style="font-weight: normal;">normal text</span></pre>'
    end

    it 'should set text decoration to none' do
      '\e[24mnon-decorated text\e[0m'.ansi_to_html.should == '<pre><span style="text-decoration: none;">non-decorated text</span></pre>'
    end

    it 'should not hide text' do
      '\e[28mvisible text\e[0m'.ansi_to_html.should == '<pre><span style="visibility: visible;">visible text</span></pre>'
    end

    it 'should set foreground color to a low intensity color' do
      '\e[31mdark red text\e[0m'.ansi_to_html.should == '<pre><span style="color: #800000;">dark red text</span></pre>'
    end

    it 'should set foreground color to the default low intensity color' do
      '\e[39mblack text\e[0m'.ansi_to_html == '<pre><span style="color: #000000;">black text</span></pre>'
    end

    it 'should set background color to a low intensity color' do
      '\e[42mtext with green background\e[0m'.ansi_to_html.should == '<pre><span style="background-color: #008000;">text with green background</span></pre>'
    end

    it 'should set background color to the default low intensity color' do
      '\e[49mtext with white background\e[0m'.ansi_to_html.should == '<pre><span style="background-color: #C0C0C0;">text with white background</span></pre>'
    end

    it 'should set foreground color to a high intensity color' do
      '\e[93mvery bright yellow text\e[0m'.ansi_to_html.should == '<pre><span style="color: #FFFF00;">very bright yellow text</span></pre>'
    end

    it 'should set foreground color to the default high intensity color' do
      '\e[99mgray text\e[0m'.ansi_to_html.should == '<pre><span style="color: #808080;">gray text</span></pre>'
    end

    it 'should set background color to a high intensity color' do
      '\e[104mbright blue background\e[0m'.ansi_to_html.should == '<pre><span style="background-color: #0000FF;">bright blue background</span></pre>'
    end

    it 'should set background color to the default high intensity color' do
      '\e[109mtext with white background\e[0m'.ansi_to_html.should == '<pre><span style="background-color: #FFFFFF;">text with white background</span></pre>'
    end

    it 'should close unclosed tags' do
      '\e[92m\e[1mgreen bold text'.ansi_to_html.should == '<pre><span style="color: #00FF00;"><span style="font-weight: bold;">green bold text</span></span></pre>'
    end

    it 'should remove unsupported codes' do
      '\e[5mdo not make text blink. no, seriously'.ansi_to_html.should == '<pre>do not make text blink. no, seriously</pre>'
    end
  end
end
