#
# CrystFundDom: Allows the computation of fundamental domains via Dirichlet cells for given crystallographic group and starting point
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "CrystFundDom",
Subtitle := "Allows the computation of fundamental domains via Dirichlet cells for given crystallographic group and starting point",
Version := "0.1",
Date := "28/07/2025", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

Persons := [
  rec(
    FirstNames := "Alice C.",
    LastName := "Niemeyer",
    WWWHome := "https://www.math.rwth-aachen.de/~Alice.Niemeyer/",
    Email := "alice.niemeyer@art.rwth-aachen.de",
    IsAuthor := true,
    IsMaintainer := true,
    #PostalAddress := TODO,
    Place := "Aachen, Germany",
    Institution := "Chair of Algebra and Representation Theory, RWTH Aachen",
  ),
  rec(
    FirstNames := "Reymond",
    LastName := "Akpanya",
    WWWHome := "https://www.art.rwth-aachen.de/cms/MATHB/Der-Lehrstuhl/Team/Ehemalige/~pdxgg/Reymond-Akpanya/lidx/1/",
    Email := "akpanya@art.rwth-aachen.de",
    IsAuthor := true,
    IsMaintainer := true,
    #PostalAddress := TODO,
    Place := "Aachen, Germany",
    Institution := "Chair of Algebra and Representation Theory, RWTH Aachen",
  ),
  rec(
    FirstNames := "Lukas",
    LastName := "Schnelle",
    WWWHome := "https://lukasschnelle.de",
    Email := "lukas.schnelle1@rwth-aachen.de",
    IsAuthor := true,
    IsMaintainer := true,
    #PostalAddress := TODO,
    Place := "Aachen, Germany",
    Institution := "Chair of Algebra and Representation Theory, RWTH Aachen",
  ),
],

SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/schnellecom/CrystFundDom",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://github.com/schnellecom/CrystFundDom",
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "CrystFundDom",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Allows the computation of fundamental domains via Dirichlet cells for given crystallographic group and starting point",
),

Dependencies := rec(
  GAP := ">= 4.13",
  NeededOtherPackages := [ ["cryst", "4.1.29"] ],
  # SuggestedOtherPackages := [ ["crystcat", "1.1.10"], ["polymaking", "0.8.7"] ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

# Extensions := [
#   rec(
#     needed := [ ["OscarInterface", ">= 1.0.0"] ],
#     filename := "gap/HyperplaneConversion.gi",
#   ),
#   rec(
#     needed := [ ["polymaking", "0.8"] ],
#     filename := "gap/HyperplaneConversion.gi",
#   ),
#   # rec(
#   #   needed := [ ],
#   #   filename := "gap/nothing.gi",
#   # ),
# ],

#Keywords := [ "TODO" ],

));


