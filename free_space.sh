mkdir _fs
mount filesystem.img _fs
rm -r _fs/var/log/journal/*
umount _fs
rmdir _fs
