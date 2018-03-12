set ns [new Simulator]

set tr [open "newreno.tr" w]
$ns trace-all $tr

set ftr [open "newreno.nam" w]
$ns namtrace-all $ftr

$ns color 1 blue
$ns color 2 red
$ns color 3 green
$ns color 4 yellow
$ns color 5 pink
$ns color 6 brown
$ns color 7 black

set s0 [$ns node]
set s1 [$ns node]
set s2 [$ns node]
set s3 [$ns node]
set r4 [$ns node]
set r5 [$ns node]
set d6 [$ns node]
set d7 [$ns node]
set d8 [$ns node]

#sources
$s0 color red
$s1 color red 
$s2 color red
$s3 color red

#routers
$r4 color green
$r5 color green  

#destinations
$d6 color blue
$d7 color blue 
$d8 color blue


# creating link
$ns duplex-link $r4 $r5 .2Mb 100ms DropTail


$ns duplex-link $s0 $r4 1Mb 10ms DropTail
$ns duplex-link $s1 $r4 1Mb 10ms DropTail
$ns duplex-link $s2 $r4 1Mb 10ms DropTail
$ns duplex-link $s3 $r4 1Mb 10ms DropTail

$ns duplex-link $d6 $r5 1Mb 10ms DropTail
$ns duplex-link $d7 $r5 1Mb 10ms DropTail
$ns duplex-link $d8 $r5 1Mb 10ms DropTail

set tcp0 [new Agent/TCP/Newreno]
set tcp1 [new Agent/TCP/Newreno]
set tcp2 [new Agent/TCP/Newreno]
set tcp3 [new Agent/TCP/Newreno]

$tcp0 set fid_ 1
$tcp1 set fid_ 2
$tcp2 set fid_ 3
$tcp3 set fid_ 4

set tcp4 [new Agent/TCPSink]
set tcp5 [new Agent/TCPSink]
set tcp6 [new Agent/TCPSink]

$tcp4 set fid_ 5
$tcp5 set fid_ 6
$tcp6 set fid_ 7

$ns attach-agent $s0 $tcp0
$ns attach-agent $s1 $tcp1
$ns attach-agent $s2 $tcp2
$ns attach-agent $s3 $tcp3
$ns attach-agent $d6 $tcp4
$ns attach-agent $d7 $tcp5
$ns attach-agent $d8 $tcp6


$ns connect $tcp0 $tcp4
$ns connect $tcp1 $tcp4
$ns connect $tcp2 $tcp5
$ns connect $tcp3 $tcp6


set ftp0 [new Application/FTP]
set ftp1 [new Application/FTP]
set ftp2 [new Application/FTP]
set ftp3 [new Application/FTP]

$ftp0 attach-agent $tcp0
$ftp1 attach-agent $tcp1
$ftp2 attach-agent $tcp2
$ftp3 attach-agent $tcp3


proc finish { } {
   global ns tr ftr
   $ns flush-trace
   close $tr
   close $ftr
   exec nam newreno.nam &
   exit
}


# start traffic at time 1.0
$ns at .1 "$ftp0 start"
$ns at .1 "$ftp1 start"
$ns at .1 "$ftp2 start"
$ns at .1 "$ftp3 start"

$ns at 100 "$ftp0 stop"
$ns at 100 "$ftp1 stop"
$ns at 100 "$ftp2 stop"
$ns at 100 "$ftp3 stop"

$ns at 100.5 "finish"



$ns run

#plot "DropTail" using 1:2 with lines, "RED" using 1:2 with lines, "ALTDROP" using 1:2 with lines
