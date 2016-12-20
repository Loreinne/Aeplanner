# Karma configuration
# Generated on %DATE%

module.exports = (config) ->
  config.set do

    # base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '%BASE_PATH%'


    # frameworks to use
    # available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: [%FRAMEWORKS%]


    # list of files / patterns to load in the browser
    files: [%FILES%
    ]


    # list of files to exclude
    exclude: [%EXCLUDE%
    ]


    # preprocess matching files before serving them to the browser
    # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: %PREPROCESSORS%


    # test results reporter to use
    # possible values: 'dots', 'progress'
    # available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress']


    # web server port
    port: 9876


    # enable / disable colors in the output (reporters and logs)
    colors: true


    # level of logging
    # possible values:
    # - config.LOG_DISABLE
    # - config.LOG_ERROR
    # - config.LOG_WARN
    # - config.LOG_INFO
    # - config.LOG_DEBUG
    logLevel: config.LOG_INFO


    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: %AUTO_WATCH%


    # satart these browsers
    # available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: [%BROWSERS%]


    # Continuous Integration mode
    # if true, Karma captures browsers, runs the tests and exits
    singleRun: false
