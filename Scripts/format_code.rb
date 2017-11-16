#!/usr/bin/env ruby

def files_to_format
  filter = "'*.swift'"
  modified_and_untracked = `git ls-files --others --exclude-standard -m -- #{filter}`
  staged = `git diff --cached --name-only -- #{filter}`
  all_files = modified_and_untracked + staged
  all_files.lines.uniq.map { |f| File.expand_path f.strip }.select { |f| File.exist? f }
end

def exist?(command)
  !`which #{command}`.empty?
end

def format_files(files)
  disabled = disabled_rules.join(',')
  enabled = enabled_rules.join(',')
  `swiftformat #{files.join(' ')} --disable #{disabled} --enable #{enabled}`
end

def format_code
  unless exist? 'git'
    puts 'warning: failed to find git command'
    exit 0
  end

  unless exist? 'swiftformat'
    puts "warning: [swiftformat] not found (to install it run 'brew install swiftformat')"
    exit 0
  end

  files = files_to_format
  if files.empty?
    puts 'everything is up-to-date'
  else
    puts "going to format files:\n#{files.join('\n')}"
    format_files(files)
  end
end

def enabled_rules
  [
    'blankLinesAtEndOfScope',
    'blankLinesBetweenScopes',
    'braces',
    'consecutiveBlankLines',
    'consecutiveSpaces',
    'disabledByDefaul',
    'elseOnSameLine',
    'fileHeader',
    'hoistPatternLet',
    'indent',
    'linebreakAtEndOfFile',
    'linebreaks',
    'numberFormatting',
    'ranges',
    'semicolons',
    'spaceAroundBraces',
    'spaceAroundBrackets',
    'spaceAroundComments',
    'spaceAroundGenerics',
    'spaceAroundOperators',
    'spaceAroundParens',
    'spaceInsideBraces',
    'spaceInsideBrackets',
    'spaceInsideComments',
    'spaceInsideGenerics',
    'spaceInsideParens',
    'specifiers',
    'todos',
    'trailingSpace',
    'wrapArguments',
  ]
end

def disabled_rules
  [
    'void',
    'unusedArguments',
    'redundantBackticks',
    'redundantGet',
    'redundantLet',
    'redundantNilInit',
    'redundantParens',
    'redundantPattern',
    'redundantRawValues',
    'redundantReturn',
    'redundantSelf',
    'redundantVoidReturnType',
    'trailingCommas',
    'trailingClosures', # don't touch this rule
  ]
end

format_code
