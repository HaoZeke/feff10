!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Information about last revision of $RCSfile: padlib.f90,v $:
! $Revision: 1.3 $
! $Author: hebhop $
! $Date: 2010/02/23 23:52:06 $
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! PAD library:   Packed Ascii Data 
!   these routines contain code for handling packed-ascii-data  
!   (pad) arrays for writing printable character strings that 
!   represent real or complex scalars and arrays to a file.
!
! routines included in padlib are (dp==double precision):
!   wrpadd     write a dp array as pad character strings
!   wrpadx     write a dp complex array as pad character strings
!   rdpadr     read a pad character array as a real array
!   rdpadd     read a pad character array as a dp  array
!   rdpadc     read a pad character array as a complex array
!   rdpadx     read a pad character array as a dp complex array
!   pad        internal routine to convert dp number to pad string
!   unpad      internal routine to pad string to dp number
!
! routines not included, but required by padlib:
!     triml, istrln, wlog
!
!//////////////////////////////////////////////////////////////////////
! Copyright (c) 1997--2001 Matthew Newville, The University of Chicago
! Copyright (c) 1992--1996 Matthew Newville, University of Washington
!
! Permission to use and redistribute the source code or binary forms of
! this software and its documentation, with or without modification is
! hereby granted provided that the above notice of copyright, these
! terms of use, and the disclaimer of warranty below appear in the
! source code and documentation, and that none of the names of The
! University of Chicago, The University of Washington, or the authors
! appear in advertising or endorsement of works derived from this
! software without specific prior written permission from all parties.
!
! THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
! EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
! MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
! IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
! CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
! TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
! SOFTWARE OR THE USE OR OTHER DEALINGS IN THIS SOFTWARE.
!//////////////////////////////////////////////////////////////////////
! License is applicable for routines below, until otherwise specified.
!
       subroutine wrpadd(iout,npack,array,npts)
!
! write a dp array to a file in packed-ascii-data format
!
! inputs:  [ no outputs / no side effects ]
!   iout   unit to write to (assumed open)
!   npack  number of characters to use (determines precision)
!   array  real array 
!   npts   number of array elements to read
! notes:
!   real number converted to packed-ascii-data string using pad
       include 'padlib.h'
       integer    iout, npack, npts, mxl, js, i
       character  str*128
       double precision array(*), xr
       js  = 0
       str = ' '
       mxl = maxlen - npack + 1
       do 20 i = 1, npts
          js = js+npack
          xr = array(i)
          call padx(xr, npack, str(js-npack+1:js))
          if ((js.ge.mxl).or.(i.eq.npts)) then
             write(iout,100) cpadr, str(1:js)
             js = 0
          end if
 20    continue
       return
 100   format(a1,a)
       end
! --padlib--
       subroutine wrpadx(iout,npack,array,npts)
! write complex*16 array as pad string
       include 'padlib.h'
       integer    iout, npack, npts, mxl, js, i
       complex*16 array(*)
       character  str*128
       double precision xr, xi
       js = 0
       str  = ' '
       mxl  = maxlen - 2 * npack + 1
       do 20 i = 1, npts
          js = js  + 2 * npack
          xr = dble(array(i))
          xi = dimag(array(i))
          call padx(xr, npack, str(js-2*npack+1:js-npack))
          call padx(xi, npack, str(js-npack+1:js))
          if ((js.ge.mxl).or.(i.eq.npts)) then
             write(iout,100) cpadc, str(1:js)
             js = 0
          end if
 20    continue
       return
 100   format(a1,a)
       end
! --padlib--
       subroutine wrpadr(iout,npack,array,npts)
!
! write a real array to a file in packed-ascii-data format
!
! inputs:  [ no outputs / no side effects ]
!   iout   unit to write to (assumed open)
!   npack  number of characters to use (determines precision)
!   array  real array 
!   npts   number of array elements to read
! notes:
!   real number converted to packed-ascii-data string using pad
       include 'padlib.h'
       integer    iout, npack, npts, mxl, js, i
       character  str*128
       real    array(*)
       double precision xr
       js  = 0
       str = ' '
       mxl = maxlen - npack + 1
       do 20 i = 1, npts
          js = js+npack
          xr = dble(array(i))
          call padx(xr, npack, str(js-npack+1:js))
          if ((js.ge.mxl).or.(i.eq.npts)) then
             write(iout,100) cpadr, str(1:js)
             js = 0
          end if
 20    continue
       return
 100   format(a1,a)
       end
! --padlib--
       subroutine wrpadc(iout,npack,array,npts)
! write complex (*8) array as pad string
       include 'padlib.h'
       integer    iout, npack, npts, mxl, js, i
       complex    array(*)
       character  str*128
       double precision xr, xi
       js = 0
       str  = ' '
       mxl  = maxlen - 2 * npack + 1
       do 20 i = 1, npts
          js = js  + 2 * npack
          xr = dble(array(i))
          xi = aimag(array(i))
          call padx(xr, npack, str(js-2*npack+1:js-npack))
          call padx(xi, npack, str(js-npack+1:js))
          if ((js.ge.mxl).or.(i.eq.npts)) then
             write(iout,100) cpadc, str(1:js)
             js = 0
          end if
 20    continue
       return
 100   format(a1,a)
       end
! --padlib--
       subroutine rdpadd(iou,npack,array,npts)
! read dparray from packed-ascii-data file
! arguments:
!   iou    unit to read from (assumed open)                   (in)
!   npack  number of characters to use (determines precision) (in)
!   array  real array                                         (out)
!   npts   number of array elements to read / number read     (in/out)
! notes:
!   packed-ascii-data string converted to real array using  unpad
       include 'padlib.h'
       integer iou, npack, npts, ndline, i, istrln, ipts, iread
       double precision    array(*), unpad , tmp
       character  ctest, ccomp
       character  str*128
       external  unpad, istrln, iread
       ccomp = cpadr
       ipts = 0
 10    continue 
          i = iread(iou, str)
          if (i.lt.0) go to 50
          call triml(str)
          ctest  = str(1:1)
          str    = str(2:)
          ndline = i/npack
          if ((ctest.ne.ccomp).or.(ndline.le.0)) go to 200
          do 30 i = 1, ndline
             ipts  = ipts + 1
             tmp   = unpad(str(1-npack+i*npack:i*npack),npack)
             array(ipts) = tmp
             if (ipts.ge.npts) go to 50
 30       continue 
          go to 10
 50    continue 
       return
 200   continue
       call wlog (' -- Read_PAD error:  bad data at line:')
       i = istrln(str)
       call wlog (str(:i))
       stop ' -- fatal error in reading PAD data file -- '
       end
! --padlib--
       subroutine rdpadr(iou,npack,array,npts)
! read real array from packed-ascii-data file
! arguments:
!   iou    unit to read from (assumed open)                   (in)
!   npack  number of characters to use (determines precision) (in)
!   array  real array                                         (out)
!   npts   number of array elements to read / number read     (in/out)
! notes:
!   packed-ascii-data string converted to real array using  unpad
       include 'padlib.h'
       integer iou, npack, npts, ndline, i, istrln, ipts, iread
       real    array(*)
       double precision unpad , tmp
       character  ctest, ccomp
       character  str*128
       external  unpad, istrln, iread
       ccomp = cpadr
       ipts = 0
 10    continue 
          i = iread(iou, str)
          if (i.lt.0) go to 50
          call triml(str)
          ctest  = str(1:1)
          str    = str(2:)
          ndline = i/npack
          if ((ctest.ne.ccomp).or.(ndline.le.0)) go to 200
          do 30 i = 1, ndline
             ipts  = ipts + 1
             tmp   = unpad(str(1-npack+i*npack:i*npack),npack)
             array(ipts) = real(tmp)
             if (ipts.ge.npts) go to 50
 30       continue 
          go to 10
 50    continue 
       return
 200   continue
       call wlog (' -- Read_PAD error:  bad data at line:')
       i = istrln(str)
       call wlog (str(:i))
       stop ' -- fatal error in reading PAD data file -- '
       end
! --padlib--
       subroutine rdpadc(iou,npack,array,npts)
! read complex array from packed-ascii-data file
! arguments:
!   iou    unit to read from (assumed open)                  (in)
!   npack  number of characters to use (determines precision)(in)
!   array  complex array                                     (out)
!   npts   number of array elements to read / number read    (in/out)
! notes:
!   packed-ascii-data string converted to real array using  unpad
       include 'padlib.h'
       integer iou, npack,npts, ndline, i, istrln, ipts, np, iread
       double precision  unpad, tmpr, tmpi
       complex  array(*)
       character  ctest, ccomp
       character  str*128
       external  unpad, istrln, iread
       ccomp = cpadc
       ipts = 0
       np   = 2 * npack
 10    continue 
          i = iread(iou, str)
          if (i.lt.0) go to 50
          call triml(str)
          ctest  = str(1:1)
          str    = str(2:)
          ndline = i / np
          if ((ctest.ne.ccomp).or.(ndline.le.0)) go to 200
          do 30 i = 1, ndline
             ipts = ipts + 1
             tmpr = unpad(str(1-np+i*np:-npack+i*np),npack)
             tmpi = unpad(str(1-npack+i*np:i*np),npack)
             array(ipts) = cmplx(tmpr, tmpi)
             if (ipts.ge.npts) go to 50
 30       continue 
          go to 10
 50    continue 
       return
 200   continue
       call wlog (' -- Read_PAD error:  bad data at line:')
       i = istrln(str)
       call wlog (str(:i))
       stop ' -- fatal error in reading PAD data file -- '
       end
       subroutine rdpadx(iou,npack,array,npts)
! read complex*16 array from packed-ascii-data file
! arguments:
!   iou    unit to read from (assumed open)                  (in)
!   npack  number of characters to use (determines precision)(in)
!   array  complex array                                     (out)
!   npts   number of array elements to read / number read    (in/out)
! notes:
!   packed-ascii-data string converted to real array using  unpad
       include 'padlib.h'
       integer iou, npack,npts, ndline, i, istrln, ipts, np, iread
       double precision  unpad, tmpr, tmpi
       complex*16  array(*)
       character  ctest, ccomp
       character  str*128
       external  unpad, istrln, iread
       ccomp = cpadc
       ipts = 0
       np   = 2 * npack
 10    continue 
          i = iread(iou, str)
          if (i.lt.0) go to 50
          call triml(str)
          ctest  = str(1:1)
          str    = str(2:)
          ndline = i / np
          if ((ctest.ne.ccomp).or.(ndline.le.0)) go to 200
          do 30 i = 1, ndline
             ipts = ipts + 1
             tmpr = unpad(str(1-np+i*np:-npack+i*np),npack)
             tmpi = unpad(str(1-npack+i*np:i*np),npack)
             array(ipts) = tmpr + tmpi*(0.d0,1.d0)
             if (ipts.ge.npts) go to 50
 30       continue 
          go to 10
 50    continue 
       return
 200   continue
       call wlog (' -- Read_PAD error:  bad data at line:')
       i = istrln(str)
       call wlog (str(:i))
       stop ' -- fatal error in reading PAD data file -- '
       end

! --padlib--
       subroutine padx(xreal,npack,str)
!  convert dp number *xreal* to packed-ascii-data string *str*
       include 'padlib.h'
       integer  iexp, itmp, isgn, i, npack, j
       double precision xreal, xwork, xsave,onem, tenth
       parameter (onem  =  0.99999999997d0)
       parameter (tenth =  0.099999999994d0)
       character str*(*)
!
       str      = ' '
       xsave    = min(huge, max(-huge, xreal))
       isgn     = 1
       if (xsave.le.0) isgn = 0
!
       xwork    = dabs( xsave )
       iexp     = 0
       if ((xwork.lt.huge).and.(xwork.gt.tiny))  then
          iexp  =   1 + int(log(xwork) / tenlog  )
       else if (xwork.ge.huge) then
          iexp  = ihuge
          xwork = one
       else if (xwork.le.tiny)  then
          xwork = zero
       end if
! force xwork between ~0.1 and ~1
! note: this causes a loss of precision, but 
! allows backward compatibility
       xwork    = xwork / (ten ** iexp)
 20    continue
       if (xwork.ge.one) then
          xwork = xwork * 0.100000000000000d0
          iexp  = iexp + 1
       else if (xwork.le.tenth) then
          xwork = xwork * ten
          iexp  = iexp - 1
       endif
       if (xwork.ge.one) go to 20

       itmp     = int ( ibas2 * xwork ) 
       str(1:1) = char(iexp  + ioff + ibas2 )
       str(2:2) = char( 2 * itmp + isgn + ioff)
       xwork    = xwork * ibas2 - itmp
       if (npack.gt.2) then
          do 100 i = 3, npack
             itmp     = int( base * xwork + 1.d-9)
             str(i:i) = char(itmp + ioff)
             xwork    = xwork * base - itmp
 100      continue
       end if
       if (xwork.ge.0.5d0) then
          i = itmp + ioff + 1
          if (i.le.126) then
             str(npack:npack)= char(i)
          else 
             j = ichar(str(npack-1:npack-1))
             if (j.lt.126) then
                str(npack-1:npack-1) = char(j+1)
                str(npack:npack)     = char(37)
             endif 
          endif
       endif
       return
       end
! --padlib--
       double precision function unpad(str,npack)
!
!  convert packed-ascii-data string *str* to dp number *unpad*
       include 'padlib.h'
       double precision sum
       integer   iexp, itmp, isgn, i, npack
       character str*(*)
       unpad = zero
       if (npack.le.2) return
       iexp  =     (ichar(str(1:1)) - ioff   ) - ibas2
       isgn  = mod (ichar(str(2:2)) - ioff, 2) * 2 - 1
       itmp  =     (ichar(str(2:2)) - ioff   ) / 2
       sum   = dble(itmp/(base*base))
!       do 100 i = 3, npack
!          sum = sum + dble(ichar(str(i:i)) - ioff) / base**i
! 100   continue
       do 100 i = npack, 3, -1
          sum = sum + dble(ichar(str(i:i)) - ioff) / base**i
 100   continue
       unpad = 2 * isgn * ibase * sum * (ten ** iexp)
!c       print*, sum, iexp,unpad
       return
       end
! --padlib--
! end of pad library
! ----------
       integer function iread(lun,string)
!
! generalized internal read:
!    read a string the next line of an opened file 
!    unit, returning the real length of string
! 
! inputs:   
!   lun     opened file unit number
! outputs:
!   string  string read from file
! returns:
!   iread   useful length of string, as found from 
!                  sending string to 'sclean' to 
!                  remove non-printable characters
!                   and then istrln  
!           or
!              -1   on 'end-of-file'
!              -2   on 'error'
!
! copyright (c) 1999  Matthew Newville
       implicit none
       character*(*) string
       integer    lun, istrln
       external   istrln
       string = ' '
 10    format(a)
       read(lun, 10, end = 40, err = 50) string
       call sclean(string)
       iread = istrln(string)
       return
 40    continue 
       string = ' '
       iread = -1
       return
 50    continue 
       string = ' '
       iread = -2
       return
       end
       subroutine sclean(str) 
!
!  clean a string, especially for strings passed between 
!  different file systems, or from C functions:
!
!   1. characters in the range char(0), or char(10)...char(15) 
!      are interpreted as end-of-line characters, so that all
!      remaining characters are explicitly blanked.
!   2. all other characters below char(31) (including tab) are
!      replaced by a single blank
!
!  this is mostly useful when getting a string generated by a C 
!  function and for handling dos/unix/max line-endings.
!
! copyright (c) 1999  Matthew Newville
       character*(*) str, blank*1
       parameter (blank = ' ')
       integer i,j,is
       do 20 i = 1, len(str)
          is = ichar(str(i:i))
          if ((is.eq.0) .or. ((is.ge.10) .and. (is.le.15))) then
             do 10 j= i, len(str)
                str(j:j) = blank
 10          continue
             return
          elseif (is.le.31)  then
             str(i:i)  = blank
          end if
 20    continue 
       return
! end subroutine sclean
       end

