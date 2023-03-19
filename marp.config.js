const canonicalUrl = process.env.URL || undefined

module.exports = {
  themeSet: 'themes',
  url: canonicalUrl,
  inputDir: "./slides",
  output: "./dist",
  allowLocalFiles: true,
  bespoke: {
      progress: true
  }
}

