import Foundation

// Entry point: print the banner, build a fresh session, and hand
// control to the interactive read-eval-print loop.
//
// Everything else in this package is reachable from Repl.run().
print(Version.banner())
let settings = Settings.interactive()
let context = ReplContext(settings: settings)
Repl(context: context).run()
