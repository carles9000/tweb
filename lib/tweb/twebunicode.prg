//	#command !! [ <list,...> ] => aEval( [ \{ <list> \} ],{|e| OutPutDebugString(cValToChar(e)+Chr(13)+Chr(10))} )
/*

  UnicodeConvert.prg

  18 October 2007

  Unicode conversion functions for Harbour.

  The comments in this file assume you are familiar with the basic concepts
  of Unicode.  For an introduction to Unicode, see Wikipedia.

  Harbour does not currently support Unicode strings as a data type.
  However, Unicode data can be handled as byte streams, i.e. strings of bytes
  used with MEMOREAD, MEMOWRIT, FREAD, or FWRITE.  In MiniGUI Extended, the
  RICHVALUE property of a rich edit box control allows you to get and display
  Unicode text, using byte streams.

  The functions in this file enable you to:

  1. Detect which type of Unicode encoding a byte stream uses.

  2. Convert the byte stream to and from a UTF-8 string or an array of
  numeric character codes.

  3. Process UTF-8 strings with functions analogous to ANSI string functions.

  These functions support ANSI (including ASCII) as one of the "Unicode"
  encodings.  Therefore, the word "Unicode" in the comments of this file
  include ANSI as a possible encoding.

  This file includes two main divisions:

  1. UTF-8 style functions.  This style is faster and easier to use than the
  array style.

  2. Array style functions.  This style is slower and harder to use.  It is
  intended that the UTF-8 style will eventually replace this style.

  Kevin Carmody
  i@kevincarmody.com

  Released into the public domain.

*/

//***************************************************************************

/*

UTF-8 STYLE UNICODE FUNCTIONS

The following functions work with UTF-8 strings, which is some respects work
the same as ANSI strings, but in other repects work differently.  For
example, STRTRAN works the same with UTF-8, but SUBSTR works differently.

The main reason for this is that, in UTF-8, a single Unicode character may be
represented by anywhere from 1 to 4 bytes.  For this reason, we must
distinguish between "byte position" and "character position".  For example,
if a UTF-8 string contains 2 Unicode characters that each take up 3 bytes,
then character number 1 occupies bytes 1-3, and character number 2 occupies
bytes 4-6.  In this case, for the second character, its character position is
2, but its byte position is 4.

The documentation below uses the standard Unicode term "code point" to
describe the numeric value of a Unicode character.  This may range from 0 to
1114111 (decimal) = 10FFFF (hexadecimal).  A code point is therefore the
Unicode equivalent of an ASCII value.  The UTF-8 equivalent of ASC() is named
U8COD().

FUNCTIONS AND OPERATORS THAT WORK THE SAME WITH UTF-8

+
$
LTRIM
OCCURS
REPLICATE
RTRIM
STR
STRTRAN
STRZERO
others ...

UTF-8 FUNCTION SUMMARIES

ISASC()         Determines whether a string contains only ASCII characters
ISU8()          Determines whether a string contains only valid UTF-8 characters
U8ADDBOM()      Adds a UTF-8 byte order mark to a string
U8AT()          UTF-8 analog of AT()
U8ATNUM()       UTF-8 analog of ATNUM()
U8CHARBYTE()    Converts character position to byte position within UTF-8 string
U8CHARLEN()     Computes length of Unicode character at byte position in UTF-8 string
U8CHARLIST()    UTF-8 analog of CHARLIST()
U8CHR()         UTF-8 analog of CHR()
U8COD()         UTF-8 analog of ASC()
U8CODPOS()      UTF-8 analog of ASCPOS()
U8DELBOM()      Deletes a UTF-8 byte order mark from a string
U8INC()         Moves byte pointer through UTF-8 string by given number of characters
U8LEFT()        UTF-8 analog of LEFT()
U8LEN()         UTF-8 analog of LEN()
U8PADC()        UTF-8 analog of PADC()
U8PADL()        UTF-8 analog of PADL()
U8PADR()        UTF-8 analog of PADR()
U8RAISEERROR()  Raises Unicode encoding error
U8RAT()         UTF-8 analog of RAT()
U8RIGHT()       UTF-8 analog of RIGHT()
U8STUFF()       UTF-8 analog of STUFF()
U8SUBSTR()      UTF-8 analog of SUBSTR()
U8TOUNI()       Converts UTF-8 string to another Unicode encoding
UNIBOM()        Returns Unicode byte order mark
UNITOU8()       Converts a string in a non-UTF-8 Unicode encoding to UTF-8
UNITYPE()       Determine Unicode encoding type from byte order mark

UTF-8 FUNCTION OUTLINES

IsAsc(cStr) -> lIsAsc
IsU8(cStr) -> lIsU8
U8AddBom(cInStr) -> cOutStr
U8At(cSeaStr, cTargStr) -> nChar
U8AtNum(cSeaStr, cTargStr, nRep) -> nAtChar
U8CharByte(cStr, nChars) -> nByte
U8CharLen(cStr, nPos) -> nBytes
U8CharList(cStr) -> cList
U8Chr(nCode) -> cChar
U8Cod(cStr, nBytes) -> nCode
U8CodPos(cStr, nChar, nBytes) -> nCode
U8DelBom(cInStr) -> cOutStr
U8Inc(cStr, nOByte, nChars) -> nNByte
U8Left(cInStr, nChars) -> cOutStr
U8Len(cStr) -> nLen
U8PadC(cStr, nChars, cFill) -> cPad
U8PadL(cStr, nChars, cFill) -> cPad
U8PadR(cStr, nChars, cFill) -> cPad
U8RaiseError(nErr, aArgs) -> NIL
U8Rat(cSeaStr, cTargStr) -> nChar
U8Right(cInStr, nChars) -> cOutStr
U8Stuff(cInStr, nAtChar, nDelChar, cAddStr) -> cOutStr
U8SubStr(cInStr, nStChar, nChars) -> cOutStr
U8ToUni(cInStr, nType, lAddBom, lDrop) -> cOutStr
UniBom(nType) -> cBom
UniToU8(cInStr, nType, lDelBom) -> cOutStr
UniType(cStr) -> nType

*/

//***************************************************************************

/*

UTF-8 encoding scheme

Code range hex        Unicode values biniary                   UTF-8 binary                           UTF-8 hex

00000000-0000007F     00000000 00000000 00000000 0zzzzzzz      0zzzzzzz
00000000              00000000 00000000 00000000 00000000      00000000                               00
         0000007F     00000000 00000000 00000000 01111111      01111111                               7F
00000080-000007FF     00000000 00000000 00000yyy yyzzzzzz      110yyyyy 10zzzzzz
00000080              00000000 00000000 00000000 10000000      11000010 10000000                      C2 80
         000007FF     00000000 00000000 00000111 11111111      11011111 10111111                      DF BF
00000800-0000FFFF     00000000 00000000 xxxxyyyy yyzzzzzz      1110xxxx 10yyyyyy 10zzzzzz
00000800              00000000 00000000 00001000 00000000      11100000 10100000 10000000             E0 A0 80
         0000FFFF     00000000 00000000 11111111 11111111      11101111 10111111 10111111             EF BF BF
00010000-0010FFFF     00000000 000wwwxx xxxxyyyy yyzzzzzz      11110www 10xxxxxx 10yyyyyy 10zzzzzz
00010000              00000000 00000001 00000000 00000000      11110000 10000000 10000000 10000000    F0 80 80 80
         0010FFFF     00000000 00010000 11111111 11111111      11110100 10111111 10111111 10111111    F4 BF BF BF


UTF-16 encoding scheme

Code range hex        Unicode values binary                    Unicode values minus 10000             UTF-16 binary                         UTF-16 hex

00000000-0000FFFF     00000000 00000000 xxxxxxxx yyyyyyyy                                             xxxxxxxx yyyyyyyy
00000000              00000000 00000000 00000000 00000000                                             00000000 00000000                     00 00
         0000FFFF     00000000 00000000 11111111 11111111                                             11111111 11111111                     FF FF
00010000-0010FFFF     00000000 000xxxxx yyyyyyzz zzzzzzzz      00000000 0000wwww yyyyyyzz zzzzzzzz    110110ww wwyyyyyy 110110zz zzzzzzzz
  where xxxxx = wwww + 1 is within 00001-10000, and wwww = xxxxx - 1 is within 0000-1111
00010000              00000000 00000001 00000000 00000000      00000000 00000000 00000000 00000000    11011000 00000000 11011000 00000000   D8 00 D8 00
         0010FFFF     00000000 00010000 11111111 11111111      00000000 00001111 11111111 11111111    11011011 11111111 11011011 11111111   DB FF DB FF

*/

//***************************************************************************

/*

  Encoding types

  Certain functions in this file convert between the following encodings:

    ANSI        ASCII and extended ASCII
    UTF-8       Unicode 8 bit format
    UTF-16LE    Unicode 16 bit format, little endian type
    UTF-16BE    Unicode 16 bit format, big endian type

  Most Windows applications default to UTF-16LE when they write a text file
  or exchange text data that contains non-ANSI Unicode characters.  Other
  operating systems usually default to UTF-16BE.  UTF-8 is commonly used in
  web pages and email.  However, any type may be found in any of these
  contexts.

  If the encoding type is not clear from the context, it can often be
  determined from the byte order mark (BOM), found in the first few bytes of
  the data.  See UniType() below.

  The above types are represented by the numeric values below.  Use one of
  these values when a function requires a Unicode encoding type.

*/

#DEFINE UTYPE_ANSI          1  // ANSI
#DEFINE UTYPE_UTF8          2  // UTF-8
#DEFINE UTYPE_UTF16LE       3  // UTF-16 little endian (Windows default)
#DEFINE UTYPE_UTF16BE       4  // UTF-16 big endian (*nix default)

//***************************************************************************

/*

  Error codes

  Certain functions in this file may encounter invalid conditions, such as a
  string that contains invalid codes for a given Unicode encoding.  In such a
  situation, these functions raise an error using the current ERRORBLOCK and
  one of the error codes below.  See U8RaiseError().

*/

//#INCLUDE "ERROR.CH" // Required by U8RaiseError()

#DEFINE U8ES_INVALID_CODE        1  // Invalid Unicode code point
#DEFINE U8ES_INVALID_BYTE        2  // Invalid byte in UTF-8 string
#DEFINE U8ES_INVALID_END         3  // Invalid end of UTF-8 string
#DEFINE U8ES_INVALID_BYTE_16LE   4  // Invalid byte in UTF-16LE string
#DEFINE U8ES_INVALID_END_16LE    5  // Invalid end of UTF-16LE string
#DEFINE U8ES_INVALID_BYTE_16BE   6  // Invalid byte in UTF-16BE string
#DEFINE U8ES_INVALID_END_16BE    7  // Invalid end of UTF-16BE string

//***************************************************************************

/*

  ISASC()

  Determines whether a string contains only ASCII characters

  This function determines whether a string contains only characters in the
  ASCII range of 0 to 127 (decimal) = FF (hexadecimal).  It checks only
  individual byte values.  If used on a UTF-8 string, this function can
  determine that the string does not contain non-ASCII characters.

  Arguments:
    <cStr>    Required    String to be tested

  Returns:
    <lAsc>                Whether <cStr> contains only ASCII characters

*/

FUNCTION IsAsc(cStr)

LOCAL lIsAsc := .Y.
LOCAL lScan  := !EMPTY(LEN(cStr))
LOCAL nCode  := 0
LOCAL nLen   := LEN(cStr)
LOCAL nPos   := 1

WHILE lScan
  nCode := ASCPOS(cStr, nPos)
  IF nCode > 0x7F
    lIsAsc := .N.
  END
  nPos  ++
  lScan := lIsAsc .AND. nPos <= nLen
END

RETURN lIsAsc // IsAsc

//***************************************************************************

/*

  ISU8()

  Determines whether a string contains only valid UTF-8 characters

  This function determines whether a string contains only bytes that are
  valid in UTF-8 encoding.  It checks only that byte sequences represent code
  points that are within the Unicode range of 0 to 1114111 (decimal) = 10FFFF
  (hexadecimal).  It does not check whether code points within this range are
  assigned to Unicode characters.

  Arguments:
    <cStr>      Required    String to be tested

  Returns:
    <lU8>                   Whether <cStr> contains only UTF-8 characters

*/

FUNCTION IsU8(cStr)

LOCAL lIsU8  := .Y.
LOCAL lScan  := !EMPTY(LEN(cStr))
LOCAL nPos   := 1
LOCAL nByte1 := 0
LOCAL nByte2 := 0
LOCAL nByte3 := 0
LOCAL nByte4 := 0
LOCAL nBytes := 0
LOCAL nCode  := 0
LOCAL nLen   := LEN(cStr)

WHILE lScan
  nByte1 := ASCPOS(cStr, nPos)
  DO CASE
  CASE nByte1 >= 0x00 .AND. nByte1 <= 0x7F
    nBytes := 1
  CASE nByte1 >= 0xC2 .AND. nByte1 <= 0xDF
    nBytes := 2
    nByte2 := ASCPOS(cStr, nPos + 1)
    IF !(nByte2 >= 0x80 .AND. nByte2 <= 0xBF)
      lIsU8 := .N.
    END
  CASE nByte1 == 0xE0
    nBytes := 3
    nByte2 := ASCPOS(cStr, nPos + 1)
    nByte3 := ASCPOS(cStr, nPos + 2)
    IF !(nByte2 >= 0xA0 .AND. nByte2 <= 0xBF .AND. ;
      nByte3 >= 0x80 .AND. nByte3 <= 0xBF)
      lIsU8 := .N.
    END
  CASE nByte1 >= 0xE1 .AND. nByte1 <= 0xEF
    nBytes := 3
    nByte2 := ASCPOS(cStr, nPos + 1)
    nByte3 := ASCPOS(cStr, nPos + 2)
    IF !(nByte2 >= 0x80 .AND. nByte2 <= 0xBF .AND. ;
      nByte3 >= 0x80 .AND. nByte3 <= 0xBF)
      lIsU8 := .N.
    END
  CASE nByte1 >= 0xF0 .AND. nByte1 <= 0xF4
    nBytes := 4
    nByte2 := ASCPOS(cStr, nPos + 1)
    nByte3 := ASCPOS(cStr, nPos + 2)
    nByte4 := ASCPOS(cStr, nPos + 3)
    IF !( ;
      nByte2 >= 0x80 .AND. nByte2 <= 0xBF .AND. ;
      nByte3 >= 0x80 .AND. nByte3 <= 0xBF .AND. ;
      nByte4 >= 0x80 .AND. nByte4 <= 0xBF)
      lIsU8 := .N.
    END
  OTHERWISE
    lIsU8 := .N.
  END
  nPos  += nBytes
  lScan := lIsU8 .AND. nPos <= nLen
END

RETURN lIsU8 // IsU8

//***************************************************************************

/*

  U8ADDBOM()

  Adds a UTF-8 byte order mark to a string

  This function adds a byte order mark (BOM) to a UTF-8 string, unless the
  string already has one.

  Arguments:
    <cInStr>    Required    Input UTF-8 string with or witnout BOM

  Returns:
    <lOutStr>               Output UTF-8 string with BOM

*/

FUNCTION U8AddBom(cInStr)

LOCAL cBOM    := CHR(0xEF) + CHR(0xBB) + CHR(0xBF)
LOCAL cOutStr := IF(LEFT(cInStr, 3) == cBOM, cInStr, cBOM + cInStr)

RETURN cOutStr // U8AddBom

//***************************************************************************

/*

  U8AT()

  UTF-8 analog of AT()

  This function locates a UTF-8 string with another UTF-8 string.  It returns
  the character position of the first occurrence of the first string within
  the second string, or 0 if the search does not succeed.

  Arguments:
    <cSeaStr>   Required    UTF-8 substring to search for
    <cTargStr>  Required    UTF-8 string to search within

  Returns:
    <nChar>                 Character number within searched string

*/

FUNCTION U8At(cSeaStr, cTargStr)

LOCAL nChar := U8AtNum(cSeaStr, cTargStr, 1)

RETURN nChar // U8At

//***************************************************************************

/*

  U8ATNUM()

  UTF-8 analog of ATNUM()

  This function locates the n-th occurrence of a UTF-8 string with another
  UTF-8 string.  It returns the character position of the first string within
  the second string, or 0 if the search does not succeed.

  Arguments:
    <cSeaStr>   Required    UTF-8 substring to search for
    <cTargStr>  Required    UTF-8 string to search within
    <nRep>      Optional    Number of occurrences, default last occurrence

  Returns:
    <nChar>                 Character number within searched string

*/

FUNCTION U8AtNum(cSeaStr, cTargStr, nRep)

LOCAL lSeek    := !EMPTY(LEN(cSeaStr)) .AND. ;
  LEN(cSeaStr) <= LEN(cTargStr) .AND. (EMPTY(nRep) .OR. nRep > 0)
LOCAL nAtChar  := 1
LOCAL nByte    := 1
LOCAL nChar    := 1
LOCAL nOcc     := 0
LOCAL nSeaLen  := LEN(cSeaStr)
LOCAL nTargLen := LEN(cTargStr)

IF nRep == NIL
  nRep := 0
END

WHILE lSeek
  DO CASE
  CASE nByte + nSeaLen - 1 > nTargLen
    lSeek := .N.
  CASE cSeaStr == SUBSTR(cTargStr, nByte, nSeaLen)
    nOcc    ++
    nAtChar := nChar
    IF nOcc == nRep
      lSeek := .N.
    END
  END
  IF lSeek
    nByte := U8Inc(cTargStr, nByte)
    IF EMPTY(nByte)
      lSeek := .N.
    ELSE
      nChar ++
    END
  END
END

RETURN nAtChar // U8AtNum

//***************************************************************************

/*

  U8CHARBYTE()

  Converts character position to byte position within UTF-8 string

  This function converts a character position to its corresponding byte
  position within a UTF-8 string.  Character positions may differ from byte
  positions within a UTF-8 string, because a Unicode character may be
  represented by 1 to 4 bytes in UTF-8.

  If the character position is negative, the search starts from the end of
  the string, but the returned byte position is positive.  If the character
  position is not found within the string, the function returns 0.

  Arguments:
    <cStr>      Required    UTF-8 string to search
    <nChar>     Required    Character position

  Returns:
    <nByte>                 Byte position

*/

FUNCTION U8CharByte(cStr, nChars)

LOCAL lSeek  := !EMPTY(LEN(cStr))
LOCAL nByte  := 0
LOCAL nBytes := 1
LOCAL nChar  := 0

DO CASE
CASE nChars == 0

  nByte := 0

CASE nChars > 0

  nByte := 0
  WHILE lSeek
    nByte := U8Inc(cStr, nByte)
    IF EMPTY(nByte)
      lSeek := .N.
    ELSE
      nChar ++
      IF nChar == nChars
        lSeek := .N.
      END
    END
  END

CASE nChars < 0

  nByte := LEN(cStr) + 1
  WHILE lSeek
    nByte := U8Inc(cStr, nByte, -1)
    IF EMPTY(nByte)
      lSeek := .N.
    ELSE
      nChar --
      IF nChar == nChars
        lSeek := .N.
      END
    END
  END

END

RETURN nByte // U8CharByte

//***************************************************************************

/*

  U8CHARLEN()

  Computes length of Unicode character at byte position in UTF-8 string

  This function starts with a UTF-8 string and a byte position within the
  string.  The byte position should point to the first byte of a Unicode
  character.  The function returns the number of bytes that the Unicode
  character at that position occupies.  This value may range from 1 to 4.  If
  the byte position does not exist within the string, or the string is empty,
  the return value is 0.  If the byte position points to a byte which is not
  a valid first byte of a Unicode character, an error occurs.

  Arguments:
    <cStr>      Required    UTF-8 string to search
    <nPos>      Required    Byte position

  Returns:
    <nBytes>                Number of bytes

*/

FUNCTION U8CharLen(cStr, nPos)

LOCAL nByte1 := 0
LOCAL nByte2 := 0
LOCAL nByte3 := 0
LOCAL nByte4 := 0
LOCAL nBytes := 0
LOCAL nCode  := 0
LOCAL nLen   := LEN(cStr)

IF nPos == NIL
  nPos := 1
END
nByte1 := ASCPOS(cStr, nPos)
DO CASE
CASE EMPTY(nLen) .OR. nPos < 1 .OR. nPos > nLen
  nBytes := 0
CASE nByte1 >= 0x00 .AND. nByte1 <= 0x7F
  nBytes := 1
CASE nByte1 >= 0xC2 .AND. nByte1 <= 0xDF
  nBytes := 2
  nByte2 := ASCPOS(cStr, nPos + 1)
  IF !(nByte2 >= 0x80 .AND. nByte2 <= 0xBF)
    U8RaiseError(IF(nLen < nBytes, U8ES_INVALID_END, U8ES_INVALID_BYTE), ;
      {cStr, nPos})
  END
CASE nByte1 == 0xE0
  nBytes := 3
  nByte2 := ASCPOS(cStr, nPos + 1)
  nByte3 := ASCPOS(cStr, nPos + 2)
  IF !(nByte2 >= 0xA0 .AND. nByte2 <= 0xBF .AND. ;
    nByte3 >= 0x80 .AND. nByte3 <= 0xBF)
    U8RaiseError(IF(nLen < nBytes, U8ES_INVALID_END, U8ES_INVALID_BYTE), ;
      {cStr, nPos})
  END
CASE nByte1 >= 0xE1 .AND. nByte1 <= 0xEF
  nBytes := 3
  nByte2 := ASCPOS(cStr, nPos + 1)
  nByte3 := ASCPOS(cStr, nPos + 2)
  IF !(nByte2 >= 0x80 .AND. nByte2 <= 0xBF .AND. ;
    nByte3 >= 0x80 .AND. nByte3 <= 0xBF)
    U8RaiseError(IF(nLen < nBytes, U8ES_INVALID_END, U8ES_INVALID_BYTE), ;
      {cStr, nPos})
  END
CASE nByte1 >= 0xF0 .AND. nByte1 <= 0xF4
  nBytes := 4
  nByte2 := ASCPOS(cStr, nPos + 1)
  nByte3 := ASCPOS(cStr, nPos + 2)
  nByte4 := ASCPOS(cStr, nPos + 3)
  IF !( ;
    nByte2 >= 0x80 .AND. nByte2 <= 0xBF .AND. ;
    nByte3 >= 0x80 .AND. nByte3 <= 0xBF .AND. ;
    nByte4 >= 0x80 .AND. nByte4 <= 0xBF)
    U8RaiseError(IF(nLen < nBytes, U8ES_INVALID_END, U8ES_INVALID_BYTE), ;
      {cStr, nPos})
  END
OTHERWISE
  U8RaiseError(U8ES_INVALID_BYTE, {cStr, nPos})
END

RETURN nBytes // U8CharLen

//***************************************************************************

/*

  U8CHARLIST()

  UTF-8 analog of CHARLIST()

  This function builds a list of Unicode characters that occur within a
  given string.


  Arguments:
    <cStr>      Required    UTF-8 string to build list for

  Returns:
    <cList>                 UTF-8 string of Unicode characters in search string

*/

FUNCTION U8CharList(cStr)

LOCAL cChar  := ''
LOCAL cList  := ''
LOCAL lSeek  := !EMPTY(LEN(cStr))
LOCAL nBytes := 0
LOCAL nPos   := 1

WHILE lSeek
  nBytes := U8CharLen(cStr, nPos)
  IF EMPTY(nBytes)
    lSeek := .N.
  ELSE
    cChar := SUBSTR(cStr, nPos, nBytes)
    IF !(cChar $ cList)
      cList += cChar
    END
    nPos += nBytes
  END
END

RETURN cList // U8CharList

//***************************************************************************

/*

  U8CHR()

  UTF-8 analog of CHR()

  This function converts a numeric Unicode code point to a Unicode character
  encoded as a UTF-8 string.

  Arguments:
    <nCode>     Required    Unicode code point

  Returns:
    <cChar>                 Unicode character as UTF-8 string

*/

FUNCTION U8Chr(nCode)

LOCAL cChar  := ''
LOCAL nByte1 := 0
LOCAL nByte2 := 0
LOCAL nByte3 := 0
LOCAL nByte4 := 0

DO CASE
CASE nCode >= 0x00 .AND. nCode <= 0x7F
  cChar  := CHR(nCode)
CASE nCode >= 0x0080 .AND. nCode <= 0x07FF
  nByte2 := INT(nCode % 0x0040) + 0x80
  nCode  := INT(nCode / 0x0040)
  nByte1 :=     nCode           + 0xC0
  cChar  := CHR(nByte1) + CHR(nByte2)
CASE nCode >= 0x0800 .AND. nCode <= 0xFFFF
  nByte3 := INT(nCode % 0x0040) + 0x80
  nCode  := INT(nCode / 0x0040)
  nByte2 := INT(nCode % 0x0040) + 0x80
  nCode  := INT(nCode / 0x0040)
  nByte1 :=     nCode           + 0xE0
  cChar  := CHR(nByte1) + CHR(nByte2) + CHR(nByte3)
CASE nCode >= 0x00010000 .AND. nCode <= 0x0010FFFF
  nByte4 := INT(nCode % 0x0040) + 0x80
  nCode  := INT(nCode / 0x0040)
  nByte3 := INT(nCode % 0x0040) + 0x80
  nCode  := INT(nCode / 0x0040)
  nByte2 := INT(nCode % 0x0040) + 0x80
  nCode  := INT(nCode / 0x0040)
  nByte1 :=     nCode           + 0xF0
  cChar  := CHR(nByte1) + CHR(nByte2) + CHR(nByte3) + CHR(nByte4)
OTHERWISE
  U8RaiseError(U8ES_INVALID_CODE, {nCode})
END

RETURN cChar // U8Chr

//***************************************************************************

/*

  U8COD()

  UTF-8 analog of ASC()

  This function converts a Unicode character in a UTF-8 string to a numeric
  Unicode code point.  If the string contains more than one Unicode
  character, only the first character is converted.

  Arguments:
    <cChar>     Required    Unicode character as UTF-8 string
    <nBytes>    Optional    If used, pass by reference, see below

  Returns:
    <nCode>     Return      Unicode code point
    <nBytes>    Argument    Number of bytes used by character

*/

FUNCTION U8Cod(cStr, nBytes)

LOCAL nCode := 0

nBytes := U8CharLen(cStr)

DO CASE
CASE nBytes == 0
  nCode := 0
CASE nBytes == 1
  nCode := ASCPOS(cStr, 1)
CASE nBytes == 2
  nCode := INT( ;
    (ASCPOS(cStr, 1) % 0x20) * 0x0040 + ;
    (ASCPOS(cStr, 2) % 0x40)            )
CASE nBytes == 3
  nCode := INT( ;
    (ASCPOS(cStr, 1) % 0x10) * 0x1000 + ;
    (ASCPOS(cStr, 2) % 0x40) * 0x0040 + ;
    (ASCPOS(cStr, 3) % 0x40)            )
CASE nBytes == 4
  nCode := INT( ;
    (ASCPOS(cStr, 1) % 0x08) * 0x00040000 + ;
    (ASCPOS(cStr, 2) % 0x40) * 0x00001000 + ;
    (ASCPOS(cStr, 3) % 0x40) * 0x00000040 + ;
    (ASCPOS(cStr, 4) % 0x40)                )
END

RETURN nCode // U8Cod

//***************************************************************************

/*

  U8CODPOS()

  UTF-8 analog of ASCPOS()

  This function converts a Unicode character at a given position in a UTF-8
  string to a numeric Unicode code point.

  Arguments:
    <cStr>      Required    UTF-8 string to search
    <nChar>     Optional    Character position within <cStr>, default 1
    <nBytes>    Optional    If used, pass by reference, see below

  Returns:
    <nCode>     Return      Unicode code point
    <nBytes>    Argument    Number of bytes used by character

*/

FUNCTION U8CodPos(cStr, nChar, nBytes)

LOCAL nCode := U8Cod(U8SubStr(cStr, nChar, 1), @nBytes)

RETURN nCode // U8CodPos

//***************************************************************************

/*

  U8DELBOM()

  Deletes a UTF-8 byte order mark from a string

  This function removes a byte order mark (BOM) from a UTF-8 string if it has
  one.

  Arguments:
    <cInStr>    Required    Input string with or without BOM

  Returns:
    <lOutStr>               Output string without BOM

*/

FUNCTION U8DelBom(cInStr)

LOCAL cBOM    := CHR(0xEF) + CHR(0xBB) + CHR(0xBF)
LOCAL cOutStr := IF(LEFT(cInStr, 3) == cBOM, SUBSTR(cInStr, 4), cInStr)

RETURN cOutStr // U8DelBom

//***************************************************************************

/*

  U8INC()

  Moves byte pointer through UTF-8 string by given number of characters

  This function moves a byte pointer through a UTF-8 string.  This can be
  used to process a UTF-8 string one character at a time, or to skip
  backwards or forwards through a string by a given number of characters.

  If the old byte position points to a byte which is not a valid first byte
  of a Unicode character, an error occurs.

  For each forward motion by 1 character:  if the old byte position is 0, the
  new byte position is 1; if the old byte position points to the last
  character, the new byte position is the byte length of the string plus 1.

  For each backward motion by 1 character:  if the old byte position is the
  byte length of the string plus 1, the new byte position points to the last
  character; if the old byte position is 1, the new byte position is 0.

  If the old byte position is outside of the range of 0 to the byte length
  plus 1, the new byte position is the same as the old byte position.

  Arguments:
    <cStr>      Required    String to search through
    <nOByte>    Required    Old byte position
    <nChars>    Optional    Number of characters to move,
                            positive = skip forwards,
                            negative = skip backwards,
                            default 1

  Returns:
    <nNByte>                New byte position

*/

FUNCTION U8Inc(cStr, nOByte, nChars)

LOCAL lSeek   := .Y.
LOCAL nChar   := 0
LOCAL nCode   := 0
LOCAL nLen    := LEN(cStr)
LOCAL nIBytes := 0
LOCAL nNByte  := 0
LOCAL nSBytes := 0

DO CASE
CASE nChars == NIL .OR. nChars == 1

  nIBytes := IF(nOByte == 0, 1, U8CharLen(cStr, nOByte))
  nNByte  := nOByte + nIBytes

CASE nChars > 0

  WHILE lSeek
    nIBytes := IF(nOByte == 0, 1, U8CharLen(cStr, nOByte))
    nOByte  += nIBytes
    IF EMPTY(nIBytes)
      lSeek := .N.
    ELSE
      nChar ++
      IF nChar == nChars
        nNByte := nOByte
        lSeek  := .N.
      END
    END
  END

CASE nChars == -1

  nSBytes := ;
    IF(nOByte     >  nLen + 1, ;
    IF(nOByte - 1 <= nLen .AND. ;
      (nCode := ASCPOS(cStr, nOByte - 1)) >= 0x80 .AND. nCode <= 0xBF, ;
    IF(nOByte - 2 <= nLen .AND. ;
      (nCode := ASCPOS(cStr, nOByte - 2)) >= 0x80 .AND. nCode <= 0xBF, ;
    IF(nOByte - 3 <= nLen .AND. ;
      (nCode := ASCPOS(cStr, nOByte - 3)) >= 0x80 .AND. nCode <= 0xBF, ;
    4, 3), 2), 1), 0)
  IF !EMPTY(nSBytes)
    nIBytes := U8CharLen(cStr, nOByte - nSBytes)
    nNByte  := nOByte - nSBytes
  END

CASE nChars < 0

  WHILE lSeek
    nSBytes := ;
      IF(nOByte     >  nLen + 1, ;
      IF(nOByte - 1 <= nLen .AND. ;
        (nCode := ASCPOS(cStr, nOByte - 1)) >= 0x80 .AND. nCode <= 0xBF, ;
      IF(nOByte - 2 <= nLen .AND. ;
        (nCode := ASCPOS(cStr, nOByte - 2)) >= 0x80 .AND. nCode <= 0xBF, ;
      IF(nOByte - 3 <= nLen .AND. ;
        (nCode := ASCPOS(cStr, nOByte - 3)) >= 0x80 .AND. nCode <= 0xBF, ;
      4, 3), 2), 1), 0)
    IF EMPTY(nSBytes)
      lSeek := .N.
    ELSE
      nIBytes := U8CharLen(cStr, nOByte - nSBytes)
      nOByte  -= nSBytes
      IF EMPTY(nIBytes)
        lSeek := .N.
      ELSE
        nChar --
        IF nChar == nChars
          nNByte := nOByte
          lSeek  := .N.
        END
      END
    END
  END

CASE nChars == 0

  nIBytes := U8CharLen(cStr, nOByte)
  nNByte  := nOByte

END

RETURN nNByte // U8Inc

//***************************************************************************

/*

  U8LEFT()

  UTF-8 analog of LEFT()

  This function extracts a given number of characters from the beginning of a
  UTF-8 string.

  Arguments:
    <cInStr>    Required    UTF-8 string to extract from
    <nChars>    Required    Number of characters to extract

  Returns:
    <cOutStr>               Substring of <cInStr>

*/

FUNCTION U8Left(cInStr, nChars)

LOCAL cOutStr := ''
LOCAL lSeek   := !EMPTY(LEN(cInStr)) .AND. nChars > 0
LOCAL nByte   := 1
LOCAL nBytes  := 0
LOCAL nChar   := 0

WHILE lSeek
  nBytes := U8CharLen(cInStr, nByte)
  IF EMPTY(nBytes)
    lSeek := .N.
  ELSE
    cOutStr += SUBSTR(cInStr, nByte, nBytes)
    nByte   += nBytes
    nChar   ++
    IF nChar == nChars
      lSeek := .N.
    END
  END
END

RETURN cOutStr // U8Left

//***************************************************************************

/*

  U8LEN()

  UTF-8 analog of LEN()

  This function returns the number of Unicode characters in a UTF-8 string.

  Arguments:
    <cStr>      Required    UTF-8 string

  Returns:
    <nLen>                  Number of characters

*/

FUNCTION U8Len(cStr)

LOCAL lSeek := !EMPTY(LEN(cStr))
LOCAL nLen  := 0
LOCAL nByte := 1

WHILE lSeek
  nByte := U8Inc(cStr, nByte)
  IF EMPTY(nByte)
    lSeek := .N.
  ELSE
    nLen ++
  END
END

RETURN nLen // U8Len

//***************************************************************************

/*

  U8PADC()

  UTF-8 analog of PADC()

  This function extends or truncates a string equally on the left and right,
  so that the output has a given number of Unicode characters.

  Arguments:
    <cStr>      Required    UTF-8 string to extend or truncate
    <nChars>    Required    Number of characters in output
    <cFill>     Optional    Character to pad with, default blank

  Returns:
    <nPad>                  Padded UTF-8 string

*/

FUNCTION U8PadC(cStr, nChars, cFill)

LOCAL cPad  := ''
LOCAL nPad  := nChars - U8Len(cStr)
LOCAL nFill := IF(cFill == NIL, 0, LEN(cFill))
LOCAL nHal  := INT(nPad/2)

DO CASE
CASE nFill == 0
  cFill := ' '
CASE nFill > 1
  cFill := U8Left(cFill, 1)
END
DO CASE
CASE nPad == 0
  cPad := cStr
CASE nPad > 0
  cPad := REPLICATE(cFill, nHal) + cStr + REPLICATE(cFill, nPad - nHal)
CASE nPad < 0
  cPad := LEFT(cStr, U8Inc(cStr, LEN(cStr) + 1, nPad) - 1)
END

RETURN cPad // U8PadC

//***************************************************************************

/*

  U8PADL()

  UTF-8 analog of PADL()

  This function extends or truncates a string on the left, so that the output
  has a given number of Unicode characters.

  Arguments:
    <cStr>      Required    UTF-8 string to extend or truncate
    <nChars>    Required    Number of characters in output
    <cFill>     Optional    Character to pad with, default blank

  Returns:
    <nPad>                  Padded UTF-8 string

*/

FUNCTION U8PadL(cStr, nChars, cFill)

LOCAL cPad  := ''
LOCAL nPad  := nChars - U8Len(cStr)
LOCAL nFill := IF(cFill == NIL, 0, LEN(cFill))

DO CASE
CASE nFill == 0
  cFill := ' '
CASE nFill > 1
  cFill := U8Left(cFill, 1)
END
DO CASE
CASE nPad == 0
  cPad := cStr
CASE nPad > 0
  cPad := REPLICATE(cFill, nPad) + cStr
CASE nPad < 0
  cPad := LEFT(cStr, U8Inc(cStr, LEN(cStr) + 1, nPad) - 1)
END

RETURN cPad // U8PadL

//***************************************************************************

/*

  U8PADR()

  UTF-8 analog of PADR()

  This function extends or truncates a string on the right, so that the
  output has a given number of Unicode characters.

  Arguments:
    <cStr>      Required    UTF-8 string to extend or truncate
    <nChars>    Required    Number of characters in output
    <cFill>     Optional    Character to pad with, default blank

  Returns:
    <nPad>                  Padded UTF-8 string

*/

FUNCTION U8PadR(cStr, nChars, cFill)

LOCAL cPad  := ''
LOCAL nPad  := nChars - U8Len(cStr)
LOCAL nFill := IF(cFill == NIL, 0, LEN(cFill))

DO CASE
CASE nFill == 0
  cFill := ' '
CASE nFill > 1
  cFill := U8Left(cFill, 1)
END
DO CASE
CASE nPad == 0
  cPad := cStr
CASE nPad > 0
  cPad := cStr + REPLICATE(cFill, nPad)
CASE nPad < 0
  cPad := LEFT(cStr, U8Inc(cStr, LEN(cStr) + 1, nPad) - 1)
END

RETURN cPad // U8PadR

//***************************************************************************

/*

  U8RAISEERROR()

  Raises Unicode encoding error

  This procedure is used by UTF-8 functions to display an error message if an
  input string contains a byte that is invalid in UTF-8, or other similar
  errors.  It uses the current ERRORBLOCK.

*/

PROCEDURE U8RaiseError(nErr, aArgs)

LOCAL oErr := ERRORNEW()

LOCAL aErrors := { ;
  'Invalid Unicode code point'     , ; // U8ES_INVALID_CODE
  'Invalid byte in UTF-8 string'   , ; // U8ES_INVALID_BYTE
  'Invalid end of UTF-8 string'    , ; // U8ES_INVALID_END
  'Invalid byte in UTF-16LE string', ; // U8ES_INVALID_BYTE_16LE
  'Invalid end of UTF-16LE string' , ; // U8ES_INVALID_END_16LE
  'Invalid byte in UTF-16BE string', ; // U8ES_INVALID_BYTE_16BE
  'Invalid end of UTF-16BE string'   } // U8ES_INVALID_END_16BE

oErr:GENCODE     := EG_ARG
oErr:DESCRIPTION := PROCNAME(1) + ': ' + aErrors[nErr]
oErr:ARGS        := aArgs
oErr:SEVERITY    := 2
oErr:SUBSYSTEM   := 'UTF8FUNCTIONS'
EVAL(ERRORBLOCK(), oErr)

RETURN // U8RaiseError

//***************************************************************************

/*

  U8RAT()

  UTF-8 analog of RAT()

  This function locates a UTF-8 string with another UTF-8 string.  It returns
  the character position of the last occurrence of the first string within
  the second string, or 0 if the search does not succeed.

  Arguments:
    <cSeaStr>   Required    UTF-8 substring to search for
    <cTargStr>  Required    UTF-8 string to search within

  Returns:
    <nChar>                 Character number within searched string

*/

FUNCTION U8Rat(cSeaStr, cTargStr)

LOCAL nChar := U8AtNum(cSeaStr, cTargStr, 0)

RETURN nChar // U8Rat

//***************************************************************************

/*

  U8RIGHT()

  UTF-8 analog of RIGHT()

  This function extracts a given number of characters from the end of a UTF-8
  string.

  Arguments:
    <cInStr>    Required    UTF-8 string to extract from
    <nChars>    Required    Number of characters to extract

  Returns:
    <cOutStr>               Substring of <cInStr>

*/

FUNCTION U8Right(cInStr, nChars)

LOCAL cOutStr := ''
LOCAL lSeek   := !EMPTY(LEN(cInStr)) .AND. nChars > 0
LOCAL nChar   := 0
LOCAL nNByte  := 0
LOCAL nOByte  := LEN(cInStr) + 1

WHILE lSeek
  nNByte := U8Inc(cInStr, nOByte, -1)
  IF EMPTY(nNByte)
    lSeek := .N.
  ELSE
    cOutStr := SUBSTR(cInStr, nNByte, nOByte - nNByte) + cOutStr
    nOByte  := nNByte
    nChar   ++
    IF nChar == nChars
      lSeek := .N.
    END
  END
END

RETURN cOutStr // U8Right

//***************************************************************************

/*

  U8STUFF()

  UTF-8 analog of STUFF()

  This function inserts and deletes characters to and from a UTF-8 string,
  based on character positions within the string.

  Arguments:
    <cInStr>    Required    UTF-8 string to be changed
    <nAtChar>   Required    Character position to start at
    <nDelChar>  Required    Number of characters to delete
    <cAddStr>   Requires    UTF-8 string to insert

  Returns:
    <cOutStr>               Adjusted UTF-8 string

*/

FUNCTION U8Stuff(cInStr, nAtChar, nDelChar, cAddStr)

LOCAL cOutStr  := ''
LOCAL cPostStr := ''
LOCAL cPreStr  := ''
LOCAL nAtByte  := 1

IF nAtChar != NIL .AND. nAtChar > 0
  nAtByte := U8Inc(cInStr, 1, nAtChar - 1)
END
cPreStr := LEFT(cInStr, nAtByte - 1)
IF nDelChar != NIL .AND. nDelChar > 0
  nAtByte := U8Inc(cInStr, nAtByte, nDelChar)
ENDIF
cPostStr := SUBSTR(cInStr, nAtByte)
cOutStr := cPreStr + cAddStr + cPostStr

RETURN cOutStr // U8Stuff

//***************************************************************************

/*

  U8SUBSTR()

  UTF-8 analog of SUBSTR()

  This function extracts a given number of characters from the middle of a
  UTF-8 string.

  Arguments:
    <cInStr>    Required    UTF-8 string to extract from
    <nStChar>   Optional    Character position to start extracting from,
                            positive = start from beginning of string,
                            negative = start from end of string,
                            default 1
    <nChars>    Optional    Number of characters to extract,
                            default rest of string

  Returns:
    <cOutStr>               Substring of <cInStr>

*/

FUNCTION U8SubStr(cInStr, nStChar, nChars)

LOCAL cOutStr := ''
LOCAL nByte   := U8CharByte(cInStr, nStChar)
LOCAL nBytes  := 0
LOCAL nChar   := 0
LOCAL lSeek   := !EMPTY(LEN(cInStr)) .AND. nChars > 0 .AND. nByte > 0

WHILE lSeek
  nBytes := U8CharLen(cInStr, nByte)
  IF EMPTY(nBytes)
    lSeek := .N.
  ELSE
    cOutStr += SUBSTR(cInStr, nByte, nBytes)
    nByte   += nBytes
    nChar   ++
    IF nChar == nChars
      lSeek := .N.
    END
  END
END

RETURN cOutStr // U8SubStr

//***************************************************************************

/*

  U8TOUNI()

  Converts UTF-8 string to another Unicode encoding

  This function converts a UTF-8 string to ANSI or another Unicode encoding.
  If you convert to ANSI, non-ANSI characters are dropped from the output,
  and the optional <lDrop> flag is set.

  Arguments:
    <cInStr>    Required    UTF-8 string to convert
    <nType>     Required    One of the following:
                            UTYPE_ANSI - ANSI
                            UTYPE_UTF16LE - 16-bit little endian (Windows default)
                            UTYPE_UTF16BE - 16-bit big endian (*nix default)
    <lAddBom>   Optional    Whether to add a byte order mark, default .N.
    <lDrop>     Optional    If used, pass by reference, see below

  Returns:
    <cOutStr>   Return      String in <nType> encoding
    <lDrop>     Argument    Whether any characters were dropped from output

*/

FUNCTION U8ToUni(cInStr, nType, lAddBom, lDrop)

LOCAL cOutStr := ''
LOCAL lScan   := .Y.
LOCAL nByte   := 1
LOCAL nByte1  := 0
LOCAL nByte2  := 0
LOCAL nByte3  := 0
LOCAL nByte4  := 0
LOCAL nBytes  := 0
LOCAL nCode   := 0
LOCAL nCode1  := 0
LOCAL nCode2  := 0
LOCAL nLen    := LEN(cInStr)

lDrop := .N.

DO CASE
CASE nType == UTYPE_ANSI

  WHILE lScan
    IF nByte > nLen
      lScan := .N.
    ELSE
      nCode := U8Cod(SUBSTR(cInStr, nByte, 4), @nBytes)
      IF nBytes == 0
        lScan := .N.
      ELSE
        IF nCode <= 0xFF
          cOutStr += CHR(nCode)
        ELSE
          lDrop := .Y.
        END
        nByte += nBytes
      END
    END
  END

CASE nType == UTYPE_UTF8

  cOutStr := IF(EMPTY(lAddBom), cInStr, U8AddBom(cInStr))

CASE nType == UTYPE_UTF16LE

  IF !EMPTY(lAddBom)
    cOutStr := CHR(0xFF) + CHR(0xFE)
  END
  WHILE lScan
    IF nByte > nLen
      lScan := .N.
    ELSE
      nCode := U8Cod(SUBSTR(cInStr, nByte, 4), @nBytes)
      IF nBytes == 0
        lScan := .N.
      ELSE
        IF nCode <= 0xFFFF
          nByte1  := INT(nCode % 0x0100)
          nByte2  := INT(nCode / 0x0100)
          cOutStr += CHR(nByte1) + CHR(nByte2)
        ELSE
          nCode1  := INT(nCode % 0x0400)
          nCode2  := INT(nCode / 0x0400) - 0x0040
          nByte1  := INT(nCode1 % 0x0100)
          nByte2  := INT(nCode1 / 0x0100) + 0xD8
          nByte3  := INT(nCode2 % 0x0100)
          nByte4  := INT(nCode2 / 0x0100) + 0xD8
          cOutStr += CHR(nByte1) + CHR(nByte2) + CHR(nByte3) + CHR(nByte4)
        END
        nByte += nBytes
      END
    END
  END

CASE nType == UTYPE_UTF16BE

  IF !EMPTY(lAddBom)
    cOutStr := CHR(0xFE) + CHR(0xFF)
  END
  WHILE lScan
    IF nByte > nLen
      lScan := .N.
    ELSE
      nCode := U8Cod(SUBSTR(cInStr, nByte, 4), @nBytes)
      IF nBytes == 0
        lScan := .N.
      ELSE
        IF nCode <= 0xFFFF
          nByte1  := INT(nCode / 0x0100)
          nByte2  := INT(nCode % 0x0100)
          cOutStr += CHR(nByte1) + CHR(nByte2)
        ELSE
          nCode1  := INT(nCode / 0x0400) - 0x0040
          nCode2  := INT(nCode % 0x0400)
          nByte1  := INT(nCode1 / 0x0100) + 0xD8
          nByte2  := INT(nCode1 % 0x0100)
          nByte3  := INT(nCode2 / 0x0100) + 0xD8
          nByte4  := INT(nCode2 % 0x0100)
          cOutStr += CHR(nByte1) + CHR(nByte2) + CHR(nByte3) + CHR(nByte4)
        END
        nByte += nBytes
      END
    END
  END

END

RETURN cOutStr // U8ToUni

//***************************************************************************

/*

  UNIBOM()

  Returns Unicode byte order mark

  This function returns the byte order mark (BOM) for a given Unicode
  encoding.  A byte order mark can be useful to determining the type of
  Unicode encoding, and is normally used at the beginning of a text file.

  Arguments:
    <nType>     Required    One of the following:
                            UTYPE_ANSI - ANSI
                            UTYPE_UTF8 - UTF-8
                            UTYPE_UTF16LE - 16-bit little endian (Windows default)
                            UTYPE_UTF16BE - 16-bit big endian (*nix default)

  Returns:
    <cBOM>                  Byte order mark

*/

FUNCTION UniBom(nType)

LOCAL cBom := ''

DO CASE
CASE nType == UTYPE_UTF8
  cBom := CHR(0xEF) + CHR(0xBB) + CHR(0xBF)
CASE nType == UTYPE_UTF16LE
  cBom := CHR(0xFF) + CHR(0xFE)
CASE nType == UTYPE_UTF16BE
  cBom := CHR(0xFE) + CHR(0xFF)
END

RETURN cBom // UniBom

//***************************************************************************

/*

  UNITOU8()

  Converts a string in a non-UTF-8 Unicode encoding to UTF-8

  This function converts a string that contains text in ANSI or a Unicode
  encoding other than UTF-8 to UTF-8.

  Arguments:
    <cInStr>    Required    String in <nType> encoding
    <nType>     Optional    One of the following:
                            UTYPE_ANSI - ANSI
                            UTYPE_UTF16LE - 16-bit little endian (Windows default)
                            UTYPE_UTF16BE - 16-bit big endian (*nix default)
                            If omitted, get type from byte order mark
    <lDelBom>   Optional    Whether to delete byte order mark, default .N.

  Returns:
    <cOutStr>               Converted string

*/

FUNCTION UniToU8(cInStr, nType, lDelBom)

LOCAL cOutStr := ''
LOCAL nChar   := 1
LOCAL nCode   := 0
LOCAL nCode2  := 0
LOCAL nLen    := LEN(cInStr)
LOCAL nStart  := 1

IF nType == NIL
  nType := UniType(cInStr)
END

DO CASE
CASE nType == UTYPE_ANSI

  FOR nChar := nStart TO nLen
    nCode   := ASCPOS(cInStr, nChar)
    cOutStr += U8Chr(nCode)
  NEXT

CASE nType == UTYPE_UTF8

  cOutStr := IF(EMPTY(lDelBom), cInStr, U8DelBom(cInStr))

CASE nType == UTYPE_UTF16LE

  IF !EMPTY(INT(nLen % 2))
    U8RaiseError(U8ES_INVALID_END_16LE, {cInStr, lDelBom})
  END
  IF !EMPTY(lDelBom) .AND. LEFT(cInStr,2) == CHR(0xFF) + CHR(0xFE)
    nStart := 3
  END
  FOR nChar := nStart TO nLen STEP 2
    nCode := ASCPOS(cInStr, nChar + 1) * 0x0100 + ASCPOS(cInStr, nChar)
    IF nCode >= 0xD800 .AND. nCode <= 0xDBFF
      IF nLen < nChar + 3
        U8RaiseError(U8ES_INVALID_END_16LE, {cInStr, lDelBom})
      END
      nCode2 := ;
        ASCPOS(cInStr, nChar + 3) * 0x0100 + ;
        ASCPOS(cInStr, nChar + 2)
      IF nCode2 < 0xD800 .OR. nCode > 0xDBFF
        U8RaiseError(U8ES_INVALID_BYTE_16LE, {cInStr, lDelBom})
      END
      nCode := (nCode - 0xD800 + 0x0040) * 0x00010000 + nCode2 - 0xD800
      nChar += 2
    END
    cOutStr += U8Chr(nCode)
  NEXT

CASE nType == UTYPE_UTF16BE

  IF !EMPTY(INT(nLen % 2))
    U8RaiseError(U8ES_INVALID_END_16BE, {cInStr, lDelBom})
  END
  IF !EMPTY(lDelBom) .AND. LEFT(cInStr,2) == CHR(0xFE) + CHR(0xFF)
    nStart := 3
  END
  FOR nChar := nStart TO nLen STEP 2
    nCode := ASCPOS(cInStr, nChar) * 0x0100 + ASCPOS(cInStr, nChar + 1)
    IF nCode >= 0xD800 .AND. nCode <= 0xDBFF
      IF nLen < nChar + 3
        U8RaiseError(U8ES_INVALID_END_16BE, {cInStr, lDelBom})
      END
      nCode2 := ;
        ASCPOS(cInStr, nChar + 2) * 0x0100 + ;
        ASCPOS(cInStr, nChar + 3)
      IF nCode2 < 0xD800 .OR. nCode > 0xDBFF
        U8RaiseError(U8ES_INVALID_BYTE_16BE, {cInStr, lDelBom})
      END
      nCode := (nCode - 0xD800 + 0x0040) * 0x00010000 + nCode2 - 0xD800
      nChar += 2
    END
    cOutStr += U8Chr(nCode)
  NEXT

END

RETURN cOutStr // UniToU8

//***************************************************************************

/*

  UNITYPE()

  Determine Unicode encoding type from byte order mark

  This function determines the type of Unicode encoding in a string from the
  byte order mark (BOM) at the beginning of the string.  If a BOM is not
  found, the string is assumed to be ANSI.  This is the usual assumption that
  Unicode applications make when they open a text file.

  Arguments:
    <cStr>      Required    String to be examined

  Returns:
    <nType>                 One of the following:
                            UTYPE_ANSI - ANSI
                            UTYPE_UTF8 - UTF-8
                            UTYPE_UTF16LE - 16-bit little endian
                            UTYPE_UTF16BE - 16-bit big endian

*/

FUNCTION UniType(cStr)

LOCAL nByte1 := 0
LOCAL nByte2 := 0
LOCAL nByte3 := 0
LOCAL nByte4 := 0
LOCAL nType  := 0

nByte1 := ASCPOS(cStr, 1)
nByte2 := ASCPOS(cStr, 2)
nByte3 := ASCPOS(cStr, 3)
nByte4 := ASCPOS(cStr, 4)
DO CASE
CASE nByte1 == 0xEF .AND. nByte2 == 0xBB .AND. nByte3 == 0xBF
  nType := UTYPE_UTF8
CASE nByte1 == 0xFF .AND. nByte2 == 0xFE
  nType := UTYPE_UTF16LE
CASE nByte1 == 0xFE .AND. nByte2 == 0xFF
  nType := UTYPE_UTF16BE
OTHERWISE
  nType := UTYPE_ANSI
END

RETURN nType // UniType

//***************************************************************************

/*

ARRAY STYLE UNICODE FUNCTIONS

FUNCTION SUMMARIES

UNICODETYPE()       Determines the encoding of a Unicode byte stream
UNICODEBOM()        Returns byte order mark
UNICODEEOL()        Returns end of line byte series
UNICODESWAP()       Pairwise reverses order of bytes
UNICODE2ARRAY()     Converts Unicode byte stream to array of character codes
ARRAY2UNICODE()     Converts array of Unicode character codes to byte stream
UNICODEREADLINE()   Reads one line from Unicode text file
PAIRTRAN()          Analog of STRTRAN() for 16 bit Unicode

FUNCTION OUTLINES

UnicodeType(cStr) -> nType
UnicodeBOM(nType) -> cBOM
UnicodeEOL(nType) -> cEOL
UnicodeSwap(cInStr) -> cOutStr
Unicode2Array(cStr, nType, aPoses) -> aCodes
Array2Unicode(aCodes, nType, bOut) -> cStr
UnicodeReadLine(nHandle, nType, lInit, lRead) -> cLine
PairTran(cStr, cOldPair, cNewPair) -> cStr

EXAMPLES

Example 1:  In a Unicode text file, replace all dotted circle characters
(U+25CC) with blanks.

  cFile  := 'Sample.txt'
  cStr   := MEMOREAD(cFile)
  nType  := UnicodeType(cStr)
  aCodes := Unicode2Array(cStr, nType)
  nLen   := LEN(aCodes)
  FOR nPos := 2 TO nLen  // Start at position 2 to skip byte order mark
    nCode := aCodes[nPos]
    IF nCode == 0x25CC
      aCodes[nPos] := 0x0020
    END
  NEXT
  cStr := Array2Unicode(aCodes, nType)
  MEMOWRIT(cFile, cStr)

Example 2:  Same as example 1 but with a Rich Edit Box instead of a text
file.

  cStr   := wMain.rbRichEditBox.RichValue(RICHVALUE_UTF16_TEXT)
  aCodes := Unicode2Array(cStr, TXT_UTF16LE)
  nLen   := LEN(aCodes)
  FOR nPos := 1 TO nLen  // Rich edit box does not have byte order mark
    nCode := aCodes[nPos]
    IF nCode == 0x25CC
      aCodes[nPos] := 0x0020
    END
  NEXT
  cStr := Array2Unicode(aCodes, TXT_UTF16LE)
  wMain.rbRichEditBox.RichValue(RICHVALUE_UTF16_TEXT) := cStr

Example 3:  Same as example 1 but reading the file line by line instead of
all at once.

  cFile1   := 'Sample.txt'
  cFile2   := 'Temp.txt'
  nHandle1 := FOPEN(cFile1)
  nHandle2 := FCREATE(cFile2)
  nBytes   := FREAD(nHandle1, @cLine, 4)
  cLine    := LEFT(cLine, nBytes)
  nType    := UnicodeType(cLine)
  lInit    := .Y.
  lRead    := .Y.
  FSEEK(nHandle1, 0)
  WHILE lRead
    cLine  := UnicodeReadLine(nHandle1, nType, @lInit, @lRead)
    IF lRead
      aCodes := Unicode2Array(cLine, nType)
      nLen   := LEN(aCodes)
      FOR nPos := 1 TO nLen
        nCode := aCodes[nPos]
        IF nCode == 0x25CC
          aCodes[nPos] := 0x0020
        END
      NEXT
      cLine := Array2Unicode(aCodes, nType)
      FWRITE(nHandle2, cLine)
    END
  END
  FCLOSE(nHandle1)
  FCLOSE(nHandle2)
  FERASE(cFile1)
  FRENAME(cFile2, cFile1)

*/

//***************************************************************************

/*

  Encoding types

  The functions in this file support the following encodings.

    ANSI        ASCII and extended ASCII
    UTF-8       Unicode 8 bit format
    UTF-16LE    Unicode 16 bit format, little endian type
    UTF-16BE    Unicode 16 bit format, big endian type

  These types are represented by the numeric values below.  Use one of these
  values when a function requires a Unicode encoding type.

*/

#DEFINE TXT_ANSI            1
#DEFINE TXT_UTF8            2
#DEFINE TXT_UTF16LE         3
#DEFINE TXT_UTF16BE         4

//***************************************************************************

/*

  UNICODETYPE()

  Determines the encoding of a Unicode byte stream

  This function assumes that the byte stream contains a BOM (byte order
  mark).  This is usually the case with TXT files, but not with RICHVALUE
  buffers.  However, in the case of RICHVALUE, you specify the encoding,
  whereas when you read a TXT file, you may not know the encoding.

  Arguments:
    <cStr>    Required    Unicode byte stream

  Returns:
    <nType>               Unicode encoding type

*/

FUNCTION UnicodeType(cStr)

LOCAL nByte1 := 0
LOCAL nByte2 := 0
LOCAL nByte3 := 0
LOCAL nByte4 := 0
LOCAL nChar  := 1
LOCAL nCode  := 0
LOCAL nCtrl  := 0
LOCAL nLen   := LEN(cStr)
LOCAL nType  := 0

nByte1 := IF(nLen >= 1, ASC(SUBSTR(cStr, 1, 1)), 0)
nByte2 := IF(nLen >= 2, ASC(SUBSTR(cStr, 2, 1)), 0)
nByte3 := IF(nLen >= 3, ASC(SUBSTR(cStr, 3, 1)), 0)
nByte4 := IF(nLen >= 4, ASC(SUBSTR(cStr, 4, 1)), 0)
DO CASE
CASE nByte1 == 0xEF .AND. nByte2 == 0xBB .AND. nByte3 == 0xBF
  nType := TXT_UTF8
CASE nByte1 == 0xFF .AND. nByte2 == 0xFE
  nType := TXT_UTF16LE
CASE nByte1 == 0xFE .AND. nByte2 == 0xFF
  nType := TXT_UTF16BE
OTHERWISE
  nType := TXT_ANSI
END

RETURN nType // UnicodeType

//***************************************************************************

/*

  UNICODEBOM()

  Returns byte order mark

  This function returns the byte order mark for various Unicode encodings.

  Arguments:
    <nType>   Required    Unicode encoding type

  Returns:
    <cBOM>                Byte order mark as a Unicode byte stream

*/

FUNCTION UnicodeBOM(nType)

LOCAL cBOM := ''

DO CASE
CASE nType == TXT_UTF8
  cBOM := CHR(0xEF) + CHR(0xBB) + CHR(0xBF)
CASE nType == TXT_UTF16LE
  cBOM := CHR(0xFF) + CHR(0xFE)
CASE nType == TXT_UTF16BE
  cBOM := CHR(0xFE) + CHR(0xFF)
END

RETURN cBOM // UnicodeBOM

//***************************************************************************

/*

  UNICODEEOL

  Returns end of line byte series

  This function returns the end of line byte series for various Unicode
  encodings.

  Arguments:
    <nType>   Required    Unicode encoding type

  Returns:
    <cEOL>                End of line as a Unicode byte stream

*/

FUNCTION UnicodeEOL(nType)

LOCAL cEOL  := ''

DO CASE
CASE nType == TXT_ANSI
  cEOL := CHR(0x0D) + CHR(0x0A)
CASE nType == TXT_UTF8
  cEOL := CHR(0x0D) + CHR(0x0A)
CASE nType == TXT_UTF16LE
  cEOL := CHR(0x0D) + CHR(0x00) + CHR(0x0A) + CHR(0x00)
CASE nType == TXT_UTF16BE
  cEOL := CHR(0x00) + CHR(0x0D) + CHR(0x00) + CHR(0x0A)
END

RETURN cEOL // UnicodeEOL

//***************************************************************************

/*

  UNICODESWAP()

  Pairwise reverses order of bytes

  This function reverses the order of pairs of bytes.  It is useful to
  convert between a UTF-16LE and a UTF-16BE byte stream.

  Arguments:
    <cInStr>  Required    Original Unicode byte stream

  Returns:
    <cOutStr>             Reversed Unicode byte stream

*/

FUNCTION UnicodeSwap(cInStr)

LOCAL cOutStr := ''
LOCAL nChar   := 1
LOCAL nLen    := LEN(cInStr)

FOR nChar := 1 TO nLen STEP 2
  cOutStr += SUBSTR(cInStr, nChar + 1, 1) + SUBSTR(cInStr, nChar, 1)
NEXT

RETURN cOutStr // UnicodeSwap

//***************************************************************************

/*

  UNICODE2ARRAY()

  Converts Unicode byte stream to array of character codes

  This function converts a Unicode byte stream to an array of numeric Unicode
  character codes.

  Arguments:
    <cStr>    Required    Unicode byte stream
    <nType>   Required    Unicode encoding type
    <aPoses>  Optional    If used, pass by reference, and see below.

  Returns:
    <aCodes>  Return      Array of Unicode character codes
    <aPoses>  Argument    Array of starting positions within the byte stream
                          of corresponding codes in aCodes.

*/

FUNCTION Unicode2Array(cStr, nType, aPoses)

LOCAL aCodes := {}
LOCAL nByte1 := ASC(SUBSTR(cStr, 1, 1))
LOCAL nByte2 := ASC(SUBSTR(cStr, 2, 1))
LOCAL nByte3 := ASC(SUBSTR(cStr, 3, 1))
LOCAL nByte4 := ASC(SUBSTR(cStr, 4, 1))
LOCAL nBytes := 1
LOCAL nChar  := 1
LOCAL nCode  := 0
LOCAL nCode1 := 0
LOCAL nCode2 := 0
LOCAL nLen   := LEN(cStr)
LOCAL nPos   := 1

/*

UTF-8

Code range hex        Unicode values biniary                   UTF-8 binary                           UTF-8 hex

00000000-0000007F     00000000 00000000 00000000 0zzzzzzz      0zzzzzzz
00000000              00000000 00000000 00000000 00000000      00000000                               00
         0000007F     00000000 00000000 00000000 01111111      01111111                               7F
00000080-000007FF     00000000 00000000 00000yyy yyzzzzzz      110yyyyy 10zzzzzz
00000080              00000000 00000000 00000000 10000000      11000010 10000000                      C2 80
         000007FF     00000000 00000000 00000111 11111111      11011111 10111111                      DF BF
00000800-0000FFFF     00000000 00000000 xxxxyyyy yyzzzzzz      1110xxxx 10yyyyyy 10zzzzzz
00000800              00000000 00000000 00001000 00000000      11100000 10100000 10000000             E0 A0 80
         0000FFFF     00000000 00000000 11111111 11111111      11101111 10111111 10111111             EF BF BF
00010000-0010FFFF     00000000 000wwwxx xxxxyyyy yyzzzzzz      11110www 10xxxxxx 10yyyyyy 10zzzzzz
00010000              00000000 00000001 00000000 00000000      11110000 10000000 10000000 10000000    F0 80 80 80
         0010FFFF     00000000 00010000 11111111 11111111      11110100 10111111 10111111 10111111    F4 BF BF BF

UTF-16

Code range hex        Unicode values binary                    Unicode values minus 10000             UTF-16 binary                         UTF-16 hex

00000000-0000FFFF     00000000 00000000 xxxxxxxx yyyyyyyy                                             xxxxxxxx yyyyyyyy
00000000              00000000 00000000 00000000 00000000                                             00000000 00000000                     00 00
         0000FFFF     00000000 00000000 11111111 11111111                                             11111111 11111111                     FF FF
00010000-0010FFFF     00000000 000xxxxx yyyyyyzz zzzzzzzz      00000000 0000wwww yyyyyyzz zzzzzzzz    110110ww wwyyyyyy 110110zz zzzzzzzz
  where xxxxx = wwww + 1 is within 00001-10000, and wwww = xxxxx - 1 is within 0000-1111
00010000              00000000 00000001 00000000 00000000      00000000 00000000 00000000 00000000    11011000 00000000 11011000 00000000   D8 00 D8 00
         0010FFFF     00000000 00010000 11111111 11111111      00000000 00001111 11111111 11111111    11011011 11111111 11011011 11111111   DB FF DB FF
*/

aPoses := {}

FOR nPos := 1 TO nLen

  DO CASE
  CASE nType == TXT_ANSI

    nBytes := 1
    nCode  := nByte1

  CASE nType == TXT_UTF8

    DO CASE
    CASE nByte1 >= 0x00 .AND. nByte1 <= 0x7F
      nBytes := 1
      nCode  := nByte1
    CASE nByte1 >= 0xC2 .AND. nByte1 <= 0xDF
      IF nByte2 >= 0x80 .AND. nByte2 <= 0xBF
        nBytes := 2
        nCode  := INT( ;
          (nByte1 % 0x20) * 0x0040 + ;
          (nByte2 % 0x40)            )
      ELSE
        nBytes := 1
        nCode  := -1
      END
    CASE nByte1 == 0xE0
      IF ;
        nByte2 >= 0xA0 .AND. nByte2 <= 0xBF .AND. ;
        nByte3 >= 0x80 .AND. nByte3 <= 0xBF
        nBytes := 3
        nCode  := INT( ;
          (nByte1 % 0x10) * 0x1000 + ;
          (nByte2 % 0x40) * 0x0040 + ;
          (nByte3 % 0x40)            )
      ELSE
        nBytes := 1
        nCode  := -1
      END
    CASE nByte1 >= 0xE1 .AND. nByte1 <= 0xEF
      IF ;
        nByte2 >= 0x80 .AND. nByte2 <= 0xBF .AND. ;
        nByte3 >= 0x80 .AND. nByte3 <= 0xBF
        nBytes := 3
        nCode  := INT( ;
          (nByte1 % 0x10) * 0x1000 + ;
          (nByte2 % 0x40) * 0x0040 + ;
          (nByte3 % 0x40)            )
      ELSE
        nBytes := 1
        nCode  := -1
      END
    CASE nByte1 >= 0xF0 .AND. nByte1 <= 0xF4
      IF ;
        nByte2 >= 0x80 .AND. nByte2 <= 0xBF .AND. ;
        nByte3 >= 0x80 .AND. nByte3 <= 0xBF .AND. ;
        nByte4 >= 0x80 .AND. nByte4 <= 0xBF
        nBytes := 4
        nCode  := INT( ;
          (nByte1 % 0x08) * 0x00040000 + ;
          (nByte2 % 0x40) * 0x00001000 + ;
          (nByte3 % 0x40) * 0x00000040 + ;
          (nByte4 % 0x40)                )
      ELSE
        nBytes := 1
        nCode  := -1
      END
    OTHERWISE
      nBytes := 1
      nCode  := -1
    END

  CASE nType == TXT_UTF16LE

    nCode1 := nByte1 + nByte2 * 0x0100
    IF !(nCode1 >= 0xD800 .AND. nCode1 <= 0xDBFF)
      nBytes := 2
      nCode  := nCode1
    ELSE
      nBytes := 4
      nCode1 -= 0xD800
      nCode2 := nByte3 + nByte4 * 0x0100 - 0xD800 + 0x0040
      nCode  := nCode1 + nCode2 * 0x00010000
    END

  CASE nType == TXT_UTF16BE

    nCode1 := nByte1 * 0x0100 + nByte2
    IF !(nCode1 >= 0xD800 .AND. nCode1 <= 0xDBFF)
      nBytes := 2
      nCode  := nCode1
    ELSE
      nBytes := 4
      nCode1 -= 0xD800 + 0x0040
      nCode2 := nByte3 * 0x0100 + nByte4 - 0xD800
      nCode  := nCode1 * 0x00010000 + nCode2
    END

  END

  DO CASE
  CASE nBytes == 1
    nByte1 := nByte2
    nByte2 := nByte3
    nByte3 := nByte4
    nByte4 := ASC(SUBSTR(cStr, nPos + 4, 1))
  CASE nBytes == 2
    nPos   ++
    nByte1 := nByte3
    nByte2 := nByte4
    nByte3 := ASC(SUBSTR(cStr, nPos + 3, 1))
    nByte4 := ASC(SUBSTR(cStr, nPos + 4, 1))
  CASE nBytes == 3
    nPos   += 2
    nByte1 := nByte4
    nByte2 := ASC(SUBSTR(cStr, nPos + 2, 1))
    nByte3 := ASC(SUBSTR(cStr, nPos + 3, 1))
    nByte4 := ASC(SUBSTR(cStr, nPos + 4, 1))
  CASE nBytes == 4
    nPos   += 3
    nByte1 := ASC(SUBSTR(cStr, nPos + 1, 1))
    nByte2 := ASC(SUBSTR(cStr, nPos + 2, 1))
    nByte3 := ASC(SUBSTR(cStr, nPos + 3, 1))
    nByte4 := ASC(SUBSTR(cStr, nPos + 4, 1))
  END

  AADD(aCodes, nCode)
  AADD(aPoses, nPos )

NEXT

RETURN aCodes // Unicode2Array

//***************************************************************************

/*

  ARRAY2UNICODE()

  Converts array of Unicode character codes to byte stream

  This function converts an array of numeric Unicode character codes to a
  Unicode byte stream.

  Arguments:
    <aCodes>  Required    Array of Unicode character codes
    <nType>   Required    Unicode encoding type
    <bOut>    Optional    Code block to evaluate when a code is out of
                          Unicode range.  Two arguments are passed:
                          <nCode>   The code that is out of range
                          <nPos>    The position of nCode within aCodes

  Returns:
    <cStr>                Unicode byte stream

*/

FUNCTION Array2Unicode(aCodes, nType, bOut)

LOCAL cStr   := ''
LOCAL lCr    := .N.
LOCAL nByte1 := 0
LOCAL nByte2 := 0
LOCAL nByte3 := 0
LOCAL nByte4 := 0
LOCAL nLen   := LEN(aCodes)
LOCAL nPos   := 1
LOCAL nCode  := 0
LOCAL nCode1 := 0
LOCAL nCode2 := 0

IF EMPTY(bOut)
  bOut := {|| .Y.}
END

FOR nPos := 1 TO nLen

  nCode := aCodes[nPos]

  DO CASE
  CASE nType == TXT_ANSI

    IF nCode >= 0x00 .AND. nCode <= 0xFF
      cStr += CHR(nCode)
    ELSE
      IF !bOut:EVAL(nCode, nPos)
        BREAK
      END
    END

  CASE nType == TXT_UTF8

    DO CASE
    CASE nCode >= 0x00 .AND. nCode <= 0x7F
      cStr += CHR(nCode)
    CASE nCode >= 0x0080 .AND. nCode <= 0x07FF
      nByte2 := INT(nCode % 0x0040) + 0x80
      nCode  := INT(nCode / 0x0040)
      nByte1 :=     nCode           + 0xC0
      cStr   += CHR(nByte1) + CHR(nByte2)
    CASE nCode >= 0x0800 .AND. nCode <= 0xFFFF
      nByte3 := INT(nCode % 0x0040) + 0x80
      nCode  := INT(nCode / 0x0040)
      nByte2 := INT(nCode % 0x0040) + 0x80
      nCode  := INT(nCode / 0x0040)
      nByte1 :=     nCode           + 0xE0
      cStr   += CHR(nByte1) + CHR(nByte2) + CHR(nByte3)
    CASE nCode >= 0x00010000 .AND. nCode <= 0x0010FFFF
      nByte4 := INT(nCode % 0x0040) + 0x80
      nCode  := INT(nCode / 0x0040)
      nByte3 := INT(nCode % 0x0040) + 0x80
      nCode  := INT(nCode / 0x0040)
      nByte2 := INT(nCode % 0x0040) + 0x80
      nCode  := INT(nCode / 0x0040)
      nByte1 :=     nCode           + 0xF0
      cStr   += CHR(nByte1) + CHR(nByte2) + CHR(nByte3) + CHR(nByte4)
    OTHERWISE
      IF !bOut:EVAL(nCode, nPos)
        BREAK
      END
    END

  CASE nType == TXT_UTF16LE

    IF nCode >= 0x00000000 .AND. nCode <= 0x0010FFFF
      IF !(nCode >= 0x00010000 .AND. nCode <= 0x0010FFFF)
        nByte1 := INT(nCode % 0x0100)
        nByte2 := INT(nCode / 0x0100)
        cStr   += CHR(nByte1) + CHR(nByte2)
      ELSE
        nCode1 := INT(nCode % 0x0400)
        nCode2 := INT(nCode / 0x0400) - 0x0040
        nByte1 := INT(nCode1 % 0x0100)
        nByte2 := INT(nCode1 / 0x0100) + 0xD8
        nByte3 := INT(nCode2 % 0x0100)
        nByte4 := INT(nCode2 / 0x0100) + 0xD8
        cStr   += CHR(nByte1) + CHR(nByte2) + CHR(nByte3) + CHR(nByte4)
      END
    ELSE
      IF !bOut:EVAL(nCode, nPos)
        BREAK
      END
    END

  CASE nType == TXT_UTF16BE

    IF nCode >= 0x00000000 .AND. nCode <= 0x0010FFFF
      IF !(nCode >= 0x00010000 .AND. nCode <= 0x0010FFFF)
        nByte1 := INT(nCode / 0x0100)
        nByte2 := INT(nCode % 0x0100)
        cStr   += CHR(nByte1) + CHR(nByte2)
      ELSE
        nCode1 := INT(nCode / 0x0400) - 0x0040
        nCode2 := INT(nCode % 0x0400)
        nByte1 := INT(nCode1 / 0x0100) + 0xD8
        nByte2 := INT(nCode1 % 0x0100)
        nByte3 := INT(nCode2 / 0x0100) + 0xD8
        nByte4 := INT(nCode2 % 0x0100)
        cStr   += CHR(nByte1) + CHR(nByte2) + CHR(nByte3) + CHR(nByte4)
      END
    ELSE
      IF !bOut:EVAL(nCode, nPos)
        BREAK
      END
    END

  END

NEXT

RETURN cStr // Array2Unicode

//***************************************************************************

/*

  UNICODEREADLINE()

  Reads one line from Unicode text file

  This function reads one line from an ANSI or Unicode text file to a Unicode
  byte stream.

  Arguments:
    <nHandle> Required    Handle returned by FOPEN()
    <nType>   Required    Unicode encoding type
    <lInit>   Required    Pass by reference, set to .Y. before first use,
                          and see below.
    <lRead>   Required    Pass by reference, and see below.

  Returns:
    <cLine>   Return      Line of file as a Unicode byte stream.  Does not
                          include end of line characters.
    <lInit>   Argument    Set to .N. after first use.
    <lRead>   Argument    Set to .N. when last line has been read.

*/


FUNCTION UnicodeReadLine(nHandle, nType, lInit, lRead)

STATIC cScan   := ''
STATIC lCr     := .N.
STATIC lScan   := .Y.

LOCAL cBuffer  := ''
LOCAL cLine    := ''
LOCAL nBufLen  := 0x800
LOCAL nBufRead := 0
LOCAL nPos     := 0

LOCAL cCR      := CHR(0x0D)
LOCAL cLF      := CHR(0x0A)
LOCAL cCRLF    := CHR(0x0D) + CHR(0x0A)
LOCAL cFF      := CHR(0x0C)
LOCAL cNel     := CHR(0xC2) + CHR(0x85)
LOCAL cLS      := CHR(0xE2) + CHR(0x80) + CHR(0xA8)
LOCAL cPS      := CHR(0xE2) + CHR(0x80) + CHR(0xA9)

IF lInit
  cScan   := ''
  lCr     := .N.
  lScan   := .Y.
  lInit   := .N.
  lRead   := .Y.
  DO CASE
  CASE nType == TXT_UTF8
    FSEEK(nHandle, 3)
  CASE nType == TXT_UTF16LE
    FSEEK(nHandle, 2)
  CASE nType == TXT_UTF16BE
    FSEEK(nHandle, 2)
  OTHERWISE
    FSEEK(nHandle, 0)
  END
END

DO CASE
CASE nType == TXT_ANSI

  WHILE EMPTY(nPos)

    nPos := AT(cCR, cScan)
    DO CASE
    CASE !EMPTY(nPos)
      cLine := LEFT(cScan, nPos - 1)
      cScan := SUBSTR(cScan, nPos + 1)
    CASE lScan
      cBuffer  := SPACE(nBufLen)
      nBufRead := FREAD(nHandle, @cBuffer, nBufLen)
      lScan    := (nBufRead == nBufLen)
      IF !lScan
        cBuffer := LEFT(cBuffer, nBufRead)
      END
      IF lCr .AND. LEFT(cBuffer, 1) == cLF
        cBuffer := SUBSTR(cBuffer, 2)
      END
      lCr     := (RIGHT(cBuffer, 1) == cCR)
      cBuffer := STRTRAN(STRTRAN(STRTRAN(cBuffer, ;
        cCRLF, cCR), cLF, cCR), cFF, cCR)
      IF !lScan .AND. RIGHT(cBuffer, 1) == cCR
        cBuffer := LEFT(cBuffer, LEN(cBuffer) - 1)
      END
      cScan += cBuffer
    OTHERWISE
      cLine := cScan
      cScan := ''
      lRead := .N.
      nPos  := 1
    END

  END

CASE nType == TXT_UTF8

  WHILE EMPTY(nPos)

    nPos := AT(cCR, cScan)
    DO CASE
    CASE !EMPTY(nPos)
      cLine := LEFT(cScan, nPos - 1)
      cScan := SUBSTR(cScan, nPos + 1)
    CASE lScan
      cBuffer  := SPACE(nBufLen)
      nBufRead := FREAD(nHandle, @cBuffer, nBufLen)
      lScan    := (nBufRead == nBufLen)
      IF !lScan
        cBuffer := LEFT(cBuffer, nBufRead)
      END
      IF lCr .AND. LEFT(cBuffer, 1) == cLF
        cBuffer := SUBSTR(cBuffer, 2)
      END
      lCr     := (RIGHT(cBuffer, 1) == cCR)
      cBuffer := STRTRAN(STRTRAN(STRTRAN(STRTRAN(STRTRAN(STRTRAN(cBuffer, ;
        cCRLF, cCR), cLF, cCR), cFF, cCR), cNel, cCR), cLS, cCR), cPS, cCR)
      IF !lScan .AND. RIGHT(cBuffer, 1) == cCR
        cBuffer := LEFT(cBuffer, LEN(cBuffer) - 1)
      END
      cScan += cBuffer
    OTHERWISE
      cLine := cScan
      cScan := ''
      lRead := .N.
      nPos  := 1
    END

  END

CASE nType == TXT_UTF16LE

  cCR   := CHR(0x0D) + CHR(0x00)
  cLF   := CHR(0x0A) + CHR(0x00)
  cCRLF := CHR(0x0D) + CHR(0x00) + CHR(0x0A) + CHR(0x00)
  cFF   := CHR(0x0C) + CHR(0x00)
  cNel  := CHR(0x85) + CHR(0x00)
  cLS   := CHR(0x28) + CHR(0x20)
  cPS   := CHR(0x29) + CHR(0x20)

  WHILE EMPTY(nPos)

    nPos := AT(cCR, cScan)
    DO CASE
    CASE !EMPTY(nPos) .AND. !EMPTY(nPos % 2)
      cLine := LEFT(cScan, nPos - 1)
      cScan := SUBSTR(cScan, nPos + 2)
    CASE lScan
      cBuffer  := SPACE(nBufLen)
      nBufRead := FREAD(nHandle, @cBuffer, nBufLen)
      lScan    := (nBufRead == nBufLen)
      IF !lScan
        cBuffer := LEFT(cBuffer, nBufRead - nBufRead % 2)
      END
      IF lCr .AND. LEFT(cBuffer, 2) == cLF
        cBuffer := SUBSTR(cBuffer, 3)
      END
      lCr := (RIGHT(cBuffer, 2) == cCR)
      cBuffer := ;
        PairTran(PairTran(PairTran(PairTran(PairTran(PairTran(cBuffer, ;
        cCRLF, cCR), cLF, cCR), cFF, cCR), cNel, cCR), cLS, cCR), cPS, cCR)
      IF !lScan .AND. RIGHT(cBuffer, 2) == cCR
        cBuffer := LEFT(cBuffer, LEN(cBuffer) - 2)
      END
      cScan += cBuffer
    OTHERWISE
      cLine := cScan
      cScan := ''
      lRead := .N.
      nPos  := 1
    END

  END

CASE nType == TXT_UTF16BE

  cCR   := CHR(0x00) + CHR(0x0D)
  cLF   := CHR(0x00) + CHR(0x0A)
  cCRLF := CHR(0x00) + CHR(0x0D) + CHR(0x00) + CHR(0x0A)
  cFF   := CHR(0x00) + CHR(0x0C)
  cNel  := CHR(0x00) + CHR(0x85)
  cLS   := CHR(0x20) + CHR(0x28)
  cPS   := CHR(0x20) + CHR(0x29)

  WHILE EMPTY(nPos)

    nPos := AT(cCR, cScan)
    DO CASE
    CASE !EMPTY(nPos) .AND. !EMPTY(nPos % 2)
      cLine := LEFT(cScan, nPos - 1)
      cScan := SUBSTR(cScan, nPos + 2)
    CASE lScan
      cBuffer  := SPACE(nBufLen)
      nBufRead := FREAD(nHandle, @cBuffer, nBufLen)
      lScan    := (nBufRead == nBufLen)
      IF !lScan
        cBuffer := LEFT(cBuffer, nBufRead - nBufRead % 2)
      END
      IF lCr .AND. LEFT(cBuffer, 2) == cLF
        cBuffer := SUBSTR(cBuffer, 3)
      END
      lCr := RIGHT(cBuffer, 2) == cCR
      cBuffer := ;
        PairTran(PairTran(PairTran(PairTran(PairTran(PairTran(cBuffer, ;
        cCRLF, cCR), cLF, cCR), cFF, cCR), cNel, cCR), cLS, cCR), cPS, cCR)
      IF !lScan .AND. RIGHT(cBuffer, 2) == cCR
        cBuffer := LEFT(cBuffer, LEN(cBuffer) - 2)
      END
      cScan += cBuffer
    OTHERWISE
      cLine := cScan
      cScan := ''
      lRead := .N.
      nPos  := 1
    END

  END

END

RETURN cLine // FileReadLine

//***************************************************************************

/*

  PAIRTRAN()

  Analog of STRTRAN() for 16 bit Unicode

  This function is a variation of STRTRAN that replaces only at even byte
  boundaries.  It is useful for 16-bit Unicode formats.

  Arguments:
    <cStr>      Required    Unicode byte stream to search in
    <cOldPair>  Required    Unicode byte stream to search for
    <cNewPair>  Required    Unicode byte stream to replace <cOldPair> with

  Returns:
    <cStr>                  Unicode byte stream with replacements

*/

FUNCTION PairTran(cStr, cOldPair, cNewPair)

LOCAL lTran := .Y.
LOCAL nPos  := 0
LOCAL nLen  := LEN(cOldPair)

WHILE lTran
  #ifdef __XCOMPAT__
      nPos := AT(cOldPair, cStr) //, nPos + 1)  Rafa quitado
  #else
  #ifdef __XHARBOUR__   //Xevi Afegit 4/1/2013 distinció amb Harbour
      nPos := AT(cOldPair, cStr, nPos + 1)
  #else
      nPos := HB_AT(cOldPair, cStr, nPos + 1)
  #endif
  #endif
  IF !EMPTY(nPos)
    IF !EMPTY(nPos % 2)
      cStr := STUFF(cStr, nPos, nLen, cNewPair)
    END
  ELSE
    lTran := .N.
  END
END

RETURN cStr // PairTran

//***************************************************************************
