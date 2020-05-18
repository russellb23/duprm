# This is just an example to get you started. Users of your hybrid library will
# import this file by writing ``import dupfinderpkg/submodule``. Feel free to rename or
# remove this file altogether. You may create additional modules alongside
# this file as required.
############################################################################################
# TODO:
# use async, await for delete I/O operations for further concurrency
# Generate a list of duplicate files deleted and original files retained with absolute paths
############################################################################################
import std/sha1
import os, threadpool
{.experimental: "parallel"}

proc getWelcomeMessage*(): string = "Finding duplicates..."

proc getFileList*(loc: string): seq[string] =
  var flist: seq[string] = @[]
  for f in os.walkDirRec(loc):
    flist.add(f)

# Parallely hashing the file content for speed up
proc getHashed*(fl: seq[string]): seq[SecureHash] =
  var hl = newSeq[SecureHash](fl.len())
  parallel:
    for i,f in fl:
      hl[i] = spawn secureHashFile(f)
  result = hl

proc pruneDups*(dlist: seq[SecureHash]): bool =
  for i in 0..dlist.len()-1:
    for j in countDown(dlist.len()-1, i, 1):
      if i != j:
        if dlist[i] == dlist[j]:
          echo(dlist[i] & "\n" & dlist[j])
          if os.existsFile(dlist[i]):
            echo("File marked for removal: " & dlist[i])
            if os.tryRemoveFile(dlist[i]):
              echo("Removed: " & " " & dlist[i])
              result = true
            else:
              echo("Problem deleting file: " & " " & dlist[i])
              result = false
          elif os.existsDir(dlist[i]):
            echo("Dirrectory name: " & " " & dlist[i])
          else: discard
        else: discard
      else: discard
  result = true
