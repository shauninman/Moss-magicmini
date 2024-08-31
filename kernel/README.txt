Place the KERNEL file in this directory and run ./extract.sh
The initramfs will be extracted to /tmp (because macOS won't 
allow the creation of the /dev/console node) and rsync'd to
this directory.

Make changes to local copy of initramfs.

Run ./compress.sh to rsync changes back to tmp and insert the
changes back into KERNEL (so make sure you have a backup!)

Oh, it's worth mentioning that additions and deletions are 
ignored. This KERNEL seems to not handle offset changes well.

---

Beyond the initramfs changes I've made, the KERNEL file has 
been modified from stock to include Gamma's cpu speed patches.
To date this has involved comparing his KERNEL against the
stock version in Hex Fiend and manually applying the changes
one by one to my KERNEL. (None of the binary diff progams 
I found would patch if the input file didn't match the 
original input file.)
