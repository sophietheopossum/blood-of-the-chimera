#3.0.6-r3
includes previous improvements
::prototype99
-make it clear newer x264 is needed for 10bit use flag

#3.0.6-r2
::ag-ops
-required media-libs/fdk-aac version
-compatibility with newer versions of libav
-10bit use flag

::gentoo
-base ebuild

::prototype99
-patch renamed to make it clearer where bugs are located, obseletes need to put bug number in comment
-move x264 if statement to the required_use
-add spatialaudio dependency
-remove unneeded quote marks

::rindeal
-arm optimisation
-libplacebo use flag
-schroedinger use flag
-screen capture use flag
-shine use flag
-spatialaudio use flag
-vlc use flag
-realrtsp use flag
-add more detail to dependencies
