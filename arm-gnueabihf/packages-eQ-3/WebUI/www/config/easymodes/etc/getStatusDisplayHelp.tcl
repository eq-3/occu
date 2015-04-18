#!/bin/tclsh

proc getStatusDisplayHelp {} {
  set helpText "\${dialogHelpContent}"
  append helpText "<table style=\\'color:black; text-align:center\\'><tbody>"
  append helpText "<tr><td>\${dialogHelpContentA}</td><td>\${dialogHelpContentB}</td></tr>"
  append helpText "<tr><td>\[</td><td>&Auml;</td></tr>"
  append helpText "<tr><td>\#</td><td>&Ouml;</td></tr>"
  append helpText "<tr><td>\$</td><td>&Uuml;</td></tr>"
  append helpText "<tr><td>\{</td><td>&auml;</td></tr>"
  append helpText "<tr><td>\|</td><td>&ouml;</td></tr>"
  append helpText "<tr><td>\}</td><td>&uuml;</td></tr>"
  append helpText "<tr><td>\_</td><td>&szlig;</td></tr>"
  append helpText "<tr><td>\]</td><td>\&</td></tr>"
  append helpText "<tr><td>\\'</td><td>\=</td></tr>"
  append helpText "<tr><td>\;</td><td>\${dialogHelpContentC}</td></tr>"
  append helpText "<tr><td>\@</td><td>&or;</td></tr>"
  append helpText "<tr><td>\></td><td>&and;</td></tr>"
  append helpText "<tr><td>\<</td><td>\${dialogHelpContentD}</td></tr>"
  append helpText "</tbody></table>"
  return $helpText
}