Place the SYSTEM file in this directory and run ./extract.sh
The rootfs will be extracted to /tmp (because macOS won't 
allow the creation of the system nodes) and rsync'd to
this directory.

Make changes to local copy of rootfs.

Run ./compress.sh to rsync changes back to tmp and 
recompress SYSTEM (make sure you have a backup!)

Oh, it's worth mentioning that while additions are honored 
by this rsync command, deletions are not. Use ./delete.sh 
to delete from both locations at once.
