require("colorbuddy").setup()

local Color, colors, Group, groups, styles = require('colorbuddy').setup()

Color.new('white', '#fffffe')
Color.new('red', '#ec658e')
Color.new('yellow', '#ffe11a')
Color.new('green', '#54e8ad')
Color.new('blue', '#6F9FFF')
Color.new('darker_blue', '#506faf')
Color.new('darkest_blue', '#384c75')
Color.new('orange', '#b25f00')
Color.new('dark_orange', '#9b7d03')
Color.new('dark_green', '#338e3f')
Color.new('black', '#0d100d')
Color.new('pink', '#f07eed')

Group.new('Normal', colors.black, colors.white)
Group.new('Function', colors.orange)
Group.new('Identifier', colors.blue)

Group.new('TSBoolean', colors.blue)
Group.new('TSCharacter', colors.blue)
Group.new('TSComment', colors.dark_orange)
Group.new('TSConditional', colors.darker_blue)
Group.new('TSConstant', colors.darkest_blue)
Group.new('TSConstBuiltin', colors.darkest_blue)
Group.new('TSConstMacro', colors.pink)
Group.new('TSFuncMacro', colors.pink)
Group.new('TSInclude', colors.pink)
Group.new('TSKeyword', colors.darker_blue)
Group.new('TSKeywordFunction', colors.darker_blue)
Group.new('TSKeywordOperator', colors.darker_blue)
Group.new('TSOperator', colors.orange)
--Group.new('tsvariable', colors.blue)
--Group.new('tsvariable', colors.blue)
--Group.new('tsvariable', colors.blue)
--Group.new('tsvariable', colors.blue)
--Group.new('tsvariable', colors.blue)
--Group.new('tsvariable', colors.blue)
--Group.new('tsvariable', colors.blue)
--Group.new('tsvariable', colors.blue)

Group.new('TSProperty', colors.darker_blue)
Group.new('TSVariable', colors.blue)
--Group.new('TSProperty', colors.darkest_blue)
--Group.new('TSProperty', colors.darkest_blue)
--Group.new('TSProperty', colors.darkest_blue)
--Group.new('TSProperty', colors.darkest_blue)
