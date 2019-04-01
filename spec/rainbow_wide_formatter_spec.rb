# frozen_string_literal: true

require 'spec_helper'
require 'stringio'
require 'rainbow_wide_formatter'

describe RainbowWideFormatter do
  before do
    @output = StringIO.new
    @formatter = RainbowWideFormatter.new(@output)
  end

  describe 'ascii situation' do
    before do
      allow(@formatter).to receive(:terminal_width).and_return(100)
      allow(@formatter).to receive(:ascii_length).and_return(11)
      @whole_net_width = 100 - 2 * 2 - 6 - 11
    end

    it 'A rainbow wide formatter must be registered' do
      expect(RSpec::Core::Formatters::Loader.formatters.keys).to include(RainbowWideFormatter)
    end

    context 'for 35 examples' do
      before do
        @formatter.start(35)
      end

      it 'should calculate the net width for example 3' do
        expect(@formatter.net_width_for(3)).to eql((@whole_net_width * 3.0 / 35.0).round)
      end

      it 'should calculate the net width for example 30' do
        expect(@formatter.net_width_for(5)).to eql((@whole_net_width * 5.0 / 35.0).round)
      end
    end

    context 'for 50 examples' do
      before { @formatter.start(50) }

      it 'should calculate the net width for example 1' do
        expect(@formatter.net_width_for(1)).to eql((@whole_net_width * 1.0 / 50.0).round)
      end

      it 'should calculate the net width for example 25' do
        expect(@formatter.net_width_for(25)).to eql((@whole_net_width * 25.0 / 50.0).round)
      end
    end
  end
end
