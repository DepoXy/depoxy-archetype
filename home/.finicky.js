// CXREF:
//   https://github.com/johnste/finicky/wiki/Configuration
// See also:
//   https://finicky-kickstart.vercel.app/
//   https://github.com/johnste/finicky/wiki/Configuration-ideas
//   https://github.com/johnste/finicky
module.exports = {
  defaultBrowser: "Google Chrome",      
  handlers: [
    // E.g.,
    //
    //   {
    //     match: /^https?:\/\/google\.com\/.*$/,
    //     browser: "Safari"
    //   },

    // Opens Slack links in a new window.
    {
      match: ({opener}) => opener.bundleId === "com.tinyspeck.slackmacgap",
      browser: ({urlString}) => ({
        name: "Google Chrome",
        // appType: "appName" // Force name type. "appName", "bundleId" or "appPath",
        // openInBackground: true, // or false, force opening the browser in the background
        // openInBackground: urlString.includes("farcebook"), // e.g.
        // profile: "Default",
        // Undocumented, but I see in source:
        // - Ugh, *of course* this would do that: Opens new window alright, but sans location.
        args: ["--new-window", urlString],
      }),
    },
  ],
}

