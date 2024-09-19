// USAGE:
//   m4_shim \
//     "+8" "home/.finicky.EVAL.js" \
//     "home/.finicky.js"

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

// DXY_HEADER_AUTHOR
// DXY_HEADER_DOTFILES

// USAGE: Reload Finicky after editing this file:
//   Menu bar 👇 > Config > Reload

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
        args: [
          "--new-window",
          urlString,
        ],
      }),
    },

    // FEATR: Open terminal `open` commands in a new window.
    // - SAVVY: `open https://addy` from Alacritty produces:
    //     opener = { pid = 1234, bundleId = null, path = null, name = null }
    //   where the 'pid' is for the `open` (or I assume the PID is for `open`,
    //   because it's gone if you look for it after the `open` runs, or if
    //   you try the pid from the Finicky console log).
    {
      // SAVVY: If you want to inspect variables, log 'em, e.g.,:
      //   match: ({opener}) => {
      //     finicky.log("opener: " + opener.pid + " / " + opener.bundleId
      //                    + " / " + opener.path + " / " + opener.name);
      //     // SAVVY: notify() doesn't work for me (tho doesn't error, either):
      //     finicky.notify("opener.bundleId: " + opener.bundleId);
      //     return true;
      //   },

      // MAYBE: We could just do this for all apps, e.g.,:
      //   match: ({opener}) => true,
      // But out of curiosity we'll try to limit this to the `open`
      // command from the terminal (assuming all other apps will set
      // bundleId non-null), so that we can learn what other apps to
      // which we might want to extend this functionality.
      match: ({opener}) => opener.bundleId === null,
      browser: ({urlString}) => ({
        name: "Google Chrome",
        args: [
          "--new-window",
          "--profile-directory=Default",
          urlString,
        ],
      }),
    },
  ],
}

