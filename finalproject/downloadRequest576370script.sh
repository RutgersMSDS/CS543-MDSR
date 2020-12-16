#!/bin/sh

usage () {
    cat <<__EOF__
usage: $(basename $0) [-hlp] [-u user] [-X args] [-d args]
  -h        print this help text
  -l        print list of files to download
  -p        prompt for password
  -u user   download as a different user
  -X args   extra arguments to pass to xargs
  -d args   extra arguments to pass to the download program

__EOF__
}

username=HarshiniB
xargsopts=
prompt=
list=
while getopts hlpu:xX:d: option
do
    case $option in
    h)  usage; exit ;;
    l)  list=yes ;;
    p)  prompt=yes ;;
    u)  prompt=yes; username="$OPTARG" ;;
    X)  xargsopts="$OPTARG" ;;
    d)  download_opts="$OPTARG";;
    ?)  usage; exit 2 ;;
    esac
done

if test -z "$xargsopts"
then
   #no xargs option speficied, we ensure that only one url
   #after the other will be used
   xargsopts='-L 1'
fi

if [ "$prompt" != "yes" ]; then
   # take password (and user) from netrc if no -p option
   if test -f "$HOME/.netrc" -a -r "$HOME/.netrc"
   then
      grep -ir "dataportal.eso.org" "$HOME/.netrc" > /dev/null
      if [ $? -ne 0 ]; then
         #no entry for dataportal.eso.org, user is prompted for password
         echo "A .netrc is available but there is no entry for dataportal.eso.org, add an entry as follows if you want to use it:"
         echo "machine dataportal.eso.org login HarshiniB password _yourpassword_"
         prompt="yes"
      fi
   else
      prompt="yes"
   fi
fi

if test -n "$prompt" -a -z "$list"
then
    trap 'stty echo 2>/dev/null; echo "Cancelled."; exit 1' INT HUP TERM
    stty -echo 2>/dev/null
    printf 'Password: '
    read password
    echo ''
    stty echo 2>/dev/null
fi

# use a tempfile to which only user has access 
tempfile=`mktemp /tmp/dl.XXXXXXXX 2>/dev/null`
test "$tempfile" -a -f $tempfile || {
    tempfile=/tmp/dl.$$
    ( umask 077 && : >$tempfile )
}
trap 'rm -f $tempfile' EXIT INT HUP TERM

echo "auth_no_challenge=on" > $tempfile
# older OSs do not seem to include the required CA certificates for ESO
echo "check-certificate=off"  >> $tempfile
if [ -n "$prompt" ]; then
   echo "--http-user=$username" >> $tempfile
   echo "--http-password=$password" >> $tempfile

fi
WGETRC=$tempfile; export WGETRC

unset password

if test -n "$list"
then cat
else xargs $xargsopts wget $download_opts 
fi <<'__EOF__'
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.172/ADP.2019-08-16T12:04:46.172.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.087/ADP.2019-08-16T12:04:46.087.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.552/ADP.2019-08-16T12:04:46.552.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.237/ADP.2019-08-16T12:04:46.237.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.007/ADP.2019-08-16T12:04:46.007.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.782/ADP.2019-08-16T12:04:46.782.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.697/ADP.2019-08-16T12:04:46.697.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.467/ADP.2019-08-16T12:04:46.467.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.322/ADP.2019-08-16T12:04:46.322.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.727/ADP.2019-08-16T12:04:46.727.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.862/ADP.2019-08-16T12:04:45.862.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.062/ADP.2019-08-16T12:04:46.062.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.927/ADP.2019-08-16T12:04:45.927.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.292/ADP.2019-08-16T12:04:46.292.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.442/ADP.2019-08-16T12:04:46.442.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.357/ADP.2019-08-16T12:04:46.357.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.672/ADP.2019-08-16T12:04:46.672.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.127/ADP.2019-08-16T12:04:46.127.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.212/ADP.2019-08-16T12:04:46.212.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.587/ADP.2019-08-16T12:04:46.587.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.823/ADP.2019-08-16T12:04:46.823.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.702/ADP.2019-08-16T12:04:46.702.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.617/ADP.2019-08-16T12:04:46.617.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.897/ADP.2019-08-16T12:04:45.897.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.982/ADP.2019-08-16T12:04:45.982.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.097/ADP.2019-08-16T12:04:46.097.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.182/ADP.2019-08-16T12:04:46.182.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.247/ADP.2019-08-16T12:04:46.247.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.562/ADP.2019-08-16T12:04:46.562.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.792/ADP.2019-08-16T12:04:46.792.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.017/ADP.2019-08-16T12:04:46.017.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.332/ADP.2019-08-16T12:04:46.332.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.102/ADP.2019-08-16T12:04:46.102.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.477/ADP.2019-08-16T12:04:46.477.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.737/ADP.2019-08-16T12:04:46.737.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.507/ADP.2019-08-16T12:04:46.507.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.997/ADP.2019-08-16T12:04:45.997.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.852/ADP.2019-08-16T12:04:45.852.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.917/ADP.2019-08-16T12:04:45.917.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.072/ADP.2019-08-16T12:04:46.072.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.597/ADP.2019-08-16T12:04:46.597.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.137/ADP.2019-08-16T12:04:46.137.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.367/ADP.2019-08-16T12:04:46.367.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.452/ADP.2019-08-16T12:04:46.452.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.682/ADP.2019-08-16T12:04:46.682.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.222/ADP.2019-08-16T12:04:46.222.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.627/ADP.2019-08-16T12:04:46.627.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.712/ADP.2019-08-16T12:04:46.712.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.887/ADP.2019-08-16T12:04:45.887.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.972/ADP.2019-08-16T12:04:45.972.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.382/ADP.2019-08-16T12:04:46.382.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.152/ADP.2019-08-16T12:04:46.152.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.912/ADP.2019-08-16T12:04:45.912.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.762/ADP.2019-08-16T12:04:46.762.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.302/ADP.2019-08-16T12:04:46.302.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.447/ADP.2019-08-16T12:04:46.447.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.677/ADP.2019-08-16T12:04:46.677.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.067/ADP.2019-08-16T12:04:46.067.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.297/ADP.2019-08-16T12:04:46.297.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.532/ADP.2019-08-16T12:04:46.532.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.327/ADP.2019-08-16T12:04:46.327.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.707/ADP.2019-08-16T12:04:46.707.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.882/ADP.2019-08-16T12:04:45.882.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.272/ADP.2019-08-16T12:04:46.272.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.042/ADP.2019-08-16T12:04:46.042.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.947/ADP.2019-08-16T12:04:45.947.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.652/ADP.2019-08-16T12:04:46.652.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.337/ADP.2019-08-16T12:04:46.337.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.567/ADP.2019-08-16T12:04:46.567.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.187/ADP.2019-08-16T12:04:46.187.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.797/ADP.2019-08-16T12:04:46.797.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.422/ADP.2019-08-16T12:04:46.422.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.803/ADP.2019-08-16T12:04:46.803.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.217/ADP.2019-08-16T12:04:46.217.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.162/ADP.2019-08-16T12:04:46.162.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.392/ADP.2019-08-16T12:04:46.392.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.902/ADP.2019-08-16T12:04:45.902.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.772/ADP.2019-08-16T12:04:46.772.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.312/ADP.2019-08-16T12:04:46.312.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.542/ADP.2019-08-16T12:04:46.542.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.227/ADP.2019-08-16T12:04:46.227.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.457/ADP.2019-08-16T12:04:46.457.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.077/ADP.2019-08-16T12:04:46.077.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.687/ADP.2019-08-16T12:04:46.687.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.802/ADP.2019-08-16T12:04:46.802.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.107/ADP.2019-08-16T12:04:46.107.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.717/ADP.2019-08-16T12:04:46.717.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.872/ADP.2019-08-16T12:04:45.872.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.052/ADP.2019-08-16T12:04:46.052.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.282/ADP.2019-08-16T12:04:46.282.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.937/ADP.2019-08-16T12:04:45.937.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.197/ADP.2019-08-16T12:04:46.197.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.202/ADP.2019-08-16T12:04:46.202.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.432/ADP.2019-08-16T12:04:46.432.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.662/ADP.2019-08-16T12:04:46.662.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.117/ADP.2019-08-16T12:04:46.117.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.347/ADP.2019-08-16T12:04:46.347.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.577/ADP.2019-08-16T12:04:46.577.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.813/ADP.2019-08-16T12:04:46.813.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.607/ADP.2019-08-16T12:04:46.607.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.992/ADP.2019-08-16T12:04:45.992.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.362/ADP.2019-08-16T12:04:46.362.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.847/ADP.2019-08-16T12:04:45.847.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.592/ADP.2019-08-16T12:04:46.592.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.512/ADP.2019-08-16T12:04:46.512.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.132/ADP.2019-08-16T12:04:46.132.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.047/ADP.2019-08-16T12:04:46.047.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.277/ADP.2019-08-16T12:04:46.277.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.742/ADP.2019-08-16T12:04:46.742.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.537/ADP.2019-08-16T12:04:46.537.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.767/ADP.2019-08-16T12:04:46.767.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.307/ADP.2019-08-16T12:04:46.307.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.808/ADP.2019-08-16T12:04:46.808.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.252/ADP.2019-08-16T12:04:46.252.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.482/ADP.2019-08-16T12:04:46.482.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.967/ADP.2019-08-16T12:04:45.967.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.777/ADP.2019-08-16T12:04:46.777.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.402/ADP.2019-08-16T12:04:46.402.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.022/ADP.2019-08-16T12:04:46.022.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.397/ADP.2019-08-16T12:04:46.397.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.167/ADP.2019-08-16T12:04:46.167.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.632/ADP.2019-08-16T12:04:46.632.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.657/ADP.2019-08-16T12:04:46.657.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.427/ADP.2019-08-16T12:04:46.427.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.942/ADP.2019-08-16T12:04:45.942.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.142/ADP.2019-08-16T12:04:46.142.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.372/ADP.2019-08-16T12:04:46.372.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.922/ADP.2019-08-16T12:04:45.922.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.667/ADP.2019-08-16T12:04:46.667.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.287/ADP.2019-08-16T12:04:46.287.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.522/ADP.2019-08-16T12:04:46.522.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.752/ADP.2019-08-16T12:04:46.752.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.057/ADP.2019-08-16T12:04:46.057.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.547/ADP.2019-08-16T12:04:46.547.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.317/ADP.2019-08-16T12:04:46.317.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.818/ADP.2019-08-16T12:04:46.818.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.892/ADP.2019-08-16T12:04:45.892.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.262/ADP.2019-08-16T12:04:46.262.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.032/ADP.2019-08-16T12:04:46.032.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.957/ADP.2019-08-16T12:04:45.957.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.492/ADP.2019-08-16T12:04:46.492.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.557/ADP.2019-08-16T12:04:46.557.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.787/ADP.2019-08-16T12:04:46.787.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.177/ADP.2019-08-16T12:04:46.177.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.412/ADP.2019-08-16T12:04:46.412.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.642/ADP.2019-08-16T12:04:46.642.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.437/ADP.2019-08-16T12:04:46.437.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.207/ADP.2019-08-16T12:04:46.207.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.932/ADP.2019-08-16T12:04:45.932.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.867/ADP.2019-08-16T12:04:45.867.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.192/ADP.2019-08-16T12:04:46.192.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.257/ADP.2019-08-16T12:04:46.257.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.487/ADP.2019-08-16T12:04:46.487.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.027/ADP.2019-08-16T12:04:46.027.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.572/ADP.2019-08-16T12:04:46.572.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.342/ADP.2019-08-16T12:04:46.342.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.722/ADP.2019-08-16T12:04:46.722.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.112/ADP.2019-08-16T12:04:46.112.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.517/ADP.2019-08-16T12:04:46.517.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.747/ADP.2019-08-16T12:04:46.747.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.602/ADP.2019-08-16T12:04:46.602.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.987/ADP.2019-08-16T12:04:45.987.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.907/ADP.2019-08-16T12:04:45.907.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.692/ADP.2019-08-16T12:04:46.692.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.082/ADP.2019-08-16T12:04:46.082.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.147/ADP.2019-08-16T12:04:46.147.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.462/ADP.2019-08-16T12:04:46.462.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.232/ADP.2019-08-16T12:04:46.232.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.612/ADP.2019-08-16T12:04:46.612.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.377/ADP.2019-08-16T12:04:46.377.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.002/ADP.2019-08-16T12:04:46.002.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.407/ADP.2019-08-16T12:04:46.407.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.637/ADP.2019-08-16T12:04:46.637.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.877/ADP.2019-08-16T12:04:45.877.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.962/ADP.2019-08-16T12:04:45.962.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.582/ADP.2019-08-16T12:04:46.582.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.857/ADP.2019-08-16T12:04:45.857.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.497/ADP.2019-08-16T12:04:46.497.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.037/ADP.2019-08-16T12:04:46.037.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.122/ADP.2019-08-16T12:04:46.122.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.352/ADP.2019-08-16T12:04:46.352.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.732/ADP.2019-08-16T12:04:46.732.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.502/ADP.2019-08-16T12:04:46.502.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.267/ADP.2019-08-16T12:04:46.267.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.527/ADP.2019-08-16T12:04:46.527.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.757/ADP.2019-08-16T12:04:46.757.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.472/ADP.2019-08-16T12:04:46.472.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.092/ADP.2019-08-16T12:04:46.092.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.977/ADP.2019-08-16T12:04:45.977.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.242/ADP.2019-08-16T12:04:46.242.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.622/ADP.2019-08-16T12:04:46.622.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.012/ADP.2019-08-16T12:04:46.012.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.157/ADP.2019-08-16T12:04:46.157.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.387/ADP.2019-08-16T12:04:46.387.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.417/ADP.2019-08-16T12:04:46.417.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:46.647/ADP.2019-08-16T12:04:46.647.fits"
"https://dataportal.eso.org/dataPortal/api/requests/HarshiniB/576370/SAF/ADP.2019-08-16T12:04:45.952/ADP.2019-08-16T12:04:45.952.fits"

__EOF__
