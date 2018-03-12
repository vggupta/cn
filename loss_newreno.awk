BEGIN { 

      time1 = 0.0;
      time2 = 0.0;
      total_bytes=0;

}

{

      time2 = $2;

      if (time2 - time1 > 0.5) 

      {

          thru = (8*total_bytes) / time2;
          thru /= 1000; 
          printf("%f %f\n", time2, thru) >"LossRate_Newreno";
          time1 = $2;

      }

      if ($1=="d" && $3==4 && $4==5 && $5="tcp")  
      {
        total_bytes += $6;
      }

}

END {

    print("Done");

}
