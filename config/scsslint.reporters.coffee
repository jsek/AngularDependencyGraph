###
 * @fileoverview Custom reporters for gulp-scsslint
 * @author J-Sek
###

gutil   = require('gulp-util')
sprintf = require('sprintf-js').sprintf
through = require('through2')

lastFailingFile = null
cl = gutil.colors

severityColor = 
    warning : cl.yellow
    error   : cl.red 

#------------------------------------------------------------------------------
# Helpers
#------------------------------------------------------------------------------

printPath     = (path) -> '\n' + cl.magenta(path)
printPlace    = (issue) -> cl.gray(sprintf('%5.0f', issue.line) + ':' + sprintf('%-4.0f', issue.column))
printPlaceRaw = (issue) -> "(#{issue.line},#{issue.column})"
printSeverity = (issue) -> severityColor[issue.severity](sprintf('%-9s', issue.severity))
pluralize     = (word, count) -> if count > 1 then word + 's' else word

printPathLine = (file) ->
    if (lastFailingFile != file.path)
        lastFailingFile = file.path
        console.log printPath(lastFailingFile)

logStylish    = (issue) ->
    place = printPlace issue
    severity =  printSeverity issue
    console.log place, severity, issue.reason

#------------------------------------------------------------------------------
# Reporters
#------------------------------------------------------------------------------

###
 * Inspired by 'stylish' ESLint reporter
 * Usage: stream element, like for ESLint
###

stylishPrintFile = (file) ->
    if !file.scsslint.success
        printPathLine file
        for issue in file.scsslint.issues
            logStylish issue

stylishPrintErrorsInFile = (file) ->
    if file.scsslint.errors > 0
        printPathLine file
        for issue in file.scsslint.issues.filter((x) -> x.severity is 'error')
            logStylish issue
    
stylishSummary = (total, errors, warnings) ->
    if total > 0
        console.log cl.red.bold "\n\u2716  #{total} #{pluralize('problem', total)} (#{errors} #{pluralize('error', errors)}, #{warnings} #{pluralize('warning', warnings)})\n"
    
stylishErrorsSummary = (total, errors, warnings) ->
    if total > 0
        console.log cl.red.bold "\n\u2716  #{errors} #{pluralize('error', errors)}!\n"

writeStylishResults = (results, fileFormatter, summaryFormatter) ->
    total = errors = warnings = 0
    
    for result in results
        fileFormatter(result)
        total += result.scsslint.issues.length
        errors += result.scsslint.errors
        warnings += result.scsslint.warnings
        
    if total > 0 then summaryFormatter(total, errors, warnings)

reportWithSummary = (fileFormatter, summaryFormatter) ->
    results = []

    passAll = (file, enc, cb) ->
        unless file.scsslint.success then results.push(file)
        cb(null, file)

    printResults = (cb) ->
        if results.length then writeStylishResults(results, fileFormatter, summaryFormatter)
        # reset buffered results
        results = []
        cb()

    return through.obj passAll, printResults

stylishReporter       = () -> reportWithSummary stylishPrintFile, stylishSummary
stylishErrorsReporter = () -> reportWithSummary stylishPrintErrorsInFile, stylishErrorsSummary


###
 * Emit error formatted for Visual Studio on first error
 * Note: Intentially ignore warnings 
 * Usage: Inline - intended for 'customReportField'
###
visualstudioReporter = (file, stream) ->
    if file.scsslint.errors > 0
    
        for issue in file.scsslint.issues
            place = printPlaceRaw issue
            message = "#{file.path}#{place}: ScssLint #{issue.severity}: #{issue.reason}"
            process.stderr.write(message+'\n')

        process.exit 1


module.exports =
    suppress: -> return
    stylish: stylishReporter
    stylishErrors: stylishErrorsReporter
    visualstudio: visualstudioReporter