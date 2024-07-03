// USAGE:
//   m4_shim \
//     "+8" "home/.finicky.EVAL.js" \
//     "home/.finicky.js"

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

// DXY_HEADER_AUTHOR
// DXY_HEADER_DOTFILES

// CXREF:
//   https://github.com/johnste/finicky/wiki/Configuration
// See also:
//   https://finicky-kickstart.vercel.app/
//   https://github.com/johnste/finicky/wiki/Configuration-ideas
//   https://github.com/johnste/finicky
module.exports = {
  defaultBrowser: "Google Chrome",
  handlers: [
    // REFER: How you might send specific URLs to specific browsers, e.g.,
    //   {
    //     match: /^https?:\/\/google\.com\/.*$/,
    //     browser: "Safari"
    //   },

    // FEATR: Open Slack links in a new window.
    {
      // ALTLY: Match multiple apps, e.g.,
      //    match: ({opener}) => ["org.bar", "org.foo"].includes(opener.bundleId),
      match: ({opener}) => opener.bundleId === "com.tinyspeck.slackmacgap",

      browser: ({urlString}) => ({
        name: "Google Chrome",
        // appType: "appName" // Force name type. "appName", "bundleId" or "appPath",
        // openInBackground: true, // or false, force opening the browser in the background
        // openInBackground: urlString.includes("farcebook"), // e.g.
        // profile: "Default",
        args: ["--new-window", urlString],
      }),
    },
  ],
}

