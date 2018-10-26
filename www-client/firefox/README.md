current included gecko media plugins: openh264(used for x264 in case of nothing else), widevine(used for digital rights management)
use ./configure --help to view all available options, ones without description have descriptions in the old-configure file
ebuild steps:
1. metadata
2. declare python compatibility
3. declare locales
4. declare source route url
5. declare eclasses (of special note are mozlinguas and mozcoreconf)
6. more metadata
7. declare architectures
8. declare slot
9. declare licences
10. declare useflags
11. declare source and gentoo patches urls
12. declare dependency variables
13. declare common shared dependencies
14. declare runtime dependencies
15. declare build dependencies
16. declare use flag dependencies
17. declare variables
18. declare gecko media plugins
19. check clang version is correct
20. set up package and print warning
21. check system requirements are met
22. unpack source code
23. unpack language packs
24. unpack kde patches
25. allow user patches
25. declare gentoo patches directory
26. declare kde patches directory
27. declare extra patches
28. debug
29. workaround for ia64 (gentoo bug 582432)
30. enable plugins directory
31. workaround for gentoo bug 372817
32. don't exit when system has missing libraries
33. having no files to remove doesn't cause an error
34. don't switch to dev edition when using aurora branding
35. autotools configure
36. set google location api key
37. mozconfig_init (calls mozcoreconf)
38. use flag actions
39. set linker
40. enable official branding if not redistributing
41. more useflags and miscellaneous configuration
42. workaround for big endian
43. set host and target
44. select default target toolkit
45. set audio backend (also addresses gentoo bug 600002)
46. more useflags
47. disable elf-hack where relevant
49. ensure the correct ccache is used
49. enable/disable eme
50. apply more use flags and configuration
50. add alpha workaround
51. improve hardened support
52. add arm neon workarounds (addresses gentoo bug 553364)
53. set up location services
54. set default location
55. mozconfig_final (calls mozcoreconf)
56. gentoo workaround
57. build
58. add gentoo default prefs
59. add extra prefs for performance
60. add use flag related prefs
61. install
62. install language packs
63. set up icon/desktop file
64. add startup notification workaround (addresses gentoo bug 237317)
65. firefox hardened workaround
66. add apulse support
