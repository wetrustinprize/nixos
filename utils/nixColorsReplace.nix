{ lib, ... }:
	{ scheme, text }:
	lib.replaceStrings [
		"@base-00"
		"@base-01"
		"@base-02"
		"@base-03"
		"@base-04"
		"@base-05"
		"@base-06"
		"@base-07"
		"@base-08"
		"@base-09"
		"@base-0A"
		"@base-0B"
		"@base-0C"
		"@base-0D"
		"@base-0E"
		"@base-0F"
	] [
		scheme.palette.base00
		scheme.palette.base01
		scheme.palette.base02
		scheme.palette.base03
		scheme.palette.base04
		scheme.palette.base05
		scheme.palette.base06
		scheme.palette.base07
		scheme.palette.base08
		scheme.palette.base09
		scheme.palette.base0A
		scheme.palette.base0B
		scheme.palette.base0C
		scheme.palette.base0D
		scheme.palette.base0E
		scheme.palette.base0F
	] text