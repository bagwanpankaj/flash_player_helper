#Copyright (c) 2010 [Bagwan Pankaj]
#http://bagwanpankaj.com
#
#Permission is hereby granted, free of charge, to any person obtaining
#a copy of this software and associated documentation files (the
#"Software"), to deal in the Software without restriction, including
#without limitation the rights to use, copy, modify, merge, publish,
#distribute, sublicense, and/or sell copies of the Software, and to
#permit persons to whom the Software is furnished to do so, subject to
#the following conditions:
#
#The above copyright notice and this permission notice shall be
#included in all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


module RailsJaipur
  module FlashPlayerHelper

    DEFAULT_VARS =   {
                            :allowfullscreen   => 'true',
                            :allowscriptaccess => 'true',
                            :flashvars => {
                                            :title => 'Demo of flash_player_helper Plugin',
                                            :author => 'Bagwan Pankaj',
                                            :file => '/others/video.flv',
                                            :backcolor => 'white',
                                            :autostart => 'true',
                                            :description => 'JW Flash Player Helper.This is a demo video; came bundled with JW Flash Player Setup',
                                            :height => '400',
                                            :width => '300'
                                          }
                     } unless const_defined?("DEFAULT_VARS")

    
    DEFAULT_CONFIG = {
                        :player_id => 'flash_player',
                        :id => 'flash_player_container',
                        :player_message => 'Player will be placed here.',
                        :class => ''
                     } unless const_defined?("DEFAULT_CONFIG")

    #Helper for flash player
    def player(player_options = {},config = {})
      player_options = player_options.reverse_merge(DEFAULT_VARS)
      player_options[:flashvars] = player_options[:flashvars].reverse_merge(DEFAULT_VARS[:flashvars])
      config = config.reverse_merge(DEFAULT_CONFIG)

      content_tag('div', config[:player_message] , :id => config[:id], :class => config[:class]) << javascript_tag(build_js('/others/player-viral.swf',player_options, config))
    end

    #Helper for flash image rotator
    def image_rotator(player_options = {},config = {})
      player_options = player_options.reverse_merge(DEFAULT_VARS)
      player_options[:flashvars] = player_options[:flashvars].reverse_merge(DEFAULT_VARS[:flashvars])
      config = config.reverse_merge(DEFAULT_CONFIG)
     
      content_tag('div', config[:player_message] , :id => config[:id], :class => config[:class]) << javascript_tag(build_js('/others/imagerotator.swf',player_options, config))
    end

    
    protected

    def build_js(swf_file, player_options, config)
      %{var so = new SWFObject('#{swf_file}','#{config[:player_id]}','#{player_options[:flashvars][:height]}','#{player_options[:flashvars][:width]}','9');
         #{get_config(player_options)};
         so.write('#{config[:id]}');
      }
    end

    def get_config(player_options = {})
      player_options[:flashvars] = player_options[:flashvars].to_param
      get_swf_params(player_options)
    end

    def get_swf_params(options)
      options.collect { |key,value| "so.addParam('#{key.to_s}','#{value.to_s}')" }.join('; ')
    end
    
  end
end
