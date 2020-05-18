# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import dupfinderpkg/submodule
import strutils

when isMainModule:
  echo(getWelcomeMessage())
  echo("Path: ")
  var dirname = readLine(stdin)
  dirname.stripLineEnd
  
  let files = getFileList(dirname)
  let fhash = getHashed(files)
  let val = pruneDups(fhash)
  if val:
    echo("File duplicates pruned successfully")
  else:
    echo("Pruning not successfull")
