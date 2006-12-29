require File.dirname(__FILE__) + '/../spec_helper'

# ==, ===, =~, casefold?, eql?, hash, inspect, kcode, match, options,
# source, to_s, ~

context "Regexp" do
  specify "== should be true if self and other have the same pattern, character set code, and casefold? values" do
    example do
      p [/abc/ == /abc/, /abc/ == /abc/x, /abc/ == /abc/i, /abc/u == /abc/n]
    end.should == '[true, false, false, false]'
  end
  
  specify "=== should be true if there is a match" do
    example do
      p /abc/ === "aabcc"
    end.should == 'true'
  end
  
  specify "=== should be false if there is no match" do
    example do
      p /abc/ === "xyz"
    end.should == 'false'
  end
  
  specify "=~ should return a MatchData object describing the match" do
    example do
      /(.)(.)(.)/ =~ "abc"
      p $~[2]
    end.should == 'b'
  end
  
  specify "=~ should return nil if there is no match" do
    example do
      /xyz/ =~ "abxyc"
      p $~
    end.should == 'nil'
  end
  
  specify "casefold? should return the value of the case-insensitive flag" do
    example do
      p [/abc/i.casefold?, /xyz/.casefold?]
    end.should == '[true, false]'
  end
  
  specify "eql? should be a synonym for ==" do
    example do
      p [/abc/.eql?(/abc/), /abc/.eql?(/abc/x), /abc/.eql?(/abc/i), /abc/u.eql?(/abc/n)]
    end.should == '[true, false, false, false]'
  end
  
  specify "hash should produce a hash based on the text and options" do
    example do
      p [/wonkers/.hash, /bonkers/.hash, /abc/i.hash, /xyz/n.hash]
    end.should == '[]'
  end

  specify "inspect should produce a formatted string" do
    example do
      p [/ab+c/ix.inspect, /a(.)+s/n.inspect]
    end.should == '["/ab+c/ix", "/a(.)+s/n"]'
  end

  specify "kcode should return the character set code" do
    example do
      p [/ab+c/s.kcode, /a(.)+s/n.kcode, /xyz/e.kcode, /cars/u.kcode]
    end.should == '["sjis", "none", "euc", "utf8"]'
  end

  specify "match should be a synonym for =~" do
    example do
      p [/(.)(.)(.)/.match("abc")[2], /xyz/.match("abxyc")]
    end.should == '["b", nil]'
  end

  specify "options should return set of bits for options used" do
    example do
      p [ /cat/.options,
          /cat/ix.options,
          Regexp.new('cat', true).options,
          Regexp.new('cat', 0, 's').options ]
    end.should == '[0, 3, 1, 48]'
  end

  specify "source should return the original string of the pattern" do
    example do
      p [/ab+c/ix.source, /x(.)xz/.source]
    end.should == '["ab+c", "x(.)xz"]'
  end

  specify "to_s should return a string in (?xxx:yyy) notation" do
    example do
      p [/ab+c/ix.to_s, /xyz/.to_s, /jis/s.to_s]
    end.should == '["(?ix-m:ab+c)", "(?-mix:xyz)", "(?-mix:jis)"]'
  end

  specify "~ should match against the contents of $_" do
    example do
      $_ = "input data"
      puts ~ /at/
    end.should == '7'
  end

end
